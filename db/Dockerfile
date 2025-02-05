# syntax=docker/dockerfile:1.4

#    Copyright (C) 2025  nghfp9wa7bzq@gmail.com

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


FROM mysql:latest

ARG DB_USER_PASSWORD_FILE
ARG DOCKER_USER_NAME
ARG DOCKER_DB_NAME
ARG MYSQL_ROOT_PASSWORD_FILE

# Note that the generater password is in the docker logs!
ENV MYSQL_RANDOM_ROOT_PASSWORD=yes
# Because a build arg does not persist
# until docker-entrypoint.sh is run and if I attach the secret to the container
# it will always be attached - so you can just read out the password from the secret file
# in the container - I first let docker-entrypoint.sh create a password
# and then change root password in docker-entrypoint-initdb.d.

# Files in docker-entrypoint-initdb.d are run as mysql user.
# https://github.com/docker-library/mysql/blob/8a0100a365707fa3e59d5b23defc64b9314c4bc7/8.4/docker-entrypoint.sh#L378

# Change root password.
RUN --mount=type=secret,required=true,id=db-root-password set -eu; \
    { \
        echo "ALTER USER \"root\"@\"%\" IDENTIFIED BY \"$(cat ${MYSQL_ROOT_PASSWORD_FILE})\";"; \
        echo "FLUSH PRIVILEGES;"; \
    } > /docker-entrypoint-initdb.d/01root-setup.sql

# Create tables, fill them with data.
COPY db_dump.sql /docker-entrypoint-initdb.d/temp.sql

# Create database.
# The default MySQL server character set and collation are utf8mb4 and utf8mb4_0900_ai_ci.
# https://dev.mysql.com/doc/refman/8.4/en/charset.html
# Prepend with SET NAMES to use utf8mb4.
# This is supposed to be the default, but importing and .sql file without it doesn't work properly.
# (Not sure why.)
# Prepend with USE databasename to allow setting dbname in compose.yaml.
RUN set -eu; \
    { \
        echo "SET NAMES utf8mb4;"; \
        echo "CREATE DATABASE IF NOT EXISTS ${DOCKER_DB_NAME};"; \
        echo "USE ${DOCKER_DB_NAME};"; \
    } > /docker-entrypoint-initdb.d/02create-fill-tables.sql

# Append dump file.
RUN cat /docker-entrypoint-initdb.d/temp.sql >> /docker-entrypoint-initdb.d/02create-fill-tables.sql

RUN rm /docker-entrypoint-initdb.d/temp.sql

# Create non-root database user and set permissions.
# For CRUD use 'GRANT SELECT, INSERT, UPDATE, DELETE' instead of 'GRANT SELECT'
RUN --mount=type=secret,required=true,id=db-user-password set -eu; \
    { \
        echo "CREATE USER \"${DOCKER_USER_NAME}\"@\"%\" IDENTIFIED WITH caching_sha2_password BY \"$(cat ${DB_USER_PASSWORD_FILE})\";"; \
        echo "GRANT SELECT ON ${DOCKER_DB_NAME}.* TO \"${DOCKER_USER_NAME}\"@\"%\";"; \
        echo "FLUSH PRIVILEGES;"; \
    } > /docker-entrypoint-initdb.d/03user-setup.sql

# Remove files, because they contain a passwords.
RUN set -eu; \
    { \
        echo "#!/bin/bash"; \
        echo "rm /docker-entrypoint-initdb.d/*"; \
    } > /docker-entrypoint-initdb.d/04user-setup-remove.sh

# Set up permission to allow the contents of the entrypoint directory to be deleted.
# (has to be set on the whole directory)
RUN chown -R mysql /docker-entrypoint-initdb.d
RUN chmod -R 777 /docker-entrypoint-initdb.d

