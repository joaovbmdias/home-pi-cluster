docker kill poundhole

docker container rm poundhole

docker image rm poundhole

docker image rm pihole/pihole

docker image build -t poundhole:latest .

docker run -d --name poundhole -p 53:53/tcp -p 53:53/udp -p 80:80 -p 443:443 -e TZ="Europe/Lisbon" -v "$(pwd)/unbound/:/etc/unbound/unbound.conf.d/" -v "$(pwd)/roothints/:/var/lib/unbound/" --dns=127.0.0.1 --dns=1.1.1.1 --restart=unless-stopped --hostname pi.hole -e VIRTUAL_HOST="pi.hole" -e PROXY_LOCATION="pi.hole" -e ServerIP="127.0.0.1" poundhole 

docker ps