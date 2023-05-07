#!/bin/sh

# Check version compose.
DockerCompose="docker compose"
if ! $DockerCompose >/dev/null 2>&1; then
	if ! command -v docker-compose &> /dev/null; then
		DockerCompose="docker-compose"
	else
		echo "docker compose is required!"
		exit
	fi
fi

# Check source code dirs is exists.
[ ! -d "../laravel-base/" ] && echo "Directory laravel-base DOES NOT exists." &&  exit 0

sudo $DockerCompose up -d

# Build API Admin server
sudo $DockerCompose exec php rm -fr vendor composer.lock
sudo $DockerCompose exec php chmod -R 777 storage bootstrap/cache
sudo $DockerCompose exec php composer install
sleep 5s
#sudo $DockerCompose exec php php artisan key:generate

# Run db migrate
sudo $DockerCompose exec php php artisan migrate
sudo $DockerCompose exec php php artisan db:seed
