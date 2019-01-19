# staged-deployment-configs
```
$ vagrant up
$ vagrant status

$ vagrant ssh consul-server
	$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
	$ consul agent -dev -bind $ip -config-file /vagrant/server.consul.json &

$ consul agent -config-file=desky.consul.json &
$ vagrant ssh web1
	$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
	$ consul agent -advertise $ip -config-file /vagrant/common.consul.json -config-file /home/vagrant/web.service.json &
	$ /vagrant/setup.web.sh
	$ docker ps

$ vagrant ssh lb
	$ ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
	$ consul agent -advertise $ip -config-file /vagrant/common.consul.json -config-file /home/vagrant/lb.service.json &
    $ /vagrant/setup.web.sh
	$ docker ps
    
$ curl --request PUT http://127.0.0.1:8500/v1/agent/service/deregister/175f012c-d347-4257-9ab9-ba4fd9ecaa60
```
