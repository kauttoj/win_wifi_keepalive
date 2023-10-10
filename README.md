# win_wifi_keepalive
Simple batch script to make sure wifi is working and reset it if necessary (soft or hard)

  Simply set the name of your wifi network here:\
    set mynetwork="my Galaxy Phone" \

  You can also specify timeout (in seconds), server to ping (208.67.222.222 is Cisco OpenDNS or www.google.com) \
  set timeout=7 \
  set myIP="208.67.222.222" \

  Default is disconenct and reconnect (soft reset) or could also disable enable wifi router (hard reset) if set to 1 \
  set use_hard_reset = 0 \

JanneK
10.10.2023
