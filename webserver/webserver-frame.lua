return function (s, path, query)
  s:send(
    'HTTP/1.0 200 OK\r\n\r\n'
    .. '<html>'
    ..   '<frameset rows="75, 1*" frameborder="0">'
    ..     '<frame src="/menu"></frame>'
    ..     '<frame name="content"></frame>'
    ..   '</frameset>'
    ..   'thing'
    .. '</html>'
  )
end
