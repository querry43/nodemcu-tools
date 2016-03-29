return function (s, f, gz)
  file.open(f)
  local contents = file.read(1460)
  file.close()
  s:send(header(200, gz) .. contents)
end
