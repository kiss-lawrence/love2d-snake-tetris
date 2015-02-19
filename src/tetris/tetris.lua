require "tetris.piece"
require "tetris.ground"

Tetris = {}
Tetris.__index = Tetris

Tetris.gravity = 0.5

function Tetris:new()
	local inst = {}
	setmetatable(inst, self)
	inst.piece = Piece:new()
	inst.ground = Ground:new()
	inst.pastTime = 0

	inst.isFlickering = false
	return inst
end

function Tetris:keypressed(key)
	if key == "escape" then
		return "exit"
	end

	if self.isFlickering then
		return ""
	end

	if key == "left" then
		self:keypressedLeft()
	elseif key == "right" then
		self:keypressedRight()
	elseif key == "up" then
		self:keypressedUp()
	elseif key == "down" then
		self:keypressedDown()
	end
end

function Tetris:keypressedLeft()
	local newLoc = self.piece:checkMove(-1, 0)
	if self:isMovable(newLoc) then
		self.piece:move(-1, 0)
	end
end

function Tetris:keypressedRight()
	local newLoc = self.piece:checkMove(1, 0)
	if self:isMovable(newLoc) then
		self.piece:move(1, 0)
	end
end

function Tetris:keypressedUp()
	local rot = self.piece.rot + 1
	if rot > #Piece.pattern[self.piece.type] then
		rot = 1
	end

	local newLoc = self.piece:checkRot(rot)
	if self:isMovable(newLoc) then
		self.piece.rot = rot
		self.piece:copy(Piece.pattern[self.piece.type][self.piece.rot])
	end
end

function Tetris:keypressedDown()
	local newLoc = self.piece:checkMove(0, 1)
	if self:isMovable(newLoc) then
		self.piece:move(0, 1)
	else
		self.ground:add(self.piece.state)
		line = self.ground:check(self.piece.state)
		if #line > 0 then
			self.isFlickering = true
		else
			self.piece = Piece:new()
		end
	end
	self.pastTime = 0
end

function Tetris:update(dt)
	if not self.isFlickering then
		if self.ground.top <= 6 then
			return "exit"
		end
		
		self.pastTime = self.pastTime + dt
		if self.pastTime > Tetris.gravity then
			self:keypressedDown()
		end
	else
		over = self.ground:update(dt)
		if over == "over" then
			self.ground:delete()
			self.isFlickering = false
			self.piece = Piece:new()
		end
	end
	return ""
end

function Tetris:draw()
	self.ground:draw()
	if not self.isFlickering then
		self.piece:draw()
	end
end

function Tetris:isMovable(newLoc)
	for i = 1, newLoc.width do
		for j = 1, newLoc.height do
			local x, y = newLoc.x + i - 1, newLoc.y + j - 1
			if newLoc.state[j][i] == 1 and self.ground.state:has(x, y) then
				return false
			end
		end
	end
	return true
end

























