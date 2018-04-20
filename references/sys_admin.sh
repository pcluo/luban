# check disk size
ls -lah
df -h
du -sh
du -sh *
du -sm * | sort -n

top

# set timezone
date
ls /usr/share/zoneinfo
sudo vim /etc/sysconfig/clock
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# log on
ssh -i /Users/cluo/Dropbox/iladvisers/AWS/aws_key_pluo.pem ec2-user@52.5.232.25
ps -u ec2-user
lsof nohup.out
ssh cluoren@wrds-cloud.wharton.upenn.edu

# resize disk
i-5a120de4 (ipython notebook):/dev/xvda (attached)


# check port used
sudo lsof -i
sudo netstat -lptu
sudo netstat -tulpn

# memory usage
free -m

# system version
cat /etc/system-release

# screen
screen
screen -r
screen -ls


mongod --shutdown

./start_jupyter_notebook.sh

nohup jupyter notebook &
ecryptfs-mount-private


sudo service mongod restart

# work around conda for pip
pip install --ignore-installed --upgrade pip setuptools
