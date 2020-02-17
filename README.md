# Docker image for Etherpad Lite

The image is All in One Etherpad Lite.

How to use:

``` yaml
EP_USER=username
EP_PASS=password

docker run -d -p 8443:8443 --name eplite -e EP_USER=${EP_USER:?} -e EP_PASS=${EP_PASS:?} irixjp/eplite:latest
```

What does the image include?

- Ehterpad Lite
- SQLite3 backend
- Nginx
- Basic Authentication by Nginx
- Self-signed certificate
