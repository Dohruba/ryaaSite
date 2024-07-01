# Use the official Nginx base image
FROM nginx:latest

# Install Certbot and Certbot Nginx plugin
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# COPY letsencrypt /etc/letsencrypt

# Add a script to renew certificates
COPY renew_cert.sh /usr/local/bin/renew_cert.sh
RUN chmod +x /usr/local/bin/renew_cert.sh

# Copy website files
COPY html /usr/share/nginx/html

# Expose ports
EXPOSE 80 443

# Start Nginx and run the Certbot renew script in the background
CMD ["sh", "-c", "nginx -g 'daemon off;' & /usr/local/bin/renew_cert.sh"]
