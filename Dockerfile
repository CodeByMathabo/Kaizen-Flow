# Use the Ubuntu base image
FROM ubuntu:latest

# Install Nginx and ensure it runs in the foreground
RUN apt-get update && apt-get install -y nginx

# Expose port 80
EXPOSE 80

# Command to run Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
