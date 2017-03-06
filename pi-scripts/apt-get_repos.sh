sudo sh -c 'deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free rpi" >> /etc/apt/sources.list'

sudo apt-get update 
# TO DO: Use relative links to packages. 
wget https://cran.r-project.org/src/contrib/R6_2.2.0.tar.gz
wget https://cran.r-project.org/src/contrib/stringr_1.2.0.tar.gz
wget https://cran.r-project.org/src/contrib/jsonlite_1.3.tar.gz
wget https://cran.r-project.org/src/contrib/httpuv_1.3.3.tar.gz
git clone https://github.com/trestletech/plumber.git

sudo apt-get -y install  r-base gpsd gpspipe git

R CMD INSTALL R6_2.2.0.tar.gz
R CMD INSTALL stringr_1.2.0.tar.gz
R CMD INSTALL jsonlite_1.3.tar.gz
R CMD INSTALL httpuv_1.3.3.tar.gz
sudo su - -c "R -e \"install.packages("/home/pi/plumber", repos = NULL, type='source')\""

