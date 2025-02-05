# docker-mysql-php-fpm-nginx

A Docker project allowing PHP application development with mysql and nginx.  
It has four containers:

1. MySQL server
2. php-fpm
3. nginx
4. adminer to access the database.  

It also has a very simple database and a page to display the results.  

### How to use

1. [Install Docker.](https://docs.docker.com/get-docker/)
2. Download this project.
3. (Extract project folder and)  
   Open a terminal and go into the project folder:  
   `cd /path/to/project`
4. The passwords for the install are stored in the `secrets` folder.  
   This folder is NOT included in this repo.  
   You have to create it, with the following files, each with only a password inside:
   - db_root_password.txt
   - db_user_password.txt
   - frontend_root_password.txt
   - frontend_user_password.txt  
     Note that the latter two are included for more complicated projects and even if they are not actually used right now, they are set up in the compose.yaml file, so you should provide them anyway.
5. Open Docker Desktop / Settings / Resources / File sharing  
   and add the project folder to Virtual file shares.  
   This is needed to properly mount / bind the password files to the containers.
6. You may use the following commands to pre-download docker images.  
   AFAIK Docker does not keep the original containers, so if you delete them, they will have to be re-downloaded during the next build.
   ```
   docker image pull mysql:latest
   docker image pull php:fpm
   ```
7. Build containers:  
   `docker compose build`  
   (To build containers from scratch:  
   `docker compose build --no-cache`)
8. Run containers in the background:  
   `docker compose up -d`
9. Connect to nginx with a web browser:  
   `localhost:8080`
10. (Optional) Connect to adminer with a web browser:  
    `localhost:8081`  
    (You can find the password in the `secrets` folder.)

#### Caveats

1. The app should autoconnect to the MySQL server with the settings found in the `app/db/settings.php`.  
   If the connection fails, compare the `setting.php` DATABASE_HOST with the names from:  
   `docker ps`  
   (Both containers should be running and listed.)
2. Security in general should be carefully investigated.  
   e.g. check and set bot user and root passwords on containers  
   set up and verify that HTTPS / SSL is working and so on

### TODO

1. Security
2. Update / change adminer as it is no longer maintained.
3. Flash out some more complex database usage examples.

### Links

[Dockerfile reference](https://docs.docker.com/reference/dockerfile)  
[Dockerfile: From Start to Optimized (DockerCon 2023) - YouTube](https://www.youtube.com/watch?v=saSJa9YVroA)  
[Docker CLI reference](https://docs.docker.com/reference/cli/docker/)  
[Docker compose file reference](https://docs.docker.com/reference/compose-file/)  
[Explore Docker's Container Image Repository | Docker Hub](https://hub.docker.com)  
[mysql - Official Image | Docker Hub](https://hub.docker.com/_/mysql)  
[MySQL 8.4 Reference Manual](https://dev.mysql.com/doc/refman/8.4/en/)  
[adminer - Official Image | Docker Hub](https://hub.docker.com/_/adminer)  
[php - Official Image | Docker Hub](https://hub.docker.com/_/php)  
[php - MySQL Improved Extension](https://www.php.net/manual/en/book.mysqli.php)  
[PHP Data Objects](https://www.php.net/manual/en/book.pdo.php)  
[Nginx - Official Image | Docker Hub](https://hub.docker.com/_/nginx)  
[Unprivileged Nginx - Official Image | Docker Hub](https://hub.docker.com/r/nginxinc/nginx-unprivileged)

### Credits

Parts of the Dockerfile content comes from the docs and from official image codes.  
Parts of the MySQL code comes from the [Sakila Sample Database](https://dev.mysql.com/doc/sakila/en/sakila-introduction.html).  
Parts of the PHP code comes from the PHP website.
