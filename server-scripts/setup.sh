sudo apt-get -y install r-base r-base-dev nginx git libcurl4-gnutls-dev libxml2-dev libssl-dev
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
sudo apt-get update
sudo apt-get install r-base
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('XML', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \" library(devtools);install_github('ropensci/gtfsr')  \""
sudo su - -c "R -e \" library(devtools);install_github('hansthompson/dlayr')  \""
(crontab -l 2>/dev/null; echo "5 0 * * * Rscript /root/transit-tracker/server_scripts/download_gtfs.R ") | crontab -
(crontab -l 2>/dev/null; echo "* * * * * Rscript /root/transit-tracker/server_scripts/get_tidy_gps.R ") | crontab -
