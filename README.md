# nodemcu-without-arduino

## Hardware
* MacOS
* NodeMCU
## Software
* esptool - for flash
```
sudo pip install esptool
```
* [NodeJS](https://nodejs.org/en/download/) - for nodemcu-uploader
* nodemcu-uploader - for upload lua sripts
```
sudo npm install nodemcu-tool -g
```
* firmaware - Get on the mail on the [nodemcu-build.com](https://nodemcu-build.com). You receive somthing like "nodemcu-master-11-modules-2018-08-30-16-36-06-integer.bin"
## Detect macos port and nodemcu baud
You can view you ports
```
ls /dev/
```
New port must appear after plug NodeMCU via usb.
My port is /dev/cu.wchusbserialfa130.
Read baud on your nodemcu. Its like 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, or 115200.
My baud is 9600.

## Flashing
```
sudo esptool.py --port /dev/cu.wchusbserialfa130 erase_flash
```
```
sudo esptool.py --port /dev/cu.wchusbserialfa130 --baud 9600 write_flash --flash_size=detect 0 nodemcu-master-11-modules-2018-08-30-16-36-06-integer.bin
```
You can see
```
esptool.py v2.3.1
Connecting....
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
...
```
After 3-5 min:
```
Wrote 585936 bytes (383191 compressed) at 0x00000000 in 403.4 seconds (effective 11.6 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
logout
Saving session...
...copying shared history...
...saving history...truncating history files...
...completed.
```
## Listen USB
```
nodemcu-uploader --baud 9600 --port /dev/cu.wchusbserialfa130 terminal
```
You can see
```
> --- Miniterm on /dev/cu.wchusbserialfa130  115200,8,N,1 ---
> --- Quit: Ctrl+] | Menu: Ctrl+T | Help: Ctrl+T followed by Ctrl+H ---
> 
```
You can write lua here
```
x=5 print(x)
```
You see
```
> x=5 print(x)
5
```
Setup wifi here:
```
wifi.ap.config({ssid="error",pwd="321321321"})
```
Now you can coonect to nodemcu from macos
* Select "error" in macos wifi
* Set 321321321 as password
## Make lua scrript
Copy this code
```
    -- create a server
    sv=net.createServer(net.TCP, 30)
    -- listen port
    sv:listen(80,function(c)
      c:on("receive", function(c, pl) print(pl) end)
      body = "hello world"
      c:send(table.concat({
        "HTTP/1.1 200 OK",
        "Content-Type: text/plain",
        "Connection: close",
        "Content-length: " .. #body,
        "",
        body
      }, "\r\n"));
    end)
```
Save on desktop as server.lua. 
In terminal write:
```
nodemcu-uploader --port /dev/cu.wchusbserialfa130 upload ~/Desktop/server.lua
```
Run it from nodemcu:
```
nodemcu-uploader --baud 9600 --port /dev/cu.wchusbserialfa130 file do server.lua
```
To view all files on nodemcu:
```
nodemcu-uploader --port /dev/cu.wchusbserialfa130 file list
```
