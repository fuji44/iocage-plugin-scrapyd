#!/bin/sh

# Create run user
pw useradd scrapy -s /bin/csh -m

# Install scrapyd
: ${scrapyd_app_dir="/usr/local/scrapyd"}
sudo -H -u scrapy /usr/local/bin/python3.9 -m venv $scrapyd_app_dir
sudo -H -u scrapy $scrapyd_app_dir/bin/python3.9 -m pip install --upgrade pip
sudo -H -u scrapy $scrapyd_app_dir/bin/pip install scrapyd
chown -R scrapy $scrapyd_app_dir
echo 'source $HOME/scrapyd/bin/activate.csh' >> /home/scrapy/.cshrc

# Configure scrapyd
sysrc -f /etc/rc.conf scrapyd_enable="YES"
sysrc -f /etc/rc.conf scrapyd_app_dir=$scrapyd_app_dir
sysrc -f /etc/rc.conf scrapyd_user=scrapy

service scrapyd start

echo "✅ flexget installation is complete!" > /root/PLUGIN_INFO
