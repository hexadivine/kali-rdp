FROM kalilinux/kali-rolling

RUN apt update 
RUN apt install kali-desktop-xfce -y
RUN apt install dbus-x11 xrdp -y 
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN echo "root:root" | chpasswd
RUN useradd -ms /bin/bash kali
RUN echo "kali:kali" | chpasswd

EXPOSE 3399

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
