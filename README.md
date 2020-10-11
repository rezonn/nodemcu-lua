# NodeMCU LUA
## Hardware, soft
* wifi router
* [NodeMCU](https://www.ebay.com/sch/i.html?_nkw=nodemcu)
* Firmware (*.bin) from [nodemcu-build.com](https://nodemcu-build.com) to email. Modules: file,gpio,http,mdns,net,node,pwm,pwm2,tmr,uart,websocket,wifi,tls
* MacOS
```
sudo pip install esptool
sudo pip install nodemcu-uploader
```
## Flash
Connect NodeMCU to Mac via usb.
Flash nodemcu (replace port "/dev/cu.usbserial-1410" with your port *1)
```
sudo esptool.py --port /dev/cu.usbserial-1410 erase_flash
sudo esptool.py --port /dev/cu.usbserial-1410 write_flash --flash_size=detect 0 nodemcu.bin
```
Replace "wifissd", "wifipas" in [init.lua](init.lua) and upload to nodemcu *2
```
nodemcu-uploader -p /dev/cu.usbserial-1410 upload init.lua
```
Unplug and plug nodeMCU *5
## Notes
*1 - View ports:
```
ls /dev/
```
*2 - To view all files on nodemcu (make sure the file size on nodemcu is the same as on macos):
```
nodemcu-uploader --port /dev/cu.usbserial-1410 file list
```
*3 - HTTP GET:
```
uri = "https://www.google.com/search?q=nodemcu"
host = (uri.."/"):match("://(.-)/")
path = uri:match("://.-%f[/%z](/.*)")
srv = tls.createConnection()
srv:on("receive", function(sck, c) print(c:match("\r\n\r\n(.*)")) srv:close() end)
srv:on("connection", function(sck, c) sck:send("GET "..path.." HTTP/1.1\nHost: "..host.."\n\n") end)
srv:connect(443,host)
```
*4 - Servo motor:
```
k=1500 pin=4 gpio.mode(pin, gpio.OUTPUT)
m = tmr.create() m:register(20, tmr.ALARM_AUTO, function() gpio.write(pin,1) tmr.delay(k) gpio.write(pin,0) end)
b = tmr.create() b:register(800, tmr.ALARM_SINGLE, function() m:unregister() b:unregister() end)
m:start() b:start()
```
*5 - То turn on "d1" pin and turn off "d2" pin (replace nodemcu local ip 192.168.1.4)
```
http://192.168.1.4/?d1=1&d2=0
```
*6 - NodeMCU [documentation](https://nodemcu.readthedocs.io/en/release/lua-modules/README/)
