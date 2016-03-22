return function (code)
  local status_headers = {}
  status_headers[200] = 'HTTP/1.0 200 OK\r\n\r\n'
  status_headers[404] = 'HTTP/1.0 404 Not Found\r\n\r\nPage not found'
  status_headers[500] = 'HTTP/1.0 500 Internal Server Error\r\n\r\nInternal Server Error'

  if not status_headers[code] then code = 500 end

  return status_headers[code]
end
