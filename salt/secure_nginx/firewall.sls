ufw:
  pkg.installed: []

allow_ssh:
  cmd.run:
    - name: ufw allow OpenSSH
    - unless: ufw status | grep -q "OpenSSH"
    - require:
      - pkg: ufw    

allow_http:
  cmd.run:
    - name: ufw allow 'Nginx HTTP'
    - unless: ufw status | grep -q "Nginx HTTP"
    - require:
      - pkg: ufw

enable_ufw:
  cmd.run:
    - name: ufw --force enable
    - unless: "ufw status | grep -q 'Status: active'"
    - require:
      - cmd: allow_ssh
      - cmd: allow_http
 
