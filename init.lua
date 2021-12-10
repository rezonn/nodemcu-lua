wifi.sta.sethostname("nodemcu")
conf={} conf.ssid="wifissd" conf.pwd="wifipas" wifi.setmode(wifi.STATION) wifi.sta.config(conf)
function proc(url)
	hz=250
	pin={d1=1,d2=2,d3=3,d4=4,d6=6,d7=7,d8=8,rx=9,tx=10,s2=11,s3=12}
	for k,v in string.gmatch(url,"[??&](%w+)=(%w+)") do
		if k=="hz" then 
			hz=tonumber(v)
		else 
			p=pin[k]
			if string.find(v,"s") then
				v = tonumber(string.sub(v,0,#v-1))
				pwm.setup(p,hz,0) pwm.setduty(p, 512)
				tmr.create():alarm(v/hz * 1000, tmr.ALARM_SINGLE, function()
					pwm.stop(p) pwm.close(p)
				end)
			else 
				v = tonumber(v)
				gpio.mode(p, gpio.OUTPUT) gpio.write(p,v)
			end
		end
	end
end
net.createServer(net.TCP,30):listen(80,function(c) c:on("receive",function(c,url) proc(url) body="OK" c:send("HTTP/1.1 200 OK\nContent-Type: text/html\nConnection: close\nContent-length: "..#body.."\n\n"..body) end) end)
