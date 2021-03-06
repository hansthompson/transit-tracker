sudo apt-get -y install nginx git libcurl4-gnutls-dev libxml2-dev libssl-dev 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'
sudo apt-get update
sudo timedatectl set-timezone America/Anchorage # needs to change based on the agency location.
sudo apt-get -y install r-base r-base-dev gdebi-core
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \"install.packages('XML', repos='http://cran.us.r-project.org')\""
sudo su - -c "R -e \" library(devtools);install_github('ropensci/gtfsr')  \""
sudo su - -c "R -e \" library(devtools);install_github('hansthompson/dlayr')  \""
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
sudo gdebi -n shiny-server-1.5.3.838-amd64.deb 
git clone https://www.github.com/hansthompson/dlayr-maps /srv/shiny-server/dlayr-maps
#sudo sed -i 's/  listen 3838;/  listen 80;/' /etc/shiny-server/shiny-server.conf
sudo systemctl restart shiny-server
(crontab -l 2>/dev/null; echo "5 0 * * * Rscript $HOME/transit-tracker/scripts_in_testing/download_gtfs.R ") | crontab -
(crontab -l 2>/dev/null; echo "* * * * * Rscript $HOME/transit-tracker/scripts_in_testing/get_tidy_gps.R ") | crontab -
#echo <<gtfs_link>> > $HOME/gtfs_url.txt
#echo <<gps_function>> > $HOME/gps_function_url.txt
