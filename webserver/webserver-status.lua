return function (s, path, query)
  local majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed = node.info()
  local ap_ip, ap_netmask, ap_gateway = wifi.ap.getip()
  local sta_ip, sta_netmask, sta_gateway = wifi.sta.getip()

  s:send(
    'HTTP/1.0 200 OK\r\n\r\n'
      .. '<div style="text-align:center">'
      ..   '<h2>Status</h2>'
      ..     '<table style="margin-left:auto; margin-right:auto;">'
      ..       '<tr><td colspan="2" style="text-align:center">Software</td></tr>'
      ..       '<tr><td>NodeMCU Version:</td><td>' .. majorVer .. '.' .. minorVer .. '.' .. devVer .. '</td></tr>'
      ..       '<tr><td>Heap:</td><td>' .. node.heap() .. '</td></tr>'
      ..       '<tr><td height="10"  colspan="2" style="text-align:center">Access Point</td></tr>'
      ..       '<tr><td>AP Name:</td><td>' .. Network.ap_ssid .. '</td></tr>'
      ..       '<tr><td>AP IP:</td><td>' .. ap_ip .. '</td></tr>'
      ..       '<tr><td>AP Netmask:</td><td>' .. ap_netmask .. '</td></tr>'
      ..       '<tr><td>AP Gateway:</td><td>' .. ap_gateway .. '</td></tr>'
      ..       '<tr><td height="10"  colspan="2" style="text-align:center">Wifi Client</td></tr>'
      ..       '<tr><td>Wifi Name:</td><td>' .. Network.sta_ssid .. '</td></tr>'
      ..       '<tr><td>Wifi IP:</td><td>' .. (sta_ip or '') .. '</td></tr>'
      ..       '<tr><td>Wifi Netmask:</td><td>' .. (sta_netmask or '') .. '</td></tr>'
      ..       '<tr><td>Wifi Gateway:</td><td>' .. (sta_gateway or '') .. '</td></tr>'
      ..       '<tr><td height="10" colspan="2" style="text-align:center">Hardware</td></tr>'
      ..       '<tr><td>Chip ID:</td><td>' .. chipid .. '</td></tr>'
      ..       '<tr><td>Flash ID:</td><td>' .. flashid .. '</td></tr>'
      ..       '<tr><td>Flash Size:</td><td>' .. flashsize .. '</td></tr>'
      ..       '<tr><td>Flash Mode:</td><td>' .. flashmode .. '</td></tr>'
      ..       '<tr><td>Flash Speed:</td><td>' .. flashspeed .. '</td></tr>'
      ..     '</table>'
      .. '</div>'
  )
end
