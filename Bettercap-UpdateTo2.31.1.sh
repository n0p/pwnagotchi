#!/bin/bash

wget "https://github.com/bettercap/bettercap/releases/download/v2.31.1/bettercap_linux_armhf_v2.31.1.zip"
unzip bettercap_linux_armhf_v2.31.1.zip
# ... check the sha256 digest before doing this ...
sudo mv bettercap /usr/bin/
# install the caplets and the web ui in /usr/local/share/bettercap and quit
sudo bettercap -eval "caplets.update; ui.update; quit"
