return function (filename)
  if file.open(filename) then
    file.close()
    return true
  end
  return false
end
