local stock_url = "http://hq.sinajs.cn/"

local redis_ip = "127.0.0.1"
local redis_port = 6379

local mysql_ip = "127.0.0.1"
local mysql_port = "3306"
local mysql_user = "root"
local mysql_password = "123456"
local mysql_stock_db = "stock"

local _M = {
	stock_url = stock_url,
	redis_ip = redis_ip,
	redis_port = redis_port,
	mysql_ip = mysql_ip,
	mysql_port = mysql_port,
	mysql_user = mysql_user,
	mysql_password = mysql_password,
	mysql_stock_db = mysql_stock_db,

}

return _M

