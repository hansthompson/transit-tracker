

Transit-Tracker
===================

*A full stack for public transit to transmit gps, calculate stop delays, and host the protocol buffer file to present that to google maps and other applications.*

Wait, what is it?
-------------

A full open source implementation from placing gps hardware on the bus to calculating delays on the routes from the real time gps, to hosting the protocol buffer. 

How to Deploy
-------------
A. Validate the static GTFS 

* Find your agency's GTFS feed ([transitfeeds.com](http://transitfeeds.com/) or [transit land](https://transit.land/feed-registry/))
    
* Take the URL and run it through the validation process in R's gtfsr package
    
```
url <- 'http://www.co.fairbanks.ak.us/transportation/MACSDocuments/GTFS.zip'

library(devtools)
install_github("ropensci/gtfsr") # add apt-get repos for package dependencies (dplyr, tibble, readr, httr, htmltools, magrittr, stringr, assertthat, leaflet, sp, scales). 
library(gtfsr)
library(magrittr)
library(dplyr)
options(dplyr.width = Inf) # I like to see all the columns
set_api_key('2ec1ae29-b8c2-4a03-b96e-126d585233f9')
url <- 'http://www.co.fairbanks.ak.us/transportation/MACSDocuments/GTFS.zip' # change your url here
gtfs_obj <- url %>% import_gtfs
```
B. Buy the parts for tracking gps. 
* microcomputer (raspberry pi 3) 
	
* usb gps
	
* mobile Internet connection. [Mifi general info](https://en.wikipedia.org/wiki/MiFi).
	
* *touch screen interface - TBD*
	
C. Run the scripts for turning the pi with usb gps into an API
   * [shell installation script](pi-scripts/setup.sh)
   
D. Build the protocol buffer server on Ubuntu by installing the dependencies
   * [shell installation script](server-scripts/setup.sh)
   * GTFS of your agency - [start here?](https://transit.land/feed-registry/) or [here](http://transitfeeds.com/) 
   ```
  	 git clone https://github.com/hansthompson/transit-tracker.git
	sudo chmod +x /transit-tracker/server-scripts/setup.sh
	sudo ./transit-tracker/server-scripts/setup.sh
	```
   
E. Start the server

What are the components?
-------------

### Remote unit:
* [Raspberry Pi 3 kit](https://www.amazon.com/CanaKit-Raspberry-Clear-Power-Supply/dp/B01C6EQNNK/ref=sr_1_3?s=pc&ie=UTF8&qid=1488783930&sr=1-3&keywords=raspberry+pi+3) - $49.99
* [Micro SD card](https://www.amazon.com/Samsung-Select-Memory-MB-ME32DA-AM/dp/B01DOB6Y5Q/ref=sr_1_1?s=pc&ie=UTF8&qid=1488783959&sr=1-1&keywords=micro+sd) - $10.99
* [usb gps antenna](https://www.amazon.com/Generic-Receiver-G-mouse-Antenna-Navigation/dp/B017BJ3KTU/ref=sr_1_1?s=pc&ie=UTF8&qid=1488784023&sr=8-1&keywords=Generic+USB+GPS+Receiver+G-mouse+GPS+Mouse+Within+GPS+Module+Antenna+for+Car+Laptop+PC+Navigation+Support+Google) - $25.98
* [LTE router](https://www.amazon.com/dp/B00634PLTW/ref=psdc_300189_t1_B01FVJIWCW) - $29.95
* Carrier modem - $ different across mobile ISPs.   In south central Alaska it costs $7.99 per device per month.
* total: $116.91 per remote unit.

### Server:
* Ubuntu server with modest specs (AWS EC2 micro) - [$8.83 - $14.64](https://www.google.com/search?q=aws+micro+cost+month&oq=aws+micro&aqs=chrome.0.69i59l2j69i57.3119j0j1&sourceid=chrome&ie=UTF-8) / month

So for 10 devices, on ten buses, it would cost $1169.10 for the up front hardware with a monthly data and hosting cost of $148.72-$154.53 for a 8 gigs shared across devices! 

Hasn't this been done already? 
-------------

Not open source! And not as a bundle for anyone to deploy in one project!


How to contribute
-------------

Please make an issue and I'll respond.  We can decide to go with the master or a feature branch. [check out notes.txt for my current thoughts on what to do](notes.txt) as well as the issues page. 
