return function (s, session)
  if session['pos'] > 0 then
    file.open(session['file'])
    file.seek('set', session['pos'])
  end

  local contents = file.read(1000)
  file.close()

  if session['pos'] > 0 then
    s:send(contents)
  else
    s:send(header(200, session['gz']) .. contents)
  end

  if string.len(contents) < 1000 then
    session['file'] = nil
    session['pos'] = nil
    session['gz'] = nil
  else
    session['pos'] = session['pos'] + 1000
  end
end
