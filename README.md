

Transit-Tracker
===================

*A full stack for public transit to transmit gps, calculate stop delays, and host the protocol buffer file to present that to google maps and other applications.*

Wait, what is it?
-------------

A full open source implementation from placing gps hardware on the bus to calculating delays on the routes from the real time gps, to hosting the protocol buffer. 

How to Deploy
-------------

1. Buy the parts for tracking gps. 
	* microcomputer (raspberry pi 3) 
	* usb gps
	* mobile Internet connection. [Mifi general info](https://en.wikipedia.org/wiki/MiFi)
	* *touch screen interface - TBD*

1. Run the scripts for turning the pi with usb gps into an API
   * [apt-get stuff](server-scripts/apt-get_repos.sh)
   * [R stuff](server-scripts/R-packages.sh) 
2. Build the protocol buffer server on Ubuntu by installing the dependencies
   * [apt-get stuff](server-scripts/apt-get_repos.sh)
   * [R stuff](server-scripts/R-packages.sh) 
   * GTFS of your agency - [start here?](https://transit.land/feed-registry/) or [here](http://transitfeeds.com/) 
3. Start the server

What are the components?
-------------

### Remote unit:
* [Raspberry Pi 3 kit](https://www.amazon.com/CanaKit-Raspberry-Clear-Power-Supply/dp/B01C6EQNNK/ref=sr_1_3?s=pc&ie=UTF8&qid=1488783930&sr=1-3&keywords=raspberry+pi+3) - $49.99
* [Micro SD card](https://www.amazon.com/Samsung-Select-Memory-MB-ME32DA-AM/dp/B01DOB6Y5Q/ref=sr_1_1?s=pc&ie=UTF8&qid=1488783959&sr=1-1&keywords=micro+sd) - $10.99
* [usb gps antenna](https://www.amazon.com/Generic-Receiver-G-mouse-Antenna-Navigation/dp/B017BJ3KTU/ref=sr_1_1?s=pc&ie=UTF8&qid=1488784023&sr=8-1&keywords=Generic+USB+GPS+Receiver+G-mouse+GPS+Mouse+Within+GPS+Module+Antenna+for+Car+Laptop+PC+Navigation+Support+Google) - $25.98

### Server:
* Ubuntu server with modest specs (AWS EC2 micro) - [$8.83 - $14.64](https://www.google.com/search?q=aws+micro+cost+month&oq=aws+micro&aqs=chrome.0.69i59l2j69i57.3119j0j1&sourceid=chrome&ie=UTF-8)

Hasn't this been done already? 
-------------

Not open source! And not as a bundle for anyone to deploy in one project!


How to contribute
-------------

Please make an issue and I'll respond.  We can decide to go with the master or a feature branch. 








