# Use NGINX base image from Docker Hub
FROM nginx

# Remove the default NGINX configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the new configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Remove the default NGINX welcome page
RUN rm -rf /usr/share/nginx/html/*

# Install Git (if needed)
RUN apt-get update && apt-get install -y git

# Create a new directory
RUN mkdir -p /usr/share/nginx/html/devportfolio

# Clone the portfolio repository from GitHub
RUN git clone https://github.com/NimaMajidi1997/devportfolio.git /usr/share/nginx/html/devportfolio/

# Expose port 80
EXPOSE 80

# Command to start NGINX when the container runs
CMD ["nginx", "-g", "daemon off;"]
