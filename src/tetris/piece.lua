require "element.object"

Piece = {}
Piece.__index = Piece

Piece.pattern = {}
Piece.pattern[1] = {}
Piece.pattern[1].x = 15
Piece.pattern[1].y = 6
Piece.pattern[1][1] = {
						{1, 1}, 
						{1, 1}
				   	  }
Piece.pattern[2] = {}
Piece.pattern[2].x = 15
Piece.pattern[2].y = 5
Piece.pattern[2][1] = {
						{0, 0, 0}, 
						{1, 1, 1}, 
						{0, 1, 0}
				      }
Piece.pattern[2][2] = {
						{0, 1, 0}, 
						{1, 1, 0}, 
						{0, 1, 0}
				      }
Piece.pattern[2][3] = {
						{0, 1, 0}, 
						{1, 1, 1}, 
						{0, 0, 0}
				      }
Piece.pattern[2][4] = {
						{0, 1, 0}, 
						{0, 1, 1}, 
						{0, 1, 0}
				      }
Piece.pattern[3] = {}
Piece.pattern[3].x = 15
Piece.pattern[3].y = 5
Piece.pattern[3][1] = {
						{0, 0, 0}, 
						{1, 1, 1}, 
						{0, 0, 1}
				      }
Piece.pattern[3][2] = {
						{0, 1, 0}, 
						{0, 1, 0}, 
						{1, 1, 0}
				      }
Piece.pattern[3][3] = {
						{1, 0, 0}, 
						{1, 1, 1}, 
						{0, 0, 0}
				      }
Piece.pattern[3][4] = {
						{0, 1, 1}, 
						{0, 1, 0}, 
						{0, 1, 0}
				      }
Piece.pattern[4] = {}
Piece.pattern[4].x = 15
Piece.pattern[4].y = 5
Piece.pattern[4][1] = {
						{0, 0, 0}, 
						{1, 1, 1}, 
						{1, 0, 0}
				      }
Piece.pattern[4][2] = {
						{1, 1, 0}, 
						{0, 1, 0}, 
						{0, 1, 0}
				      }
Piece.pattern[4][3] = {
						{0, 0, 1}, 
						{1, 1, 1}, 
						{0, 0, 0}
				      }
Piece.pattern[4][4] = {
						{0, 1, 0}, 
						{0, 1, 0}, 
						{0, 1, 1}
				      }
Piece.pattern[5] = {}
Piece.pattern[5].x = 15
Piece.pattern[5].y = 5
Piece.pattern[5][1] = {
						{0, 0, 0}, 
						{1, 1, 0}, 
						{0, 1, 1}
				      }
Piece.pattern[5][2] = {
						{0, 1, 0}, 
						{1, 1, 0}, 
						{1, 0, 0}
				      }
Piece.pattern[6] = {}
Piece.pattern[6].x = 15
Piece.pattern[6].y = 5
Piece.pattern[6][1] = {
						{0, 0, 0}, 
						{0, 1, 1}, 
						{1, 1, 0}
				      }
Piece.pattern[6][2] = {
						{0, 1, 0}, 
						{0, 1, 1}, 
						{0, 0, 1}
				      }
Piece.pattern[7] = {}
Piece.pattern[7].x = 14
Piece.pattern[7].y = 5
Piece.pattern[7][1] = {
						{0, 0, 0, 0}, 
						{1, 1, 1, 1}, 
						{0, 0, 0, 0}, 
						{0, 0, 0, 0}
				      }
Piece.pattern[7][2] = {
						{0, 1, 0, 0}, 
						{0, 1, 0, 0}, 
						{0, 1, 0, 0}, 
						{0, 1, 0, 0}
				      }

function Piece:new()
	local inst = {}
	setmetatable(inst, Piece)
	inst.type = love.math.random(1, 7)
	inst.rot = 1
	inst.state = Object:new()
	inst.state:copy(Piece.pattern[inst.type][inst.rot])
	inst.state:moveTo(Piece.pattern[inst.type].x, Piece.pattern[inst.type].y)
	return inst
end

function Piece:move(x, y)
	self.state:move(x, y)
end

function Piece:checkMove(x, y)
	local check = Object:new()
	check:copy(Piece.pattern[self.type][self.rot])
	check:moveTo(self.state.x, self.state.y)
	check:move(x, y)
	return check
end

function Piece:checkRot(rot)
	local check = Object:new()
	check:copy(Piece.pattern[self.type][rot])
	check:moveTo(self.state.x, self.state.y)
	return check
end

function Piece:copy(cpy)
	self.state:copy(cpy)
end

function Piece:draw()
	self.state:draw()
end
























