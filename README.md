# Firewall

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
```

### La única VM que pueda navegar por internet sea cliente-03.
cliente-03 => 192.168.20.3
```
iptables -A FOWARD -s 192.168.20.3/32 -i eth1 -p udp -m multiport --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FOWARD -s 192.168.20.3/32 -i eth1 -p tcp -m multiport --sport 53,80,443 -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### La única VM de la red 192.168.20.0/24 que pueda ingresar al web server de la red 10.0 sea cliente-04.
```
```

# Servidor DHCP
Se instalo segun la [documentacion](https://servidordebian.org/es/wheezy/intranet/dhcp/server) y se agrego el subnet
```
subnet 192.168.20.0 netmask 255.255.255.0 {
  range 192.168.20.101 192.168.20.110;
}
```
