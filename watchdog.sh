#!/bin/bash

# Create Watchdog Process that will keep RPi alive 24/7 even in casa of catastrophic failure
# except power outage (no Power no Pi)

echo Creating watchdog executable file

cat > /etc/.watchdog.sh << EOF
#!/bin/bash
echo " Starting user level protection"
while :
   do
      sudo sh -c "echo '.' >> /dev/watchdog"
      sleep 14
   done
EOF

sudo chmod +x /etc/.watchdog.sh
echo SUCCESS!

echo Add watchdog to cron
cat > create_cron << EOF
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
echo @reboot /etc/.watchdog.sh >>
EOF

crontab create_cron

rm create_cron
echo SUCCESS!