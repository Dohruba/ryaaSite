#!/bin/bash

# Infinite loop to keep the script running
while :
do
    # Run Certbot renew every 12 hours
    certbot renew --nginx --non-interactive --quiet
    sleep 12h
done
