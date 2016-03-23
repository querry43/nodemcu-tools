return function (filename)
  local contents = {}
  if file.open(filename, 'r') then
    local line = ''
    repeat
      local key, val = line:match('^(.*)|(.*)\n')
      if key then
        contents[key] = val
      end
      line = file.readline()
    until line == nil
    file.close()
  end
  return contents
end
