# docker-compose-laravel
A pretty simplified Docker Compose workflow that sets up a LEMP network of containers for local Laravel development. You can view the full article that inspired this repo [here](https://dev.to/aschmelyun/the-beauty-of-docker-for-local-laravel-development-13c0).


## Usage

`docker-compose up -d --build site`

- **nginx** - `:80`
- **mysql** - `:3306`
- **php** - `:9000`
- **redis** - `:6379`
- **mailhog** - `:8025` 



## Permissions Issues

If you encounter any issues with filesystem permissions while visiting your application or running a container command, try completing the following steps:

- Bring any container(s) down with `docker-compose down`
- Copy the `.env.example` file in the root of this repo to `.env`
- Modify the values in the `.env` file to match the user/group that the `src` directory is owned by on the host system
- Re-build the containers by running `docker-compose build --no-cache`

Then, either bring back up your container network or re-run the command you were trying before, and see if that fixes it.

