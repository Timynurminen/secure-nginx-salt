fail2ban:
  pkg.installed: []
/etc/fail2ban/jail.d/sshd.local:
  file.managed:
    - source: salt://secure_nginx/files/fail2ban-sshd.conf
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - pkg: fail2ban

fail2ban_service:
  service.running:
    - name: fail2ban
    - enable: True
    - require:
      - pkg: fail2ban
    - watch:
      - file: /etc/fail2ban/jail.d/sshd.local

