# Use an official lightweight Python image
FROM python:3.11-slim-bullseye

# Set environment variables
# PYTHONDONTWRITEBYTECODE: Prevents Python from writing .pyc files
# PYTHONUNBUFFERED: Ensures console output is not buffered by Docker
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (required for building certain Python packages like psycopg2)
RUN apt-get update \
    && apt-get install -y gcc libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the Django project into the container
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# The command to run the application (using Daphne for ASGI/WebSockets)
# Replace 'core.asgi:application' with your actual project name
CMD ["daphne", "-b", "0.0.0.0", "-p", "8000", "core.asgi:application"]