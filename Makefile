.PHONY: rm
rm:
	docker kill $$(docker ps -q) || true
	docker rm $$(docker ps -a -q) || true
	docker rmi $$(docker images -a -q) || true
	docker volume rm $$(docker volume ls -q) || true
	docker network prune -f

.PHONY: show
show:	
	docker container ls
	docker images -a
	docker volume ls
	docker network ls

.PHONE: build
build:
	docker-compose -f ./deployments/docker-compose.yaml build
	docker-compose -f ./deployments/docker-compose.yaml up -d	

.PHONY: migrate
migrate:
	migrate -path database/migrations/ -database "mysql://root:toor@tcp(localhost:3306)/todo_db" up