local cjson = require "cjson"
local mysql = require "resty.mysql"
local conf = require "conf.url_conf"


local function query_mysql()
	local db = mysql:new()

	db:connect{
		host = conf.mysql_ip,
		port = conf.mysql_port,
		database = conf.mysql_stock_db,
		user = conf.mysql_user,
		password = conf.mysql_password
		}

	local result, errstr, errno, sqlstate = db:query("select * from stock_infos") 

	if not result then
		ngx.say(errstr)
		return
	end

	db:set_keepalive(0,100)

	--ngx.say(cjson.encode(result))
	return result
end


local _M = {
	query_mysql = query_mysql,
}

return _M

