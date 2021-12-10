
s = "------\nmodules:\n------\n"
function printtable() for k in pairs(getmetatable(_G)['__index']) do s=s.." "..k end end printtable()
print(s)

if (wifi) then
	print("------\nwifi:\n------")
	print("country\t\t"..wifi.getcountry().country)
	print("channels\t"..wifi.getcountry().start_ch.."..."..wifi.getcountry().end_ch)
	if (wifi.getmode()==wifi.STATION) then
		print("ip\t\t\t"..wifi.sta.getip())
		print("mac\t\t\t"..wifi.sta.getmac())
		if wifi.sta.status()==wifi.STA_IDLE then print("status\t\tIDLE") end
		if wifi.sta.status()==wifi.STA_CONNECTING then print("status\t\tCONNECTING") end
		if wifi.sta.status()==wifi.STA_WRONGPWD then print("status\t\tWRONGPWD") end
		if wifi.sta.status()==wifi.STA_APNOTFOUND then print("status\t\tAPNOTFOUND") end
		if wifi.sta.status()==wifi.STA_FAIL then print("status\t\tFAIL") end
		if wifi.sta.status()==wifi.STA_GOTIP then print("status\t\tIDLE") end
	end
end

if (node) then
	print("------\nnode:\n------")
	print("heap "..node.heap().."b")
	print("flashsize "..node.flashsize().."b")
	for k,v in pairs(node.info("build_config")) do
	  print (k,v)
	end
	-- for k,v in pairs(node.info("sw_version")) do
	--   print (k,v)
	-- end
	print("memory ",node.egc.meminfo())
end

if file then
	print("------\nfiles:\n------")
	l = file.list();
	for k,v in pairs(l) do
	  print(k.."\t\t"..v.."b")
	end
end

if net then
	print("------\nnet:\n------")
	
	if net.server then print("addr"..net.server.getaddr()) end

	if (net.ifinfo(0)) then
		for k,v in pairs(net.ifinfo(0)) do
		  print (k,v)
		end
	end
end