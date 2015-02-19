require "element.screen"
require "element.math"

Ground = {}
Ground.__index = Ground

Ground.time = 0.1
Ground.times = 5

function Ground:new()
	local inst = {}
	setmetatable(inst, self)
	inst.state = Screen:new()
	for i = 9, 22 do
		for j = 4, 27 do
			inst.state.state[j][i] = 1
		end
	end
	for i = 11, 20 do
		for j = 6, 25 do
			inst.state.state[j][i] = 0
		end
	end

	inst.fullLine = {}
	inst.pastTime = 0
	inst.pastTimes = 0
	inst.top = 26
	return inst
end

function Ground:add(obj)
	for i = 1, obj.width do
		for j = 1, obj.height do
			if obj.state[j][i] == 1 then
				local x, y = obj.x + i - 1, obj.y + j - 1
				self.state:set(x, y, 1)
				self.top = Math.min(y, self.top)
			end
		end
	end
end

function Ground:check(obj)
	local arr = {}
	for i = obj.height, 1, -1 do
		for j = 1, obj.width do
			if obj.state[i][j] == 1 then
				arr[#arr + 1] = obj.y + i - 1
				break
			end
		end
	end

	local ret = {}
	for i = 1, #arr do
		local bool = true
		local y = arr[i]
		for x = 11, 20 do
			if not self.state:has(x, y) then
				bool = false
				break
			end
		end
		if bool then
			ret[#ret + 1] = y
		end
	end
	self.fullLine = ret
	return ret
end

function Ground:update(dt)
	self.pastTime = self.pastTime + dt
	if self.pastTime > Ground.time then
		self.pastTime = 0
		self.pastTimes = self.pastTimes + 1
		if self.pastTimes == Ground.times then
			self.pastTimes = 0
			return "over"
		else
			for i = 1, #self.fullLine do
				local y = self.fullLine[i]
				for x = 11, 20 do
					self.state.state[y][x] = 1 - self.state.state[y][x]
				end
			end
		end
	end
	return ""
end

function Ground:delete()
	for i = 1, #self.fullLine do
		local bottom = self.fullLine[i]
		local top = self.top + 1
		for y = bottom, top, -1 do
			for x = 11, 20 do
				self.state.state[y][x] = self.state.state[y - 1][x]
			end
		end
		for x = 11, 20 do
			self.state.state[self.top][x] = 0
		end
		for j = i + 1, #self.fullLine do
			self.fullLine[j] = self.fullLine[j] + 1
		end
		self.top = self.top + 1
	end
end

function Ground:draw()
	self.state:draw()
end



















