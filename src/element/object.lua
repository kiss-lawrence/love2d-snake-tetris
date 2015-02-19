Object = {}
Object.__index = Object

Object.size = 20
Object.margin = 2

function Object:new()
	local inst = {}
	setmetatable(inst, self)
	inst.state = {{0}}
	inst.width = 1
	inst.height = 1
	inst.x = 1
	inst.y = 1
	return inst
end

function Object:copy(cpy)
	self.state = cpy
	self.width = #self.state[1]
	self.height = #self.state
end

function Object:clear()
	for i = 1, self.width do
		for j = 1, self.height do
			self.state[j][i] = 0
		end
	end
end

function Object:move(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

function Object:moveTo(x, y)
	self.x = x
	self.y = y
end

function Object:draw()
	local size = Object.size
	local margin = Object.margin
	for i = 1, self.width do
		for j = 1, self.height do
			if self.state[j][i] == 1 then
				local x, y = self.x + i - 1, self.y + j - 1
				love.graphics.rectangle("fill", (x - 1) * size + margin, (y - 1) * size + margin, 
										size - 2 * margin, size - 2 * margin)
			end
		end
	end
end







