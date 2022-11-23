#!/bin/sh

# Install scrapyd
: ${scrapyd_app_dir="/usr/local/scrapyd"}
/usr/local/bin/python3 -m venv $scrapyd_app_dir
$scrapyd_app_dir/bin/python3 -m pip install --upgrade pip
$scrapyd_app_dir/bin/pip install scrapyd

# Create run user
pw useradd scrapy -s /bin/csh -m
chown -R scrapy $scrapyd_app_dir
echo "source $scrapyd_app_dir/bin/activate.csh" >> /home/scrapy/.cshrc

# Configure scrapyd
sysrc -f /etc/rc.conf scrapyd_enable="YES"
sysrc -f /etc/rc.conf scrapyd_app_dir="$scrapyd_app_dir"
sysrc -f /etc/rc.conf scrapyd_user="scrapy"

service scrapyd start

echo "✅ scrapyd installation is complete!" > /root/PLUGIN_INFO
echo "App dir: $scrapyd_app_dir" >> /root/PLUGIN_INFO
echo "Config: /etc/scrapyd/scrapyd.conf" >> /root/PLUGIN_INFO
echo "" >> /root/PLUGIN_INFO
echo "The console will be output to '/tmp/scrapyd.log'. (Different from normal logs)" >> /root/PLUGIN_INFO
