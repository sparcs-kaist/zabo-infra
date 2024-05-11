FROM nginx:1.24.0

RUN apt-get update && apt-get -y install cron

ENV RENEWAL_TIME="0 4 1 */2 *" \
    TZ=Asia/Seoul \
    CRON_TZ=Asia/Seoul \
    ZABO_DOMAIN="zabo.sparcs.org" \
    ZABO_BOARDS_DOMAIN="zabo-boards.sparcs.org" \
    ZABO_EMAIL="zabo@sparcs.org"

ADD zabo-nginx/cron.sh /cron.sh

RUN chmod +x /cron.sh

RUN /cron.sh

CMD ["nginx", "-g", "daemon off;"]