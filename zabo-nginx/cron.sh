#!/bin/bash

echo "creating cert initializing script"
rm -f /cert_init.sh
cat <<EOF >> /cert_init.sh
#!/bin/bash
certbot --nginx -d ${ZABO_DOMAIN} -d ${ZABO_BOARDS_DOMAIN} -n --agree-tos -m ${ZABO_EMAIL}
EOF

chmod +x /cert_init.sh

echo "Getting SSL Cert..."
/cert_init.sh

echo "creating cron job for certbot cert renewal"

rm -f /renewal.sh

cat <<EOF >> /renewal.sh
#!/bin/bash
certbot renew
EOF

chmod +x /renewal.sh

touch /nginx_log/certbot_renewal.log

echo "${RENEWAL_TIME} . /root/project_env.sh; /renewal.sh >> /nginx_log/certbot_renewal.log 2>&1" > /crontab.conf

crontab /crontab.conf

echo "=> Running cron job"

cron