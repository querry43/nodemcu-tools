Network = {
  ap_ssid = 'esp' .. node.chipid(),
  sta_ssid = '',
}

function Network:load()
  wifi.setmode(wifi.SOFTAP)
  wifi.ap.config({ssid = Network.ap_ssid})
  Network.sta_ssid = ''

  local config = dofile('file/read-psv.lc')('network.cfg')

  if config.ssid then
    wifi.setmode(wifi.STATIONAP)
    Network.sta_ssid = config.ssid

    wifi.sta.config(config.ssid, config.pass or "")
    if config.ip then
      wifi.sta.setip({ip = config.ip, netmask = config.netmask, gateway = config.gateway})
    end
    
    wifi.sta.connect()
  end
end

function Network:reset()
  file.remove('network.cfg')
end

function Network:save(cfg)
  dofile('file/write-psv.lc')('network.cfg', cfg)
end
