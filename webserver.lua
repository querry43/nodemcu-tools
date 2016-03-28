return function ()
  local function process_request(s, request)
    print('BEGIN:process_request:' .. tmr.now())
    local request = dofile('webserver/request.lc')(request)
    print('got request:' .. tmr.now())

    if request['path'] then
      print('got path:' .. tmr.now())
      if dofile('file/exists.lc')('htdocs' .. request['path']) then
        print('is static file:' .. tmr.now())
        dofile('webserver/serve-file.lc')(s, 'htdocs' .. request['path'], false)
      elseif dofile('file/exists.lc')('htdocs' .. request['path'] .. '.gz') then
        dofile('webserver/serve-file.lc')(s, 'htdocs' .. request['path'] .. '.gz', true)
      elseif dofile('file/exists.lc')('htdocs' .. request['path'] .. '.lc') then
        local status, response = dofile('htdocs' .. request['path'] .. '.lc')(request['path'], request['query'])
        s:send(dofile('webserver/header.lc')(status, false) .. response)
      else
        s:send(dofile('webserver/header.lc')(404, false))
      end
    else
      s:send(dofile('webserver/header.lc')(400, false))
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
