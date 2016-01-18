WebServerPages = { }

return function ()
  local function process_request(s, request)
    local request = request:match('GET%s+(%S+)')
    local is_404 = true

    if request then
      local query_string = request:match('?(.*)')
      local path = request:gsub('%?.*', '')
      local query = {}

      if query_string then
        for k,v in query_string:gmatch('([^&=?]-)=([^&=?]+)') do
          query[k] = v
        end
      end

      for k, v in pairs(WebServerPages) do
        if request:match(k) then
          is_404 = false
          v(s, path, query)
          break
        end
      end
    end

    if is_404 then
      s:send('HTTP/1.0 404 Not Found\r\n\r\nPage not found')
    end

    s:close()

    collectgarbage()
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    sock:on("receive", process_request)
  end)
end
