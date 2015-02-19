require "element.screen"
require "snake.body"
require "snake.egg"

Snake = {}
Snake.__index = Snake

Snake.wallLength = 14
Snake.time = 0.2

function Snake:new()
	local inst = {}
	setmetatable(inst, self)
	inst.background = Screen:new()
	local x = (Screen.length - Snake.wallLength) / 2 + 1
	local y = x + Snake.wallLength - 1
	for i = x - 2, y + 2 do
		for j = x - 2, y + 2 do
			inst.background.state[j][i] = 1
		end
	end
	for i = x, y do
		for j = x, y do
			inst.background.state[j][i] = 0
		end
	end
	inst.body = Body:new()
	inst.egg = inst:newEgg()

	inst.pastTime = 0
	return inst
end


function Snake:update(dt)
	self.pastTime = self.pastTime + dt
	if self.pastTime > Snake.time then
		self.pastTime = 0
		if self.body:checkMove() then
			if self:hasEgg() then
				self.body:grow()
				self.egg = self:newEgg()
			else
				self.body:move()
			end
		else
			return "exit"
		end
	end

	return ""
end

function Snake:draw()
	self.background:draw()
	self.body:draw()
	self.egg:draw()
end

function Snake:keypressed(key)
	if key == "escape" then
		return "exit"
	end

	if key == "right" or key == "left" or key == "up" or key == "down" then
		if key == self.body:oppositeDir() then
			return ""
		end
		self.body:setDir(key)
	end
	return ""
end

function Snake:newEgg()
	local egg
	while true do
		egg = Egg:new()
		if not self.body:has(egg.x, egg.y) then
			break
		end
	end
	return egg
end

function Snake:hasEgg()
	local x, y = self.body:headMove()
	x = self.body.loc[1].x + x
	y = self.body.loc[1].y + y

	if x == self.egg.x and y == self.egg.y then
		return true
	else
		return false
	end
end




















