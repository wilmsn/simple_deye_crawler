#!/usr/bin/php
<?php

$fhemsock = fsockopen("127.0.0.1", 7072, $errno, $errstr, 30);
$fhemcmd = "set ".$argv[1]." ".$argv[2]." \r\nquit\r\n";
#print $fhemcmd."\n";
fwrite($fhemsock, $fhemcmd);
while(!feof($fhemsock)) {
	$ergebnis=fgets($fhemsock, 128);
}
?>
