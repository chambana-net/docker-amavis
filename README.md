docker-amavis
=============
Docker container for amavis and associated spam mitigation services.

Usage
-----
This container runs Amavis, Spamassassin, Clamd, Freshclam, Razor, and Pyzor as a standalone host connectable over inet sockets on port 10024. For reinjection, it automatically connects back to the host that sent it the email for scanning port 10025. *This container is designed to operate as part of a set in the Chambana.net email system, and supports limited configurability.* For more detailed setup instructions, see https://github.com/chambana-net/docker-postfix

This container supports one mandatory environment variable for configuration, `AMAVIS_MAILNAME`, which needs to be set to the domain for which it is scanning mail.
