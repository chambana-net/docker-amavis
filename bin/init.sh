#!/bin/bash -

. /opt/chambana/lib/common.sh

CHECK_BIN sed
CHECK_VAR AMAVIS_REINJECTION_HOST
CHECK_VAR AMAVIS_REINJECTION_PORT

MSG "Configuring Amavis..."

URI="'smtp:[$(getent hosts $AMAVIS_REINJECTION_HOST | head -n1 | awk '{ print $1 }')]:$AMAVIS_REINJECTION_PORT'"

sed -i -e "s/^\$notify_method\ *=.*/\$notify_method\ =\ $URI;/" \
  -e "s/^\$forward_method\ *=.*/\$forward_method\ =\ $URI;/" \
	/etc/amavis/conf.d/50-user

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
