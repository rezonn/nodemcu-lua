# NodeMCU LUA

## Hardware, soft
* MacOS
* [NodeMCU](https://www.ebay.com/sch/i.html?_nkw=nodemcu)
* Firmware (*.bin) from [nodemcu-build.com](https://nodemcu-build.com) to mail

## Flash
```
sudo pip install esptool
pip install nodemcu-uploader
```
Connect NodeMCU. 
View ports:
```
ls /dev/
```
flash (replace port '/dev/cu.usbserial-1410' with your port)
```
sudo esptool.py --port /dev/cu.usbserial-1410 erase_flash
sudo esptool.py --port /dev/cu.usbserial-1410 write_flash --flash_size=detect 0 nodemcu.bin
nodemcu-uploader -p /dev/cu.usbserial-1410 upload init.lua
```
init.lua (replace wifissd, wifipas)
```
conf={}
conf.ssid="wifissd"
conf.pwd="wifipas"
conf.save=false
wifi.setmode(wifi.STATION)
wifi.sta.config(conf)
function proc(url) 
  local pin = {d1=1,d2=2,d3=3,d4=4,d6=6,d7=7,d8=8,rx=9,tx=10,s2=11,s3=12}
  for k, v in string.gmatch(url, "[??&](%w+)=(%w+)") do 
    p=pin[k] 
    v=tonumber(v) 
    gpio.mode(p, gpio.OUTPUT) 
    gpio.write(p,v) 
  end 
end
net.createServer(net.TCP, 30):listen(80,function(c) 
  local body = "OK"
  c:on("receive", function(c, url) 
    proc(url) c:send("HTTP/1.1 200 OK\nContent-Type: text/html\nConnection: close\nContent-length: "..#body.."\n\n" .. body)
  end) 
end)
```
## Notes
То turn on "d1" pin and turn off "d2" pin (replace nodemcu local ip 192.168.1.4)
```
http://192.168.1.4/?d1=0&d2=0
```
To view all files on nodemcu:
```
nodemcu-uploader --port /dev/cu.wchusbserialfa130 file list
```
