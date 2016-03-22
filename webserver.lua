return function ()
  local function process_request(s, request)
    local request = dofile('webserver/request.lc')(request)
    local is_404 = true

    if request['path'] then
      do
        if file.open('htdocs' .. request['path']) then
          local contents = ''
          local line = ''

          repeat
            contents = contents .. line
            line = file.readline()
          until line == nil

          file.close()

          is_404 = false

          s:send(dofile('webserver/header.lc')(200) .. contents)
        end
      end

      if is_404 then
        if file.open('htdocs' .. request['path'] .. '.lc') then
          file.close()
          is_404 = false
          local status, response = dofile('htdocs' .. request['path'] .. '.lc')(request['path'], request['query'])
          s:send(dofile('webserver/header.lc')(status) .. response)
        end
      end
    end

    if is_404 then
      s:send(dofile('webserver/header.lc')(404))
    end

    s:close()

    collectgarbage()
  end

  local s = net.createServer(net.TCP, 10)
  s:listen(80, function(sock)
    sock:on("receive", process_request)
  end)
end
