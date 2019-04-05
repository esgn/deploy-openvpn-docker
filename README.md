# Why ?

Having to work on many public or corporate Wi-Fi/LAN and struggling with port restrictions, I ended up making this little script to deploy rapidly an OpenVPN container on my dedicated server.

## The idea

* First scan Wi-Fi or LAN network for open ports with nmap (nmap someopenhost.com -Pn)
* Deploy a remote OpenVPN container on an available port/protocol
* Use the generated .ovpn configuration file to set up client access (WARNING : LZO compression must be actived)

## How ?

Just launch the sh script. Docker must be installed.

```bash deploy_openvpn.sh```
