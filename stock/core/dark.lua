local function dark_info(info)
	ngx.print(info .. ":home-src")
end

local function server()
	ngx.print('hellollllllllllllllllll')
	ngx.log(ngx.CRIT,'hellollllllllllllllllll')
end

local function pserver()
	local trace = function(msg)
		ngx.log(ngx.CRIT, tostring(msg) .. '\n' .. debug.traceback() .. '\n')
	end
	
	xpcall(server, trace)

end

local _M = {
	welcome = dark_info,
	server = pserver,
}

return _M

