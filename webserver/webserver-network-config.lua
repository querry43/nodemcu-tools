return function(s, path, query)
  if query and query.ssid then
    s:send(
      'HTTP/1.0 200 OK\r\n\r\n'
        .. '<html>'
        ..   'restarting... please wait'
        ..   '<script type="text/javascript">'
        ..     'setTimeout(function() { window.location.href = "' .. path .. '" }, 10000);'
        ..   '</script>'
        .. '</html>'
    )
    s:close()

    if (query.reset) then
      Network:reset()
    else
      query.mode = nil
      Network:save(query)
    end

    tmr.alarm(1, 1000, 0, function()
      Network:load()
    end )
  else
    local config = dofile('read-psv.lua')('network.cfg')

    s:send(
      'HTTP/1.0 200 OK\r\n\r\n'
        .. '<html>'
        .. '<div style="text-align:center">'
        .. '<form method="get">'
        ..   '<h2>Join Wifi Network</h2>'
        ..     '<table style="margin-left:auto; margin-right:auto;">'
        ..       '<tr><td>MAC:</td><td>' .. (wifi.sta.getmac() or "") .. '</td></tr>'
        ..       '<tr><td>SSID:</td><td><input type="text" name="ssid" value="' .. (config.ssid or "") .. '"></td></tr>'
        ..       '<tr><td>Password:</td><td><input type="text" name="pass" value="' .. (config.pass or "") .. '"></td></tr>'
        ..       '<tr><td height="10" colspan="2" style="text-align:center">'
        ..         '<select id="select_mode" name="mode" onchange="disable_fields()">'
        ..           '<option>dhcp</option>'
        ..           '<option' .. (config.ip and ' selected' or '') .. '>static</option>'
        ..         '</select>'
        ..       '</td></tr>'
        ..       '<tr><td>IP:</td><td><input class="static_only" type="text" name="ip" value="' .. (config.ip or "") .. '"></td></tr>'
        ..       '<tr><td>Netmask:</td><td><input class="static_only" type="text" name="netmask" value="' .. (config.netmask or "") .. '"></td></tr>'
        ..       '<tr><td>Gateway:</td><td><input class="static_only" type="text" name="gateway" value="' .. (config.gateway or "") .. '"></td></tr>'
        ..     '</table>'
        .. '<input type="submit" value="Set">'
        .. '<input name="reset" type="submit" value="Reset">'
        .. '</form>'
        .. '</div>'
        .. '<script type="text/javascript">'
        ..   'function disable_fields() {'
        ..     'var static_only_inputs = document.getElementsByClassName("static_only");'
        ..     'var is_dhcp = document.getElementById("select_mode").value == "dhcp";'
        ..     'for (i = 0; i < static_only_inputs.length; i++) {'
        ..       'static_only_inputs[i].disabled = is_dhcp;'
        ..       'if (is_dhcp) { static_only_inputs[i].value = "" }'
        ..     '}'
        ..   '}'
        ..   'disable_fields();'
        .. '</script>'
        .. '</html>'
    )
  end
end
