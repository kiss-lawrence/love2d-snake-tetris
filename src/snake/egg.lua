Egg = {}
Egg.__index = Egg

function Egg:new()
	local inst = {}
	setmetatable(inst, self)
	inst.x = love.math.random(9, 22)
	inst.y = love.math.random(9, 22)
	return inst
end

function Egg:draw()
	local x, y = self.x, self.y
	love.graphics.rectangle("fill", (x - 1) * 20 + 2, (y - 1) * 20 + 2, 16, 16)
end

