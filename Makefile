-include .env
export

build:
	docker-compose build
clusterup:
	docker-compose -f docker-compose.yaml up -d
	docker logs m-rundeck -f

clusterdown:
	docker-compose -f docker-compose.yaml down

slaveip:
	docker inspect -f "{{ .NetworkSettings.IPAddress }}" s-rundeck

run:
	curl --location --request POST 'http://localhost:4440/api/21/job/903137e5-739a-40cf-ad24-fe4acd89e250/run' \
	--header 'Accept: application/json' \
	--header 'X-Rundeck-Auth-Token: FvWvDALn8UypClmHAKCqil8Vul73xgLH' \
	--header 'Content-Type: application/json' \
	--data-raw ''
#
#	curl -D - \
#		-X "POST" -H "Accept: application/json" \
#		-H "Content-Type: application/json" \
#		-H "X-Rundeck-Auth-Token: FvWvDALn8UypClmHAKCqil8Vul73xgLH" \
#		-d "{\"argString\":\" -servername my-server -foldername my-folder \"}" \
#		http://127.0.0.1:4440/api/1/job/903137e5-739a-40cf-ad24-fe4acd89e250/executions
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