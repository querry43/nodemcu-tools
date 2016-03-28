return function (request)
  print('BEGIN:request.lc:' .. tmr.now())
  local components = {}

  local get = request:match('GET%s+(%S+)')

  if get then
    print('GET: ' .. get)

    local query_string = get:match('?(.*)')
    components['path'] = get:gsub('%?.*', '')
    if components['path'] == '/' then components['path'] = '/index.html' end

    print('parsing query params:' .. tmr.now())
    components['query'] = {}

    if query_string then
      for k,v in query_string:gmatch('([^&=?]-)=([^&=?]+)') do
        components['query'][k] = v
      end
    end
  end

  print('END:request.lc:' .. tmr.now())

  return components
end
