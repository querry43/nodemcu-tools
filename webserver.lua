return function ()
  local function process_request(s, request)
    local request = dofile('webserver/request.lc')(request)

    if request['path'] then
      if dofile('file/exists.lc')('htdocs' .. request['path']) then
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

    s:close()

    collectgarbage()
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    sock:on("receive", process_request)
  end)
end
