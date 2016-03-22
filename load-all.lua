dofile('network.lc')
Network:load()

dofile('webserver.lc')()

default_content_path = '/status'
