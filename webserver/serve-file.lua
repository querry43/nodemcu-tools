return function (s, f, gz)
  local contents = file.read(1460)
  file.close()
  s:send(header(200, gz) .. contents)
end
