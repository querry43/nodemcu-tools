return function (s, f, gz)
  print('BEGIN:serve-file.lc:' .. tmr.now())
  file.open(f)
  local contents = file.read(1460)
  file.close()
  s:send(dofile('webserver/header.lc')(200, gz) .. contents)
  print('END:serve-file.lc:' .. tmr.now())
end
