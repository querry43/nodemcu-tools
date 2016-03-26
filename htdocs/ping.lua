return function (path, query)
  return 200, '<html>' .. (query['echo'] or 'ok' ) .. '</html>'
end
