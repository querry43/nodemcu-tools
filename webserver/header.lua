return function (code, gz)
  print('BEGIN:header.lc:' .. tmr.now())
  local common_headers = 'Connection: close\r\nAccess-Control-Allow-Origin: *\r\n'
  if gz then
    common_headers = common_headers .. 'Content-Encoding: gzip\r\n'
  end

  if code == 200 then
    print('END:header.lc:' .. tmr.now())
    return 'HTTP/1.0 200 OK\r\n' .. common_headers .. '\r\n'
  elseif code == 400 then
    print('END:header.lc:' .. tmr.now())
    return 'HTTP/1.0 400 Bad Request\r\n' .. common_headers .. '\r\nBad Request'
  elseif code == 404 then
    print('END:header.lc:' .. tmr.now())
    return 'HTTP/1.0 404 Not Found\r\n' .. common_headers .. '\r\nPage not found'
  else
    print('END:header.lc:' .. tmr.now())
    return 'HTTP/1.0 500 Internal Server Error\r\n' .. common_headers .. '\r\nInternal Server Error'
  end
end
