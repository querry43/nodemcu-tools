return function (filename, contents)
  file.open(filename, 'w+')
  for k, v in pairs(contents) do
    file.writeline(k .. '|' .. v)
  end
  file.close()
end
