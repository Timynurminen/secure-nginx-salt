nginx:
  pkg.installed: []

/var/www/html/index.html:
  file.managed:
    - source: salt://secure_nginx/files/index.html
    - user: root
    - group: root
    - mode: "0644"
    - require: 
      - pkg: nginx

/etc/nginx/conf.d/security-headers.conf:
  file.managed:
    - source: salt://secure_nginx/files/nginx-hardening.conf
    - user: root
    - group: root
    - mode: "0644"
    - require: 
      - pkg: nginx

nginx_service:
  service.running:
    - name: nginx
    - enable: true
    - require: 
        - pkg: nginx
    - watch:
      - file: /var/www/html/index.html
      - file: /etc/nginx/conf.d/security-headers.conf
