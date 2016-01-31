load-all.lua and init.lua
-------------------------
Load all tools.  init.lua loads load-all.lua from a timer to avoid boot issues.


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

    WebServerPages['request_pattern1'] = function(path, query_string) return 200, 'hi there' end

*Sample pages*

    WebServerPages['^/network'] = function(path, query) return dofile('webserver-network.lua')(path, query) end
    WebServerPages['^/status'] = function(path, query) return dofile('webserver-status.lua')(path, query) end
    WebServerPages['^/$'] = function(path, query) return dofile('webserver-frame.lua')(path, query) end
    WebServerPages['^/menu'] = function(path, query) return dofile('webserver-menu.lua')(path, query) end

		
read-psv.lua and write-psv.lua
------------------------------
Read and write configuration data to file.

    local tab = dofile('read-psv.lua')(my_file)
    dofile('write-psv.lua')(my_file, tab)
