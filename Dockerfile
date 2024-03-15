# Use Ubuntu as the base image
FROM ubuntu:latest

# Update package repositories and install nginx
RUN apt update && apt install -y nginx

# Remove the default NGINX configuration file
RUN rm etc/nginx/sites-enabled/default

# Copy the new configuration file
COPY nimadevops.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/nimadevops.conf /etc/nginx/sites-enabled/
# Remove the default NGINX welcome page
RUN rm -rf /usr/share/nginx/html/*

# Install Git (if needed)
RUN apt-get update && apt-get install -y git

# Create a new directory
RUN mkdir -p /var/www/nimadevops/html
# Assign ownership of the directory with the $USER environment variable
RUN chown -R $USER:$USER /var/www/nimadevops/html
RUN chmod -R 755 /var/www/nimadevops
# Clone the portfolio repository from GitHub
RUN git clone https://github.com/NimaMajidi1997/devportfolio.git /var/www/nimadevops/html

# Expose port 80
EXPOSE 80

# Command to start NGINX when the container runs
CMD ["nginx", "-g", "daemon off;"]
