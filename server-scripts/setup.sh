sudo apt-get -y install nginx git libcurl4-gnutls-dev libxml2-dev libssl-dev 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DA$
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
sudo apt-get update
sudo apt-get -y install r-base r-base-dev gdebi-core
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('XML', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \" library(devtools);install_github('ropensci/gtfsr')  \""
sudo su - -c "R -e \" library(devtools);install_github('hansthompson/dlayr')  \""
(crontab -l 2>/dev/null; echo "5 0 * * * Rscript /root/transit-tracker/scripts_in_testing/download_g$
(crontab -l 2>/dev/null; echo "* * * * * Rscript /root/transit-tracker/scripts_in_testing/get_tidy_g$
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
sudo gdebi -n shiny-server-1.5.3.838-amd64.deb 
sudo sed -i 's/  listen 3838;/  listen 80;/' /etc/shiny-server/shiny-server.conf
# then reboot. The shiny-server is still serving at 3838 until you restart.
