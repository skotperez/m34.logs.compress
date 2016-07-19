#!/bin/bash
# What this script do:
# + Compress error and access log for each virtual host using bzip2
#
###

# VARS
TODAY=`date +%Y%m%d`

# save virtual hosts list in a file
ls /var/www > vhosts.list

# use list in vhosts.list to compress logs in every vhost
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ "$line" != "bin" ]] && [[ "$line" != "html" ]] && [[ "$line" != "montera34" ]]; then
		bzip2 /var/www/$line/logs/access.log
		bzip2 /var/www/$line/logs/error.log
		mv /var/www/$line/logs/access.log.bz2 /var/www/$line/logs/${TODAY}-access.log.bz2
		mv /var/www/$line/logs/error.log.bz2 /var/www/$line/logs/${TODAY}-error.log.bz2
	fi
	done < vhosts.list

rm vhosts.list
