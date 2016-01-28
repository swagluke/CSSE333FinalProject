import cherrypy
import mysql.connector
import os
config =  {
		'user': 'admin',
		'password':'password',
		'host':'cookchain.c54zb7ekkufg.us-west-2.rds.amazonaws.com',
		'database':'cookchain'
}
class HelloWorld(object):
   	@cherrypy.expose
    def login(self):
        return "Hello World!"
    @cherrypy.expose
    def create(self,username,password):
    	cnx = mysql.connector.connect(**config)
    	cursor = cnx.cursor()
    	query = ('INSERT INTO Users(username,password)' 'VALUES(%s,%s)')
    	data = (username,password)
    	cursor = execute(query,data)
    	return "username" + username + "password" + password

if __name__ == '__main__':
        conf = {
                'global': {
                'server.max_request_body_size': 0
                },
                '/': {
                        'tools.sessions.on' : True,
                        'tools.staticdir.root' : os.path.abspath(os.getcwd())
                },
                '/static': {
                        'tools.staticdir.on': True,
                        'tools.staticdir.dir': './staticFiles'
                }
        }

cherrypy.server.socket_host = '0.0.0.0'
cherrypy.quickstart(HelloWorld(),'/',conf)
