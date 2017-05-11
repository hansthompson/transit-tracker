

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
	* mobile Internet connection. 
	* *touch screen interface - TBD*

1. Run the script for turning the gps into an API 

		git clone https://www.github.com/hansthompson/transit-tracker
		chmod +x transit-tracker/server-scripts/setup.sh
		 ./transit-tracker/server-scripts/setup.sh


2. Build the protocol buffer server on Ubuntu by installing the dependencies
   * apt-get stuff
   * R stuff
   * GTFS of your agency 
3. Start the server

What are the components?
-------------


* [Raspberry Pi 3 kit](https://www.amazon.com/CanaKit-Raspberry-Clear-Power-Supply/dp/B01C6EQNNK/ref=sr_1_3?s=pc&ie=UTF8&qid=1488783930&sr=1-3&keywords=raspberry+pi+3)
* [Micro SD card](https://www.amazon.com/Samsung-Select-Memory-MB-ME32DA-AM/dp/B01DOB6Y5Q/ref=sr_1_1?s=pc&ie=UTF8&qid=1488783959&sr=1-1&keywords=micro+sd)
* [usb gps antenna](https://www.amazon.com/Generic-Receiver-G-mouse-Antenna-Navigation/dp/B017BJ3KTU/ref=sr_1_1?s=pc&ie=UTF8&qid=1488784023&sr=8-1&keywords=Generic+USB+GPS+Receiver+G-mouse+GPS+Mouse+Within+GPS+Module+Antenna+for+Car+Laptop+PC+Navigation+Support+Google)


Hasn't this been done already? 
-------------

Not open source! And not as a bundle for anyone to deploy in one project!


How to contribute
-------------

Please make an issue and I'll respond.  We can decide to go with the master or a feature branch. 

To Do:
-------------

1. figure out how to run /server-scripts/setup.sh from bash for instant deployment
2. set up a system for storing tidy_gps functions for each agency (perhaps a seperate repo).
3. have the scripts run either on startup or through crontab. 
4. have the scripts write to the right shiny server app directory/s. 
5. Set up a script to benchmark the gps feed. 






