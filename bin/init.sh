#!/bin/bash -

. /opt/chambana/lib/common.sh

if [[ ! -d /var/run/clamav ]]; then
	mkdir /var/run/clamav
	chown -R clamav:clamav /var/run/clamav
fi


MSG "Configuring Razor & Pyzor..."
su - amavis -c 'razor-admin -create'
su - amavis -c 'razor-admin -register'
su - amavis -c 'pyzor discover'

MSG "Starting Amavis..."
supervisord -c /etc/supervisor/supervisord.conf 
