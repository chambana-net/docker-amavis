#!/bin/bash -

. /opt/chambana/lib/common.sh

CHECK_BIN sed
CHECK_VAR AMAVIS_REINJECTION_HOST
CHECK_VAR AMAVIS_REINJECTION_PORT

MSG "Configuring Amavis..."

URI="'lmtp:[$(getent hosts $AMAVIS_REINJECTION_HOST | head -n1 | awk '{ print $1 }')]:$AMAVIS_REINJECTION_PORT'"

sed -i -e "s/^\$notify_method\ *=.*/\$notify_method\ =\ $URI;/" \
  -e "s/^\$forward_method\ *=.*/\$forward_method\ =\ $URI;/" \
	/etc/amavis/conf.d/50-user

supervisord -c /etc/supervisor/supervisord.conf 
