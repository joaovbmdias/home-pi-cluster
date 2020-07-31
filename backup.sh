zip -r "archive-$(date +"%Y%m%d%H%M%S").zip" /home/pi/configurations
mv archive* /mnt/Backups
ls -t -d /mnt/Backups/* | sed -e '1,5d' | xargs -d '\n' rm