# add user
adduser -m -s /bin/bash prometheus
su - prometheus

# Create directories
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus /var/lib/prometheus/

# Download Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.45.2/prometheus-2.45.2.linux-amd64.tar.gz \
    -P /tmp
cd /tmp

# Extract Prometheus
tar -xzvf prometheus-2.45.2.linux-amd64.tar.gz
cd prometheus-2.45.2.linux-amd64
cp -pr prometheus promtool /usr/local/bin/
cp -pr prometheus.yml /etc/prometheus/

# Move Prometheus
mv prometheus-2.45.2.linux-amd64 prometheus

cat << EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Restart=on-failure

#Change this line if you download the
#Prometheus on different path user
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload daemon
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus

