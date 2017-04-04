#!/bin/bash

LIST=$(curl -s "https://processing.org/download/?processing" | grep -o -E "processing-.*linux-arm.*tgz" | uniq )

select PKG in $LIST ; do break ; done

curl -L "http://download.processing.org/$PKG" -o processing-package.tar.gz

sudo tar -xvzf processing-package.tar.gz --no-same-owner --transform 's/^processing[.0123456789-]*/processing/' -C /opt

sudo sh -c 'echo "#!/bin/bash\n/opt/processing/processing "$@"\n" > /usr/bin/processing-opt'
sudo chmod +x /usr/bin/processing-opt
