if inline_functions then
  parse_request = dofile('webserver/request.lc')
  serve_file = dofile('webserver/serve-file.lc')
  header = dofile('webserver/header.lc')
else
  parse_request = function(r) return dofile('webserver/request.lc')(r) end
  serve_file = function(s, f, gz) return dofile('webserver/serve-file.lc')(s, f, gz) end
  header = function(s, gz) return dofile('webserver/header.lc')(s, gz) end
end

return function ()
  local function process_request(s, request)
    local request = parse_request(request)

    if request['file'] then
      serve_file(s, request['file'], request['gz'])
    elseif request['function'] then
      local status, response = request['function'](request['path'], request['query'])
      s:send(header(status, false) .. response)
    else
      s:send(header(404, false))
    end

    s:close()

    collectgarbage()
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    sock:on("receive", process_request)
  end)
end
