#!/bin/bash -

. /opt/chambana/lib/common.sh

CHECK_BIN sed

MSG "Configuring Razor & Pyzor..."
su - amavis -c 'razor-admin -create'
su - amavis -c 'razor-admin -register'
su - amavis -c 'pyzor discover'

MSG "Starting Amavis..."
supervisord -c /etc/supervisor/supervisord.conf 
