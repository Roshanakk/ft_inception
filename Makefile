# ADDING SOME COLORS
GREEN = \033[0;32m
RED = \033[0;31m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
NC = \033[0m

# VARIABLES
DB = mariadb
WP = wordpress
NGINX = nginx

#This will build the images only
build:
	@echo "$(CYAN)..Creating empty directories on the host machine..$(NC)"
	mkdir -p /home/$(USER)/data/wordpress_data
	mkdir -p /home/$(USER)/data/mariadb_data
	docker compose -f srcs/docker-compose.yml build

#This will start the containers, create volumes and directories. Will also build the images if not yet exist
up:
	@echo "$(GREEN)..Starting containers..$(NC)"
	docker compose -f srcs/docker-compose.yml up -d

#This will stop and remove the containers only
down:
	@echo "$(MAGENTA)..Stopping containers..$(NC)"
	docker compose -f srcs/docker-compose.yml down
	
#This removes all volumes and directories with data
clean: down
	@echo "$(RED)..Removing volumes, directories, images, networks..$(NC)"
	docker volume rm $$(docker volume ls) 2>/dev/null || true
	sudo rm -fr /home/$(USER)/data/wordpress_data
	sudo rm -fr /home/$(USER)/data/mariadb_data
	docker rmi $$(docker images -q) --force 2>/dev/null || true
#	docker system prune --all --force

rebuild: clean build

#This will show all images, containers, volumes and created networks
ls:
	@echo "$(MAGENTA)-> Docker images:$(NC)" && docker images
	@echo "$(MAGENTA)-> All containers:$(NC)" && docker ps -a
	@echo "$(MAGENTA)-> Volumes:$(NC)" && docker volume ls
	@echo "$(MAGENTA)-> Networks:$(NC)" && docker network ls | awk '$$2 !~ /^(bridge|host|none)$$/'

#This will show the logs of all and each of the containers
log-1:
	@echo "$(MAGENTA)..Showing logs from ${DB} container..$(NC)"
	docker compose -f srcs/docker-compose.yml logs ${DB}

log-2:
	@echo "$(MAGENTA)..Showing logs from ${WP} container..$(NC)"
	docker compose -f srcs/docker-compose.yml logs ${WP}

log-3:
	@echo "$(MAGENTA)..Showing logs from ${NGINX} container..$(NC)"
	docker compose -f srcs/docker-compose.yml logs ${NGINX}

logs:
	@echo "$(MAGENTA)..Showing logs from all containers..$(NC)"
	docker compose -f srcs/docker-compose.yml logs

.PHONY: build up down fclean ls logs
