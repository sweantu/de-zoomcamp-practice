## KESTRA PRACTICE

```
docker network create kestra-network 
docker run --network kestra-network --rm -it -p 8080:8080 --user=root -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp kestra/kestra:latest server local
```