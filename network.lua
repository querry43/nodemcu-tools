Network = { }
NetworkConfig = { }

function Network:load()
  if file.open('network.cfg', 'r') then
    local line = ''
    repeat
      local key, val = line:match('^(.*)|(.*)\n')
      if key then
        NetworkConfig[key] = val
      end
      line = file.readline()
    until line == nil
    file.close()
  else
    self:reset()
  end
end

function Network:start()
  if NetworkConfig.mode == 'ap' then
    print('Creating access point "' .. NetworkConfig.ssid .. '"')
    if NetworkConfig.pass then
      print('  with password "' .. NetworkConfig.pass .. '"')
    end

    wifi.setmode(wifi.SOFTAP)

    wifi.ap.setip({ip = NetworkConfig.ip, netmask = NetworkConfig.netmask, gateway = NetworkConfig.ip});
    wifi.ap.config({ssid = NetworkConfig.ssid, pwd = NetworkConfig.pass})

    self:display_status()
  else
    print('Connecting to access point "' .. NetworkConfig.ssid .. '"')
    if NetworkConfig.pass then
      print('  with password "' .. NetworkConfig.pass .. '"')
    end

    wifi.setmode(wifi.STATION)
    wifi.sta.config(NetworkConfig.ssid, NetworkConfig.pass)
    if NetworkConfig.ip then
      wifi.sta.setip({ip = NetworkConfig.ip, netmask = NetworkConfig.netmask, gateway = NetworkConfig.gateway})
    end
    wifi.sta.connect()

    function wait_for_conection()
      if wifi.sta.status() == 5 then
        print('connected')
        self:display_status()
        tmr.stop(0)
      else
        print('.')
      end
    end

    tmr.alarm(0, 1000, 1, function()
      wait_for_conection()
    end )
  end
end

function Network:display_status()
  if NetworkConfig.mode == 'ap' then
    print(wifi.ap.getip())
  else
    print(wifi.sta.getip())
  end
end

function Network:reset()
  file.remove('network.cfg')

  NetworkConfig.mode = 'ap'
  NetworkConfig.ssid = 'esp'
  NetworkConfig.pass = nil
  NetworkConfig.ip = '192.168.1.1'
  NetworkConfig.netmask = '255.255.255.0'
  NetworkConfig.gateway = nil
end

function Network:display_config()
  for k, v in pairs(NetworkConfig) do
    print('"' .. k .. '" = "' .. v .. '"')
  end
end

function Network:save()
  print(file.open('network.cfg', 'w+'))

  for k, v in pairs(NetworkConfig) do
    file.writeline(k .. '|' .. v)
  end

  file.close()
end
