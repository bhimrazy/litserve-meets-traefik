# Use an official Python runtime as a parent image
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set environment variables
ENV APP_USER=appuser
ENV APP_HOME=/app

# Create the appuser
RUN groupadd -r $APP_USER && useradd -r -g $APP_USER $APP_USER \
    && mkdir -p $APP_HOME \
    && chown -R $APP_USER:$APP_USER $APP_HOME

# Set the working directory
WORKDIR $APP_HOME

# Copy requirements.txt file to the container at /app
COPY ./requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Run server.py when the container launches
CMD ["python", "server.py"]
