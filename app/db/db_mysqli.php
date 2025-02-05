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


echo "mysqli db start<br>";

// Based on https://devcenter.heroku.com/articles/ah-mysql-stackhero#connect-mysql-with-php.

$mysqli = mysqli_init();
$mysqliConnected = mysqli_real_connect(
    $mysqli,
    $DATABASE_HOST,
    $DATABASE_USER,
    $DATABASE_PASSWORD,
    $DATABASE_NAME,
    null,
    NULL,
    MYSQLI_CLIENT_SSL
);
if (!$mysqliConnected) {
    die("Connect Error: " . mysqli_connect_error());
}

$result = mysqli_query($mysqli, $DATABASE_QUERY);
if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    //print_r($row);
    echo $row["person_name"] . " " . $row["company_name"] . " " . $row["company_type"] . "<br>";
} else {
    echo "Database returned 0 results.<br>";
}

//echo "Success... " . mysqli_get_host_info($mysqli) . "<br>";
echo "mysqli db end<br>";

mysqli_close($mysqli);


?>