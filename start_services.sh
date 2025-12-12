#!/bin/bash

kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
sleep 1
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
sleep 1
kill $(ps aux | grep 'xtreamcodes' | grep -v grep | grep -v 'start_services.sh' | awk '{print $2}') 2>/dev/null
sleep 4
rm -f /home/xtreamcodes/iptv_xtream_codes/php/*.pid

# Odključaj GeoLite2.mmdb prije chown-a
chattr -i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb 2>/dev/null || true

sudo -u xtreamcodes /home/xtreamcodes/iptv_xtream_codes/php/bin/php /home/xtreamcodes/iptv_xtream_codes/crons/setup_cache.php
sudo -u xtreamcodes /home/xtreamcodes/iptv_xtream_codes/php/bin/php /home/xtreamcodes/iptv_xtream_codes/tools/signal_receiver.php >/dev/null 2>&1 &
sudo -u xtreamcodes /home/xtreamcodes/iptv_xtream_codes/php/bin/php /home/xtreamcodes/iptv_xtream_codes/tools/pipe_reader.php >/dev/null 2>&1 &

chown -R xtreamcodes:xtreamcodes /sys/class/net 2>/dev/null || true
chown -R xtreamcodes:xtreamcodes /home/xtreamcodes 2>/dev/null || true

# Zaključaj ponovo GeoLite2.mmdb
chattr +i /home/xtreamcodes/iptv_xtream_codes/GeoLite2.mmdb 2>/dev/null || true

sleep 4
/home/xtreamcodes/iptv_xtream_codes/nginx_rtmp/sbin/nginx_rtmp
/home/xtreamcodes/iptv_xtream_codes/nginx/sbin/nginx

/sbin/start-stop-daemon --start --quiet --pidfile /home/xtreamcodes/iptv_xtream_codes/php/VaiIb8.pid --exec /home/xtreamcodes/iptv_xtream_codes/php/sbin/php-fpm -- --daemonize --fpm-config /home/xtreamcodes/iptv_xtream_codes/php/etc/VaiIb8.conf
/sbin/start-stop-daemon --start --quiet --pidfile /home/xtreamcodes/iptv_xtream_codes/php/JdlJXm.pid --exec /home/xtreamcodes/iptv_xtream_codes/php/sbin/php-fpm -- --daemonize --fpm-config /home/xtreamcodes/iptv_xtream_codes/php/etc/JdlJXm.conf
/sbin/start-stop-daemon --start --quiet --pidfile /home/xtreamcodes/iptv_xtream_codes/php/CWcfSP.pid --exec /home/xtreamcodes/iptv_xtream_codes/php/sbin/php-fpm -- --daemonize --fpm-config /home/xtreamcodes/iptv_xtream_codes/php/etc/CWcfSP.conf
