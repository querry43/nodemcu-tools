return function (filename)
  print('BEGIN:exists.lc(' .. filename .. '):' .. tmr.now())
  if file.open(filename) then
    file.close()
    print('END:exists.lc(' .. filename .. '):' .. tmr.now())
    return true
  end
  print('END:exists.lc(' .. filename .. '):' .. tmr.now())
  return false
end
