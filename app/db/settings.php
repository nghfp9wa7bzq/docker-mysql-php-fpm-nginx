<?php
//    Copyright (C) 2025  nghfp9wa7bzq@gmail.com

//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.


$DATABASE_HOST = "mysql";
$DATABASE_USER = "docker";
$DATABASE_PASSWORD = "";
$DATABASE_NAME = "dockerdb";
$DATABASE_QUERY = "SELECT * FROM p_c_ct ORDER BY RAND() LIMIT 1;";

$file = "/run/secrets/db-user-password";

if (!$DATABASE_PASSWORD and (file_exists($file))) {
    try {
        $DATABASE_PASSWORD = trim(file_get_contents($file));
    } catch (\Throwable $th) {
        var_dump($e);
        die("Error reading database password file!");
    }
}

#echo "dbhost: " . $DATABASE_HOST . " dbuser: " . $DATABASE_USER . " dbpsw: " . $DATABASE_PASSWORD . " dbname: " . $DATABASE_NAME;

?>