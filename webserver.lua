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
  local function handle_receive(s, request, session)
    local request = parse_request(request)

    if request['file'] then
      session['file'] = request['file']
      session['pos'] = 0
      session['gz'] = request['gz']
      serve_file(s, session)
    elseif request['function'] then
      local status, response = request['function'](request['path'], request['query'])
      s:send(header(status, false) .. response)
      s:close()
    else
      s:send(header(404, false))
      s:close()
    end

    collectgarbage()
  end

  local function handle_sent(s, request, session)
    if session['file'] then
      serve_file(s, session, false)
    else
      s:close()
    end

    collectgarbage()
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    local session = {}
    sock:on('receive', function(s, request) handle_receive(s, request, session) end)
    sock:on('sent', function(s, request) handle_sent(s, request, session) end)
  end)
end
