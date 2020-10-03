conf={} conf.ssid="wifissd" conf.pwd="wifipas" wifi.setmode(wifi.STATION) wifi.sta.config(conf)
function proc(url) pin={d1=1,d2=2,d3=3,d4=4,d6=6,d7=7,d8=8,rx=9,tx=10,s2=11,s3=12} for k,v in string.gmatch(url,"[??&](%w+)=(%w+)") do p=pin[k] gpio.mode(p, gpio.OUTPUT) gpio.write(p,tonumber(v)) end end
net.createServer(net.TCP,30):listen(80,function(c) c:on("receive",function(c,url) proc(url) c:send("HTTP/1.1 200 OK\nContent-Type: text/html\nConnection: close\nContent-length: OK\n\n" .. body) end) end)
