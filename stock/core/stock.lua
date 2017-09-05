local cjson = require("cjson")
local db = require("db")
local http = require("http")
local redis = require("redis")
local cache = require("cache")
local utils = require("utils")

local function format_stock_info(result)
	for _, v in ipairs(result) do
		local s = utils.split(v, "\"")
		if s then
			ngx.say(s[2])
		end
	end
end

local function stock_server()                        
	--local result = redis.hgetall_k("stock_infos")

	cache.update()
	local stock_infos = cache.get_stock_infos()

        local request_infos = {}
	local i = 1
        for k, v in ipairs(stock_infos) do
		if i%2 == 1  then
        		table.insert(request_infos, {func = http.query_http, list = v})
		end
		i = i + 1
        end

	local result = {}
	for i = 1, #request_infos do
		local spawn_info = request_infos[i]
		local ok ,res = ngx.thread.wait(ngx.thread.spawn(spawn_info.func, spawn_info.list))
		if not ok then
			ngx.say("failed to run")
		else
			table.insert(result, res)
		end
        end

	format_stock_info(result)
end

local _M = {
	stock_server = stock_server,
}

return _M

