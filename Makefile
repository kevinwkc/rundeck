-include .env
export

clusterup:
	docker-compose -f docker-compose.yaml up -d
	docker logs m-rundeck -f

clusterdown:
	docker-compose -f docker-compose.yaml down

slaveip:
	docker inspect -f "{{ .NetworkSettings.IPAddress }}" s-rundeck

server:
	#https://docs.rundeck.com/docs/administration/install/docker.html#running-docker-images
	#docker run --name some-rundeck -p 4440:4440 -v data:/home/rundeck/server/data rundeck/rundeck:3.3.10
	docker run -d --name my-rundeck -p 127.0.0.1:4440:4440 -v /d/tmp:/home/rundeck/data batix/rundeck-ansible
	docker logs -f my-rundeck

sdebug:
	docker exec --privileged -u root -it m-rundeck bash
api:
	#https://docs.rundeck.com/docs/api/rundeck-api.html#api-version-number

clean:
	-docker stop my-rundeck
	-docker rm my-rundeck