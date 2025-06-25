local M = {}

---Joins a list of strings
---@param array string[]
---@param separator string
---@return string
function M.join_strings(array, separator)
	separator = separator or "," -- default separator is comma if not provided
	local result = ""

	for i, value in ipairs(array) do
		if i > 1 then
			result = result .. separator
		end
		result = result .. value
	end

	return result
end

return M
