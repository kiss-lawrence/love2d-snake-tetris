Body = {}
Body.__index = Body

Body.initX, Body.initY = 15, 15

function Body:new()
	local inst = {}
	setmetatable(inst, self)

	inst.loc = {}
	inst.loc[1] = {}
	inst.loc[1].x = Body.initX
	inst.loc[1].y = Body.initY
	inst.length = 1
	inst.dir = "right"
	return inst
end

function Body:setDir(dir)
	self.dir = dir
end

function Body:oppositeDir()
	if self.dir == "right" then
		return "left"
	elseif self.dir == "left" then
		return "right"
	elseif self.dir == "down" then
		return "up"
	else
		return "down"
	end
end

function Body:headMove()
	if self.dir == "right" then
		return 1, 0
	elseif self.dir == "left" then
		return -1, 0
	elseif self.dir == "down" then
		return 0, 1
	else
		return 0, -1
	end
end

function Body:has(x, y)
	for i = 1, self.length do
		if x == self.loc[i].x and y == self.loc[i].y then
			return true
		end
	end
	return false
end

function Body:checkMove()
	local x, y = self:headMove()
	x = self.loc[1].x + x
	y = self.loc[1].y + y

	if x < 9 or x > 22 or y < 9 or y > 22 then
		return false
	end
	for i = 2, self.length do
		if x == self.loc[i].x and y == self.loc[i].y then
			return false
		end
	end
	return true
end

function Body:move()
	for i = self.length, 2, -1 do
		self.loc[i].x = self.loc[i - 1].x
		self.loc[i].y = self.loc[i - 1].y
	end
	local x, y = self:headMove()
	self.loc[1].x = self.loc[1].x + x
	self.loc[1].y = self.loc[1].y + y
end

function Body:grow()
	local tail = self.length + 1
	self.loc[tail] = {}
	self.loc[tail].x = self.loc[self.length].x
	self.loc[tail].y = self.loc[self.length].y

	for i = self.length, 2, -1 do
		self.loc[i].x = self.loc[i - 1].x
		self.loc[i].y = self.loc[i - 1].y
	end
	self.length = tail

	local x, y = self:headMove()
	self.loc[1].x = self.loc[1].x + x
	self.loc[1].y = self.loc[1].y + y
end

function Body:draw()
	for i = 1, self.length do
		local x, y = self.loc[i].x, self.loc[i].y
		love.graphics.rectangle("fill", (x - 1) * 20 + 2, (y - 1) * 20 + 2, 16, 16)
	end
end


























