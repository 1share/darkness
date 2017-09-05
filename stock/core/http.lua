local cjson = require "cjson"
local http = require "resty.http"
local conf = require "conf.url_conf"

local function query_http(stock_list)
	local stock_param = "list=" .. stock_list

	local httpc = http.new()
	httpc:set_timeout(300)
	local scheme, host, port, path, query = unpack(httpc:parse_uri(conf.stock_url, true))

	httpc:connect(host, port)
	
	local result, errstr = httpc:request({  method = "GET",
						path = path,
						query = stock_param,
						headers = {
							Host = host,
						},
					     })
	

	if not result then 
		ngx.say("failed to request!")
		return
	end

	local body, errstr = result:read_body()

	local ok, errstr = httpc:set_keepalive(0, 100)
	if not ok then
		ngx.say("failed to set keepalive")
		return
	end

	return body
end

local _M = {
	query_http = query_http,

}

return _M

