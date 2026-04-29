openssh-server:
  pkg.installed: []

/etc/ssh/sshd_config.d/99-hardening.conf:
  file.managed:
    - source: salt://secure_nginx/files/ssh-hardening.conf
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - pkg: openssh-server

ssh_service:
  service.running:
    - name: ssh
    - enable: True
    - watch:
      - file: /etc/ssh/sshd_config.d/99-hardening.conf

