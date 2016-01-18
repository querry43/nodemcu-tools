WebServer = {
  port = 80,
  _s = nil,
}

WebServerPages = { }

function WebServer:start()
  self._s = net.createServer(net.TCP, 15)
  self._s:listen(self.port, function(sock)
    sock:on("receive", WebServer._process_request)
  end)
end

function WebServer:stop()
  self._s:close()
  self._s = nil
end

function WebServer._process_request(sock, data)
    local request = data:match('GET%s+(%S+)')
    local is_404 = true

    if request then
      local query_string = request:match('?(.*)')
      local path = request:gsub('%?.*', '')

      for k, v in pairs(WebServerPages) do
        if request:match(k) then
          is_404 = false
          sock:send('HTTP/1.0 200 Accepted\r\n\r\n')
          v(sock, path, query_string)
          break
        end
      end
    end

    if is_404 then
      sock:send('HTTP/1.0 404 Not Found\r\n\r\nPage not found')
    end

    sock:close()
end
