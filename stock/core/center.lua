local cjson = require "cjson"
local redis = require "redis"
local db = require "db"

local function stock_sync()
	local stock_infos = db.query_mysql()
	
	redis.del_k("stock_infos")
	for _,v in ipairs(stock_infos) do
		--ngx.say(cjson.encode(v))
		redis.hset_kv("stock_infos", v.stock_center .. v.stock_id, "1")
	end
	
end

local _M = {
	stock_sync = stock_sync,

}

return _M

