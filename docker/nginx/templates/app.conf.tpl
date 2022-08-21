server {
    listen 80;
    server_name ${DOMAIN};

    root /app/public;

    error_log /var/log/nginx/${PROJECT_NAME}.error.log;
    access_log /var/log/nginx/${PROJECT_NAME}.access.log;

    location / {
        try_files $uri /index.php$is_args$args;
    }

    location ~ ^/index\.php(/|$) {
        fastcgi_pass php:9000;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;

        add_header Access-Control-Allow-Origin "*";
        add_header Access-Control-Allow-Methods "*";
        add_header Access-Control-Allow-Headers "Authorization, NoSign, Content-Type";

        if ($request_method = OPTIONS) {
            add_header Access-Control-Allow-Origin "*";
            add_header Access-Control-Allow-Methods "OPTIONS, GET, HEAD, POST, PUT, DELETE";
            add_header Access-Control-Allow-Headers "Authorization, NoSign, Content-Type, SignatureDisable";
            add_header Access-Control-Allow-Credentials "true";
            add_header Content-Length 0;
            add_header Content-Type text/plain;

            return 200;
        }

        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;

        internal;
    }

    location ~ \.php$ {
        return 404;
    }
}



