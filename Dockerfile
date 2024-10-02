# Use an official NGINX image as the base image
FROM nginx:latest

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Remove the default NGINX static files
RUN rm -rf ./*

# Copy the contents of your portfolio to the NGINX folder
COPY portfol/ .

# Expose port 80 to access the website
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
