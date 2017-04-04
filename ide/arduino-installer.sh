#!/bin/bash

LIST=$(curl -s https://www.arduino.cc/en/Main/Software | \
       grep -o -E "www\.arduino\.cc/download.*linuxarm.*.tar\.xz" | \
       sed -e "s/.*\?f\=\///")

select PKG in $LIST ; do break ; done

curl "https://downloads.arduino.cc/$PKG" -o arduino-ide-package.tar.xz

sudo tar -xvJf arduino-ide-package.tar.xz --no-same-owner --transform 's/^arduino[.0123456789-]*/arduino/' -C /opt

sudo sh -c 'echo "#!/bin/bash\n/opt/arduino/arduino "$@"\n" > /usr/bin/arduino-opt'
sudo sh -c 'echo "#!/bin/bash\n/opt/arduino/install.sh "$@"\n" > /usr/bin/arduino-opt-install'
sudo sh -c 'echo "#!/bin/bash\n/opt/arduino/uninstall.sh "$@"\n" > /usr/bin/arduino-opt-uninstall'

sudo chmod +x /usr/bin/arduino-opt
sudo chmod +x /usr/bin/arduino-opt-install
sudo chmod +x /usr/bin/arduino-opt-uninstall
