return function (s, path, query)
  s:send(
    'HTTP/1.0 200 OK\r\n\r\n'
    .. '<html>'
    .. '<ul>'
    .. '<li><a href="/status" target="content">status</a></li>'
    .. '<li><a href="/network" target="content">network</a></li>'
    .. '</ul>'
    .. '</html>'
  )
end
