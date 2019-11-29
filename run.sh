#!/usr/bin/env bash
docker build -t image .
docker run -p 80:80 -it image