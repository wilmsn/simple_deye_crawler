# simple_deye_crawler
A simple crawler to get data from the Deye Inverter using the status webpage

Working Steps:

1) Get the file status.html from your Deye Inverter using "curl"

2) Extract the relevant informations

3) Upload the data to FHEM

Extracted data:

1) Current Power

2) Daily Power

3) Total Power

Getting started:

1) Download the repository

2a) Edit "tn_fhem.php" to your needs if fhem is not running on localhost

2b) Edit "get_deye.sh"

	    FHEM_CUR=<FHEM dummy for current power>
	    FHEM_DAY=<FHEM dummy for  power of this day>
	    FHEM_TOT=<FHEM dummy for total power>
	

3) Add the script to your crontab

	0,5,10,15,20,25,30,35,40,45,50,55 * * * * <path to script>/get_deye.sh <ip of Deye> <user> <password>2>/dev/null >> /tmp/get_deye.log
		
4) Have fun

Use on your own risk!

Tested on Inverter "SUN-M80G3-EU-Q0" with Firmware "MW3_16U_5408_5.0C-S"

Version 0.1 testing
 