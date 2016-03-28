request_lc = dofile('webserver/request.lc')
exists_lc = dofile('file/exists.lc')
serve_file_lc = dofile('webserver/serve-file.lc')
header_lc = dofile('webserver/header.lc')

return function ()
  local function process_request(s, request)
    print('BEGIN:process_request:' .. tmr.now())
    local request = request_lc(request)
    print('got request:' .. tmr.now())

    if request['path'] then
      print('got path:' .. tmr.now())
      if exists_lc('htdocs' .. request['path']) then
        print('is static file:' .. tmr.now())
        serve_file_lc(s, 'htdocs' .. request['path'], false)
      elseif exists_lc('htdocs' .. request['path'] .. '.gz') then
        serve_file_lc(s, 'htdocs' .. request['path'] .. '.gz', true)
      elseif exists_lc('htdocs' .. request['path'] .. '.lc') then
        local status, response = dofile('htdocs' .. request['path'] .. '.lc')(request['path'], request['query'])
        s:send(header_lc(status, false) .. response)
      else
        s:send(header_lc(404, false))
      end
    else
      s:send(header_lc(400, false))
    end

    print('closing:' .. tmr.now())
    s:close()

    print('garbage collect:' .. tmr.now())
    collectgarbage()
    print('END:process_request:' .. tmr.now())
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    sock:on("receive", process_request)
  end)
end
