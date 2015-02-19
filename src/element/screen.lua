Screen = {}
Screen.__index = Screen

Screen.length = 30
Screen.size = 20
Screen.margin = 2

function Screen:new()
	local inst = {}
	setmetatable(inst, self)
	inst.state = {}
	for i = 1, Screen.length do
		inst.state[i] = {}
		for j = 1, Screen.length do
			inst.state[i][j] = 0
		end
	end
	return inst
end

function Screen:copy(cpy)
	self.state = cpy
end

function Screen:has(x, y)
	if self.state[y][x] == 1 then
		return true
	else
		return false
	end
end

function Screen:set(x, y, bool)
	self.state[y][x] = bool
end

function Screen:clear()
	for i = 1, Screen.length do
		for j = 1, Screen.length do
			self.state[i][j] = 0
		end
	end
end

function Screen:draw()
	local size = Screen.size
	local margin = Screen.margin
	for i = 1, Screen.length do
		for j = 1, Screen.length do
			if self.state[j][i] == 1 then
				love.graphics.rectangle("fill", (i - 1) * size + margin, (j - 1) * size + margin, 
										size - 2 * margin, size - 2 * margin)
			end
		end
	end
end


















