#!/bin/bash

set -e

sed -i 's/port=3389/port=3399/g' /etc/xrdp/xrdp.ini

cat > /etc/xrdp/startwm.sh <<EOF
#!/bin/bash

unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR

exec startxfce4
EOF

chmod +x /etc/xrdp/startwm.sh

/usr/sbin/xrdp-sesman --nodaemon &
exec /usr/sbin/xrdp --nodaemon
