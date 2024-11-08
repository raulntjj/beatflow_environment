ENV_FILE = --env-file ./docker/.env.docker

build:
	- chmod +x ./docker/build.sh
	- ./docker/build.sh
	- docker compose $(ENV_FILE) up -d
	- docker compose $(ENV_FILE) logs -f api app
	
kill:
	- docker stop api app nginx db myadmin
	- docker rm api app nginx db myadmin
	- docker system prune -af --volumes
	- rm -r app api .docker

start:
	- docker start api app nginx db myadmin

stop:
	- docker stop api app nginx db myadmin

restart:
	- docker restart api app nginx db myadmin

logs:
	- docker compose $(ENV_FILE) logs -f

shell:
	- docker compose $(ENV_FILE) exec api /bin/bash

test:
	- docker compose $(ENV_FILE) exec api php artisan test

clean:
	- docker system prune -af --volumes

down:
	- docker compose $(ENV_FILE) down

up:
	- docker compose $(ENV_FILE) up -d --build

reset: 
	- docker compose $(ENV_FILE) down --volumes --remove-orphans
	- docker system prune -af --volumes

migrate:
	- docker compose $(ENV_FILE) exec api php artisan migrate

install:
	- docker compose $(ENV_FILE) exec api composer install
	- docker compose $(ENV_FILE) exec api php artisan key:generate

update:
	- docker compose $(ENV_FILE) exec api composer update

uninstall:
	- rm -r docker --force
	- rm docker-compose.yml --force
	- rm Dockerfile --force
	- rm Makefile --force

.PHONY: build kill start stop restart logs shell test migrate install update clean down up reset uninstall
