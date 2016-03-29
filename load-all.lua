dofile('network.lc')
Network:load()

inline_functions = true
dofile('webserver.lc')()

default_content_path = '/status'
