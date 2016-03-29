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
Webserver capable of serving static and dynamic files from the htdocs/ directory.

Start the webserver:

    dofile('webserver.lua')()

*Sample pages*

There are a number of sample pages in htdocs/ including basic network config and menu support as well as stress tests.
		
The frame.lua page loads /menu.html in an upper frame and an empty page in a lower frame.  Change the default lower frame path by setting default_content_path.

*Performance*

It is possible to increase performance at the cost of ~ 4k of memory with this setting prior to loading the server:

    inline_functions = true

With inlined functions:

 - 20 static pages / second
 - 3.3 compressed static pages / second
 - 1.6 dynamic pages / second

Without inlined functions:

 - 1.5 static pages / second
 - 1.1 compressed static pages / second
 - 1.1 dynamic pages / second


file/exists.lua
------------------------------
Return true if a file exists.

    local exists = dofile('file/exists.lua')(my_file)

		
file/read-psv.lua and file/write-psv.lua
------------------------------
Read and write configuration data to file.

    local tab = dofile('file/read-psv.lua')(my_file)
    dofile('file/write-psv.lua')(my_file, tab)
