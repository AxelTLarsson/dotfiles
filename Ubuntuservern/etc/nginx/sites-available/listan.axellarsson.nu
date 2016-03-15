server {
    listen 80;
    server_name listan.axellarsson.nu;
    return 301 https://$host$request_uri;
}

# Web socket stuff: the header field in a request to the proxied server depends on
# the presence of the "Upgrade" field in the client request header and not hardcoded
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

server {
    listen 443 ssl http2;

    server_name listan.axellarsson.nu;

    root /var/www/listan.axellarsson.nu/;


    location / {
        # fist attempt URL then try as php file
        try_files $uri @extensionless-php;
    }

    location /websocket {
	# WebSocket support
        proxy_pass http://localhost:9001;  # Address of the ws app
	proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_read_timeout 86400;
    }       
 
    location = / {
	index index.php;
    }

    error_page 404 /404.php;

    # redirect server error pages to the static page /50x.html

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
           root /usr/share/nginx/html;
    }

    location ~ \.php$ {
       fastcgi_split_path_info ^(.+\.php)(/.+)$;

       try_files $uri =404;

       # With php5-fpm:
       fastcgi_pass unix:/var/run/php5-fpm.sock;
       fastcgi_index index.php;
       include fastcgi_params;
       fastcgi_param SCRIPT_FILENAME $document_root/$fastcgi_script_name;
    }

    # Rewrite so that /file fetches /file.php
    location @extensionless-php {
       rewrite ^(.*)$ $1.php last;
    }
}
