#!/bin/bash

yum install -y curl tar

curl -LO https://github.com/cdr/code-server/releases/download/2.1692-vsc1.39.2/code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz
tar -xzvf code-server2.1692-vsc1.39.2-linux-x86_64.tar.gz
cp code-server2.1692-vsc1.39.2-linux-x86_64/code-server /usr/local/bin

cat > /usr/lib/systemd/system/code-server.service << EOF
[Unit]
Description=code-server
#After=nginx.service

[Service]
Type=simple
Environment=PASSWORD=8iu7*IU&
ExecStart=/usr/local/bin/code-server --host 0.0.0.0 --user-data-dir /var/lib/code-server --auth password
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl start code-server
systemctl enable code-server
systemctl status code-server