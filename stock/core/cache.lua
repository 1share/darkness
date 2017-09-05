local cjson = require "cjson"
local redis = require "redis"

local stock_cache = {
	cache_stock_infos = {},
}

local last_update_time = 0

local function update_cache()
	local result = redis.hgetall_k("stock_infos")
        if #result == 0 then
                ngx.say("failed to update")
                return
        end

        stock_cache.cache_stock_infos = result
end

local function update()
	local ctime = ngx.time()

	if ctime - last_update_time < 90 then
		ngx.say("not need to update cache")
		return
	end

	last_update_time = ctime

	ngx.timer.at(1, update_cache)

end

local function get_stock_infos()
	return stock_cache.cache_stock_infos
end

local _M = {
	update = update,
	get_stock_infos = get_stock_infos,
}

return _M

