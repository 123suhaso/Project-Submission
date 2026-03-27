Step1:  Install and configure Docker on the server.

    Connect to Your Server

    ssh -i pem-file.pem ubuntu@publick-server-ip

    Update the Server

    sudo apt update && sudo apt upgrade -y

    Enable and start Docker

    sudo systemctl enable docker
    sudo systemctl start docker

    Check Docker status

    sudo systemctl status docker

Step2: Create a Dockerfile to host a custom `index.html` page.

    sudo vi index.html

    Dockerfile

    FROM nginx:latest

    COPY index.html /usr/share/nginx/html/index.html

    EXPOSE 80

    FROM nginx:latest

    Uses the official Nginx image as the base image and Nginx is a lightweight web server perfect for serving HTML files

    COPY index.html /usr/share/nginx/html/index.html

    Copies your custom index.html into the Nginx web root directory.

    EXPOSE 80

    Tells Docker that the container will serve traffic on port 80 internally

Step3: Build a Docker image using the Dockerfile.

    sudo docker build -t my-docker-app .

    docker build → builds the image
    -t my-docker-app → names the image my-docker-app
    . → build from the current directory

    Check the Image

    sudo docker images

Step4: Run a container from the created image.

    sudo docker run -d -p 8000:80 --name docker-web-container my-docker-app

    -d → runs the container in background
    -p 8000:80 → maps:
    server port 8000
    to container port 80
    --name docker-web-container → gives your container a name
    my-docker-app → the image to run

    Verify the Container is Running

    sudo docker ps

    Test It on the Server

    ubuntu@ip-172-31-39-151:~/docker-webapp$ curl http://13.60.92.28:8000/
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Docker Deployment</title>
    </head>
    <body style="margin:0; padding:0; background-color:#f4f6f9; font-family:Arial, sans-serif; display:flex; justify-content:center; align-items:center; height:100vh;">

        <div style="background:#ffffff; padding:40px; border-radius:10px; box-shadow:0 4px 15px rgba(0,0,0,0.1); text-align:center; width:90%; max-width:500px;">

            <h1 style="color:#2c3e50; margin-bottom:20px;">
                🚀 Successfully Deployed in Docker
            </h1>

            <p style="color:#555; font-size:16px; margin-bottom:15px;">
                This application is now running inside a Docker container.
            </p>

            <p style="color:#333; font-size:15px; background:#eef2ff; padding:10px; border-radius:6px;">
                📌 Task Submission: This deployment demonstrates successful containerization and execution of the application using Docker.
            </p>

            <p style="margin-top:20px; font-size:12px; color:#888;">
                Deployment Status: Active & Running
            </p>

        </div>

    </body>
    </html>


    Access in the browser

    http://13.60.92.28:8000/

    ![alt text](image.png)
