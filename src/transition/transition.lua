require "element.screen"

Transition = {}
Transition.__index = Transition

Transition.pattern = {}
local dis = 29
for i = 1, 15 do
	Transition.pattern[i] = {}
	for j = 1, 30 do
		Transition.pattern[i][j] = {}
		for k = 1, 30 do
			if math.abs(15.5 - j) + math.abs(15.5 - k) >= dis then
				Transition.pattern[i][j][k] = 1
			else
				Transition.pattern[i][j][k] = 0
			end
		end
	end
	dis = dis - 2
end

Transition.time = 0.04

function Transition:new()
	local inst = {}
	setmetatable(inst, self)
	inst.pastTime = 0
	inst.frame = 0
	inst.patternIndex = 0
	inst.screen = Screen:new()
	return inst
end

function Transition:clear()
	self.screen:clear()
	self.pastTime = 0
	self.frame = 0
	self.patternIndex = 0
end

function Transition:update(dt)
	self.pastTime = self.pastTime + dt
	local mode = "normal"
	if self.pastTime > Transition.time then
		if (self.frame + 1 > 30) then
			return "over"
		else
			self.pastTime = 0
			self.frame = self.frame + 1
			self.patternIndex = 15.5 - math.abs(15.5 - self.frame)
			self.screen:copy(Transition.pattern[self.patternIndex])
			if self.frame == 16 then
				mode = "half"
			end
		end
	end
	return mode
end

function Transition:draw()
	self.screen:draw()
end


















