# StartTech Architecture

# Overview

StartTech is a todo application that runs on AWS. The frontend is a React app and the backend is a Golang API. This document explains how all the pieces fit together.


When a user opens the app, the React frontend is served from S3 via CloudFront which makes it fast anywhere in the world. When the user interacts with the app, the frontend communicates with the Golang backend through the load balancer. Data is stored in MongoDB and Redis is used to cache frequently accessed data and manage user sessions.


# Network
A private network on AWS (VPC) was created with both public and private sections. The load balancer and EC2 instances live in the public section. Redis lives in the private section so it cannot be accessed from the internet.

# Backend
The Golang API runs inside Docker containers on EC2 instances. An Auto Scaling Group was configured so if traffic increases, AWS automatically adds more instances. If traffic drops, instances are removed. A load balancer sits in front and distributes traffic evenly.

# Frontend
The React app is built and uploaded to an S3 bucket. CloudFront sits in front of S3 and serves the files globally from the nearest location to the user.

# Database
MongoDB Atlas hosts the database on the free tier. Redis runs on ElastiCache and handles caching and user sessions.

# Monitoring
CloudWatch was configured to collect all logs from the backend and frontend. Alarms were set up to automatically scale the EC2 instances up when CPU is high and down when CPU is low.

#Security

- The load balancer is the only thing exposed to the internet
- EC2 instances only accept traffic from the load balancer
- Redis only accepts traffic from EC2 instances
- All passwords and secrets are stored in GitHub secrets, never in code
