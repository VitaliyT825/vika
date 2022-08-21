FROM nginx:1.17-alpine

COPY docker/nginx/templates/app.conf.tpl /etc/nginx/app.conf.tpl
COPY docker/nginx/boot.sh /usr/local/bin/boot_nginx

CMD ["sh", "/usr/local/bin/boot_nginx"]
