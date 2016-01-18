network.lua
-----------
Persistent network configuration for access points and access point clients.  This configuration always exposes an access point and optionally connects to an existing wifi network.

Configuration:

    Network.ap_ssid = 'ap name'

Load stored or default config:

    Network:load()

Save in memory config:

    Network:save({
      ssid = 'my network',
      pass = nil,
      ip = '192.168.1.1',
      netmask = '255.255.255.0',
      gateway = nil,
    })

Reset config to defaults:

    Network:reset()


webserver.lua
-------------
Webserver with configurable routes.  These routes to callbacks can be configured at any time, even while the server is running.

Start the webserver:

    dofile('webserver.lua')()

Add a page to the page table:

    WebServerPages['request_pattern1'] = function(sock, path, query_string)

*Sample pages*

 * webserver-network-config.lua - configure the network from /network
 * webserver-status.lua - display hardware and software status from /status


read-psv.lua and write-psv.lua
------------------------------
Read and write configuration data to file.

    local tab = dofile('read-psv.lua')(my_file)
    dofile('write-psv.lua')(my_file, tab)
