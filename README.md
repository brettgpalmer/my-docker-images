# my-docker-images/wp-rest-api
Basic WP install with the wp-rest-api plugin enabled.  This images includes the following plugins:


Plugins:
- WP Super Cache plugin
- Raising upload limit
- WP Mail SMTP
- WP-REST-API version 2.0

10/1/2015
- Fixed syntax errors with entrypoint.sh script
- Correctly downloads WP plugins from WP plugin page, unzips, and installs.

9/21/2015
- Initially just includes the super cache plugin
