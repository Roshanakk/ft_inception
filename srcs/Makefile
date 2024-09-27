all: build up 

build:
	mkdir -p /home/$(USER)/data/wp_data
	mkdir -p /home/$(USER)/data/db_data
	docker compose build --no-cache

up: 
	docker compose up -d

log1: 
	docker exec nginrox bash -c "cat /var/log/nginx/error.log"

log2: 
	docker exec wordpressrox bash -c "cat /var/log/php7.4-fpm.log"

log3: 
	docker compose logs dbrox


down:
	docker compose down

status:
	docker ps -a && docker images && docker volume ls && docker network ls

clean: down
	docker container prune -f && \
	docker image prune -af && \
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true && \
	docker network rm $$(docker network ls -q) 2>/dev/null || true && \
	rm -rf /home/$(USER)/data/wp_data && \
	rm -rf /home/$(USER)/data/db_data 
	

fclean: clean
	docker system prune -a

re: down clean all