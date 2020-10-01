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
Replace "wifissd", "wifipas" in [init.lua](init.lua) and upload to nodemcu *2
```
nodemcu-uploader -p /dev/cu.usbserial-1410 upload init.lua
```
## Notes
*1 - View ports:
```
ls /dev/
```
То turn on "d1" pin and turn off "d2" pin (replace nodemcu local ip 192.168.1.4)
```
http://192.168.1.4/?d1=1&d2=0
```
*2 - To view all files on nodemcu:
```
nodemcu-uploader --port /dev/cu.wchusbserialfa130 file list
```
Servo motor:
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
NodeMCU (documentation)[https://nodemcu.readthedocs.io/en/release/modules/wifi/#wifistasethostname]
