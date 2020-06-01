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
cliente-02 => 192.1168.20.2
```
iptables -A INPUT -p tcp -s 192.1168.20.2/32 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
```

### La única VM que pueda navegar por internet sea cliente-03.
```
```

### La única VM de la red 192.168.20.0/24 que pueda ingresar al web server de la red 10.0 sea cliente-04.
```
```
