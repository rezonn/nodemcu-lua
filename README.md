# NodeMCU LUA
## Hardware, soft
* wifi router
* [NodeMCU](https://www.ebay.com/sch/i.html?_nkw=nodemcu)
* Firmware (*.bin) from [nodemcu-build.com](https://nodemcu-build.com) to mail
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
Replace "wifissd", "wifipas" in [init.lua](init.lua) (<540b) and upload to nodemcu *2
```
nodemcu-uploader -p /dev/cu.usbserial-1410 upload init.lua
```
## Notes
*1 - View ports:
```
ls /dev/
```
*2 - To view all files on nodemcu:
```
nodemcu-uploader --port /dev/cu.usbserial-1410 file list
```
*5 - HTTP GET:
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
stp={2,1500,20000}
gpio.mode(stp[1], gpio.OUTPUT)
tmr.alarm(1,stp[3]/1000, tmr.ALARM_AUTO, function() 
	gpio.write(stp[1],1) 
	tmr.delay(stp[2]) 
	gpio.write(stp[1],0)
	end)
tmr.start(1)
```
*5 - То turn on "d1" pin and turn off "d2" pin (replace nodemcu local ip 192.168.1.4)
```
http://192.168.1.4/?d1=1&d2=0
```
*6 - NodeMCU [documentation](https://nodemcu.readthedocs.io/en/release/lua-modules/README/)
