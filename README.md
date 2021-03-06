# Trabajo practico integrador
Materia: **Computacion Aplicada**  
Alumno: **Juan Cruz Alfieri**  
Docente: **Ignacio Sanchez**  
Cuatrimestre: **1ero 2020**  
Legajo **94970**  

## WebServer
Para la instalacion del mismo, se descargaron los arhicvos de java-jdk y tomcat. Luego se descomprimieron en /opt utilizando `tar`. Se agrego al `.bashrc` el export para JAVA
```
export JAVA_HOME=/opt/jdk1.8.0_131
export PATH=$JAVA_HOME/bin:$PATH
```

Para ver el example de Tomcat se utiizo el archivo `startup.sh` que provee el mismo.

## Firewall
### Red del firewall
Dentro de `/etc/network/interfaces`, se declararon las siguientes redes:
```
auto eth0
iface eth0 inet static
        address 192.168.0.37
        netmask 255.255.255.0
        gateway 192.168.0.1
        
auto eth1
iface eth1 inet static
        address 192.168.10.1
        netmask 255.255.255.0
        
auto eth2
iface eth2 inet static
        address 192.168.20.1
        netmask 255.255.255.0
```

## Pasos
### El firewall deberá cargar la configuración de iptables al inicio.

- Guardar iptables  `iptables-save > /etc/firewall.conf`
- Abrir `/etc/network/if-up.d/iptables` y agregar el siguiente contenido:
```
#!/bin/sh

iptables-restore < /etc/firewall.conf
```
- Hacer ejecutable el archivo `chmod +x /etc/network/if-up.d/iptables`

### Las políticas por defecto de las 3 cadenas de la tabla FILTER sea DROP.
```
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
```

### El tráfico desde/hacia la interfaz loopback sea posible.
```
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT
```

### La única VM que pueda administrar el firewall vía ssh (puerto tcp 22) sea cliente-02.
cliente-02 => 192.168.20.2
```
iptables -A INPUT -p tcp -s 192.168.20.2/32 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d 192.168.20.2/32 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

### La única VM que pueda navegar por internet sea cliente-03.
cliente-03 => 192.168.20.3
```
iptables -A FORWARD -s 192.168.20.3/32 -i eth1 -p udp -m multiport --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -s 192.168.20.3/32 -i eth1 -p tcp -m multiport --sport 53,80,443 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A POSTROUTING -t nat -s 192.168.20.3/32 -j MASQUERADE
```

### La única VM de la red 192.168.20.0/24 que pueda ingresar al web server de la red 10.0 sea cliente-04.
cliente-04 => 192.168.20.4
```
-A FORWARD -s 192.168.10.3/32 -d 192.168.20.4/32 -p tcp
-A FORWARD -d 192.168.10.3/32 -s 192.168.20.4/32 -p tcp
```

## Servidor DHCP
Se instalo segun la [documentacion](https://servidordebian.org/es/wheezy/intranet/dhcp/server) y se agrego el subnet
```
subnet 192.168.20.0 netmask 255.255.255.0 {
  range 192.168.20.101 192.168.20.110;
  option routers 192.168.20.1;
}
```

## LVM
Para el uso de LVM se sigio la siguiente [documentacion](https://techencyclopedia.wordpress.com/2018/03/11/how-to-install-debian-8-by-manually-creating-lvm-linux-partitions/).
![LVM](https://raw.githubusercontent.com/alfijuan/up-ca-tp-integrador/master/lvm-client02.png)

Se utilizo un disco fisico de 15GB en el que se creo un VG con 5 LV dentro apuntando a 5 filesystems.
