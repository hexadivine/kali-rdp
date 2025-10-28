echo "Removing old files if any..."

sudo docker stop remote_kali_by_hexadivine 2>/dev/null
sudo docker rm remote_kali_by_hexadivine 2>/dev/null
sudo docker rmi remote_kali_by_hexadivine 2>/dev/null


############################################################################

read -rsp "Provide password for root (default:root): " rootPassword
echo

rootPassword=${rootPassword:-root}
sed -i "8c\\RUN echo 'root:${rootPassword}' | chpasswd" Dockerfile

############################################################################

read -p "Provide username (default:kali): " username
read -rsp "Provide password for given user (default:kali): " userPassword
echo

username=${username:-kali}
userPassword=${userPassword:-kali}

sed -i "9c\\RUN useradd -ms /bin/bash $username" Dockerfile
sed -i "10c\\RUN echo '${username}:${userPassword}' | chpasswd" Dockerfile

############################################################################

mkdir /home/$USER/kali_container

sudo docker build . -t remote_kali_by_hexadivine
sudo docker run -d --name remote_kali_by_hexadivine -p 3399:3399 -v /home/$USER/kali_container:/home/$username/  --restart unless-stopped --privileged  remote_kali_by_hexadivine

############################################################################

sed -i '8c\RUN echo "root:root" | chpasswd' Dockerfile
sed -i '9c\RUN useradd -ms /bin/bash kali' Dockerfile
sed -i '10c\RUN echo "kali:kali" | chpasswd' Dockerfile
