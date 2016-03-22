return function (path, query)
  return 200,
     '<html>'
  ..   '<frameset rows="75, 1*" frameborder="0">'
  ..     '<frame src="/menu.html"></frame>'
  ..     '<frame name="content" src="' .. (default_content_path or '') .. '"></frame>'
  ..   '</frameset>'
  .. '</html>'
end
