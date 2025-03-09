# Docker image for Etherpad Lite

The image is All in One Etherpad Lite.

``` yaml
EP_USER=username
EP_PASS=password

docker run -d -p 80:80 -p 443:443 --name eplite -e EP_USER=${EP_USER:?} -e EP_PASS=${EP_PASS:?} irixjp/eplite:latest
```
> Default setting is only http. If You want to use https, configure nginx.conf in the container.
> Prepare certifications, then `vi /etc/nginx/nginx.cnf`, and finaly `nginx -t` `nginx -s reload`


What does the image include?

- Ehterpad Lite
- SQLite3 backend
- Nginx
- Basic Authentication by Nginx
