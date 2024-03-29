# [NodeMCU](https://www.ebay.com/sch/i.html?_nkw=nodemcu) [LUA](https://nodemcu.readthedocs.io/)
☘ Arduino free ☘
* Install [CH340 driver](http://www.wch-ic.com/downloads/CH341SER_EXE.html)
* Receive Firmware (*.bin) from [nodemcu-build.com](https://nodemcu-build.com) to email. Modules: file,gpio,http,mdns,net,node,pwm,pwm2,tmr,uart,websocket,wifi,tls
```
pip3 install esptool
pip3 install nodemcu-uploader
pip3 install --upgrade pyserial --user
```
* Connect NodeMCU->USB->Mac. Flash nodemcu (replace port "/dev/cu.usbserial-1410" with your port *1)
```
esptool.py --port /dev/cu.usbserial-1410 erase_flash
esptool.py --port /dev/cu.usbserial-1410 write_flash --flash_size=detect 0 nodemcu.bin
```
* Replace "wifissd", "wifipas" in [init.lua](init.lua) and upload to nodemcu
```
nodemcu-uploader -p /dev/cu.usbserial-1410 upload init.lua
nodemcu-uploader node restart
```
* Try blink "d4" pin 100 times at 10Hz
```
http://nodemcu/?hz=10&d4=100s
```
* Use [Sublime](https://www.sublimetext.com/download): Tools -> Build system -> New build system
```
{
	"shell_cmd": "nodemcu-uploader --port /dev/cu.usbserial-1410 upload $file_name && nodemcu-uploader --port /dev/cu.usbserial-1410 file do $file_name"
}
```
[more](https://www.electronicwings.com/nodemcu/stepper-motor-interfacing-with-nodemcu)
## LUA tips
Deep sleep = shutdown + delay 5sec + start with init.lua. **[Connect](https://www.ebay.com/sch/i.html?_nkw=Breadboard+Jumper+Cable+Male+to+Male) RST and D0 pins**
```
node.dsleep(5000000)
```
Use timer 5 sec.
```
tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
print("hello world!")
end)
```
Eval
```
loadstring("print(15)")()
```
HTTP GET (Doesn't work at startup, needs a timer):
```
uri = "https://www.google.com/search?q=nodemcu"
host = (uri.."/"):match("://(.-)/")
path = uri:match("://.-%f[/%z](/.*)")
srv = tls.createConnection()
srv:on("receive", function(sck, c) print(c:match("\r\n\r\n(.*)")) srv:close() end)
srv:on("connection", function(sck, c) sck:send("GET "..path.." HTTP/1.1\nHost: "..host.."\n\n") end)
srv:connect(443,host)
```
[Servo](https://servodatabase.com/?sort=price) (replace 40 to 30...140 for [sg90](https://www.ebay.com/sch/i.html?_nkw=sg90) - just connect it to G,3V,D4 pins):
```
pin=4 pwm.setup(pin,50,0) pwm.setduty(pin, 40) tmr.delay(600000) pwm.stop(pin)
```
## Notes
*1 - View ports on MacOS:
```
ls /dev/
```
*2 - file list
```
nodemcu-uploader --port /dev/cu.usbserial-1410 file list
```
