local function split(str, delim)
	local s,e
	local i = 1
	local c = 1
	local r = {}

	while true do
		s, e = string.find(str, delim, i)
		if not s then
			sub = string.sub(str,i)
			r[c] = sub

			break
		end

		local sub = string.sub(str,i,e-1)
		r[c] = sub
		
		i = e + 1
		c = c + 1
	end

	return r
end


local _M = {
	split = split,


}

return _M

