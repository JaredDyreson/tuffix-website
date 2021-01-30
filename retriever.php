<?php
/*
* Get latest version of the installer
*/

function get_latest_version(){
    $base_dir = "repo/amd64/builds/";
    $files = scandir($base_dir, SCANDIR_SORT_DESCENDING);
    return $base_dir . $files[0];
}

?>
