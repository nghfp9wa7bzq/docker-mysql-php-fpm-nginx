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


require_once $_SERVER["DOCUMENT_ROOT"] . "/db/settings.php";


echo "mysql pdo db start<br>";

// Based on https://devcenter.heroku.com/articles/ah-mysql-stackhero#connect-mysql-with-php.
try {
    $pdo = new PDO(
        "mysql:host=" . $DATABASE_HOST . ";dbname=" . $DATABASE_NAME,
        $DATABASE_USER,
        $DATABASE_PASSWORD,
        array(
            // See below if you have an error like "Uncaught PDOException: PDO::__construct(): SSL operation failed with code 1. OpenSSL Error messages: error:0A000086:SSL routines::certificate verify failed".
            PDO::MYSQL_ATTR_SSL_CAPATH => "/etc/ssl/certs/",
            // PDO::MYSQL_ATTR_SSL_CA => "isrgrootx1.pem",
            PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => false,
        )
    );

    if ($stmt = $pdo->query($DATABASE_QUERY, PDO::FETCH_ASSOC)) {
        //print_r($stmt->fetch());
        $row = $stmt->fetch();
        echo $row["person_name"] . " " . $row["company_name"] . " " . $row["company_type"] . "<br>";
    } else {
        echo "Database returned 0 results.<br>";
    }
} catch (Exception $e) {
    echo "Database error: " . $e->getMessage() . "<br>";
}
//echo "You are connected to a database running version " . $version[0] . "<br>";
echo "mysql pdo db end<br>";

?>