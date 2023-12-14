# Use the official Python base image
FROM python:3.8.5

# RUN apt update
# RUN apt upgrade

# Installation of gdal
# RUN apt install -y gdal-bin libgdal-dev libgeos-dev libproj-dev

# Installation of python and virtualenv
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     libgdal-dev gdal-bin build-essential && \
#     rm -rf /var/lib/apt/lists/*
#  RUN apt install -y python3-pip python3-dev python3-virtualenv python3-venv virtualenvwrapper

# Other essential tools
# RUN apt install -y software-properties-common build-essential
# RUN apt install -y git unzip gcc zlib1g-dev libgeos-dev libproj-dev
# RUN apt install -y vim

# # Install Openjdk
# RUN apt install openjdk-8-jdk-headless default-jdk-headless -y
# RUN update-java-alternatives --jre-headless --jre --set java-1.8.0-openjdk-amd64

# Set the working directory inside the container
# WORKDIR /app


RUN apt-get update \
    && apt-get install -y binutils libproj-dev gdal-bin python-gdal python3-gdal    





RUN apt-get update && apt-get install -y gdal-bin \
     apt-utils libgdal-dev
# install dependencies
RUN apt-get update && \
    apt-get install -y gcc python3-dev musl-dev \
    gdal-bin \
    libgeos-dev \
    libffi-dev \
    proj-bin \
    libopenblas-dev \ 
    python3-scipy python3-numpy python3-pandas \
    netcat \
    nano

RUN apt-get update && apt-get install -y gdal-bin \
     apt-utils libgdal-dev

# COPY ./requirements.txt /app/requirements.txt



# Run this to install geoserver-rest dependencies
RUN pip install pygdal=="`gdal-config --version`.*"
# RUN pip install pygdal==2.4.2.10

RUN pip install -I GDAL=="`gdal-config --version`.*"


# # Create and activate a Python virtual environment
# #RUN python -m venv myenv
# #RUN /bin/bash -c "source myenv/bin/activate"

# # If using GDAL make sure extension is downloaded
# RUN if [ "$GDAL_NATIVE" = true ] && [ ! -f /tmp/resources/plugins/geoserver-gdal-plugin.zip ]; then \
#   wget --progress=bar -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-gdal-plugin.zip \
#   -O /tmp/resources/plugins/geoserver-gdal-plugin.zip; \
# fi;
# Copy the requirements file to the working directory
COPY requirements.txt requirements.txt

# Install the Python dependencies
RUN pip install -r requirements.txt

#RUN pip install uvicorn fastapi pipwin pipwin install geoserver_rest lxml pydantic Pygments pydantic-core

# RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Install GDAL dependencies
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     libgdal-dev gdal-bin && \
#     rm -rf /var/lib/apt/lists/*

# Install GDAL dependencies and build essentials
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     libgdal-dev gdal-bin build-essential && \
#     rm -rf /var/lib/apt/lists/*

WORKDIR /app

# RUN pip install uvicorn fastapi
# # RUN pipwin refresh
# # RUN pipwin install gdal 
# RUN pip install lxml pydantic Pygments pydantic-core shapely requests geopandas

# RUN pip install pygdal=="`gdal-config --version`.*"

# RUN pip install gdal==3.0.4

# RUN pip install geoserver_rest==2.3.4

# RUN pip install geoserver-rest
# Copy the application code to the working directory
# Copy the application code to the working directory
COPY . .

# Expose the port on which the application will run
EXPOSE 8000

# Run the FastAPI application using uvicorn server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# docker run -d --name mycontainer -p 80:80 myimage