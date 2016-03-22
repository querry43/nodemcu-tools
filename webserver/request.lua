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
  end

  return components
end
