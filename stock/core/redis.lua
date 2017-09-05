local cjson = require "cjson"
local redis = require "resty.redis" 
local conf = require "conf.url_conf"

local function set_kv(k, v)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	ok, err = red:set(k, v)
	if not ok then
		ngx.say("failed to set kv")
	end

	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end
end

local function get_k(k)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	local result, err = red:get(k)
	if not ok then
		ngx.say("failed to set kv")
		return
	end

	if ok == ngx.null then
		ngx.say("k not faound")
		return
	end

	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end

	ngx.say(result)
end

local function hset_kv(h, k, v)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	ok, err = red:hmset(h, k, v)
	if not ok then
		ngx.say("failed to hset kv")
	end

	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end
end

local function hget_k(h, k)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	local result, err = red:hget(h, k)
	if not ok then
		ngx.say("failed to set kv")
		return
	end

	if result == ngx.null then
		ngx.say("k not found")
		return
	end

	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end

	ngx.say(result)
end

local function hgetall_k(k)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	local result, err = red:hgetall(k)
	if not ok then
		ngx.say("failed to set kv")
		return
	end

	if result == ngx.null then
		ngx.say("k not found")
		return
	end


	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end
	
	return result
end

local function del_k(k)
	local red = redis:new()
	red:set_timeout(1000)

	local ok, err = red:connect(conf.redis_ip, conf.redis_port)
	if not ok then
		ngx.say("failed to connect redis")
		return
	end

	local ok, err = red:del(k)
	if not ok then
		ngx.say("failed to del k")
		return
	end

	ok, err = red:set_keepalive(10000, 10)
	if not ok then
		ngx.say("failed to set keepalive")
	end

end

local _M = {
	set_kv = set_kv,
	get_k = get_k,
	hset_kv = hset_kv,
	hget_k = hget_k,
	hgetall_k = hgetall_k,
	del_k = del_k,
}

return _M

