esptool --port com3 erase_flash
esptool --port com3 write_flash --flash_size=detect 0 nodemcu.bin

nodemcu-uploader --port com3 file list

nodemcu-uploader upload init.lua


nodemcu-uploader file print init.lua
nodemcu-uploader node restart
nodemcu-uploader node heap
nodemcu-uploader file remove foo.lua

esptool --port com3 write_flash --flash_size=detect 0 integer.bin

curl "http://192.168.1.7/?d2=0&d3=0&d4=0"
pause

