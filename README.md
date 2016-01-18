network.lua
-----------
Persistent network configuration for access points and access point clients.

Configuration table:

    NetworkConfig = {
        mode = 'ap' -- ap or station
        ssid = 'esp'
        pass = nil
        ip = '192.168.1.1'
        netmask = '255.255.255.0'
        gateway = nil
    }

Load stored or default config:

    Network:load()

Save in memory config:

    Network:save()

Reset config to defaults:

    Network:reset()

Start network using loaded config:

    Network:start()

Display in memory config:

    Network:display_config()

Display current network status:

    Network:display_status()
