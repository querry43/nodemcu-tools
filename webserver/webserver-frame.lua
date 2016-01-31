return function (path, query)
  return 200,
     '<html>'
  ..   '<frameset rows="75, 1*" frameborder="0">'
  ..     '<frame src="/menu"></frame>'
  ..     '<frame name="content" src="' .. (content_path or '') .. '"></frame>'
  ..   '</frameset>'
  ..   'thing'
  .. '</html>'
end
