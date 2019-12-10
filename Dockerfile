FROM node:7-onbuild
LABEL maintainer="Stuart Lynas"
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://13.82.223.100:8000 || exit 1
EXPOSE 8080