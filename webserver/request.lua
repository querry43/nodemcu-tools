-- if serving a file, the file is left open for performance..
return function (request)
  local components = {}

  local get = request:match('GET%s+(%S+)')

  if get then
    print('GET: ' .. get)

    local query_string = get:match('?(.*)')
    components['path'] = get:gsub('%?.*', '')
    if components['path'] == '/' then components['path'] = '/index.html' end

    components['query'] = {}

    if query_string then
      for k,v in query_string:gmatch('([^&=?]-)=([^&=?]+)') do
        components['query'][k] = v
      end
    end

    -- check in order of likely request
    if components['path'] then
      if file.open('htdocs' .. components['path'] .. '.lc') then
        components['function'] = dofile('htdocs' .. components['path'] .. '.lc')
        file.close()
      elseif file.open('htdocs' .. components['path']) then
        components['file'] = 'htdocs' .. components['path']
        components['gz'] = false
      elseif file.open('htdocs' .. components['path'] .. '.gz') then
        components['file'] = 'htdocs' .. components['path'] .. '.gz'
        components['gz'] = true
      end
    end
  end

  return components
end
