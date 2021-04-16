#! /bin/bash

if [ ! -f "/opt/csvn/data/conf/csvn.conf" ]; then
    cp -r /opt/csvn/data-initial/* /opt/csvn/data
fi

# Always copy the "dist" configuration
# files to the data folder.
cp -f /opt/csvn/dist/* /opt/csvn/data/conf