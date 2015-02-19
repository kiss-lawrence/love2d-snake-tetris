require "transition.transition"
require "menu.menu"
require "tetris.tetris"
require "snake.snake"

function love.load()
	transition = Transition:new()
	isTransition = true
	transitionTo = "menu"

	major = Menu:new()
	menuPage = 1
end

function love.update(dt)
	if isTransition then
		local mode = transition:update(dt)
		if mode == "half" then
			isTransiton = false
			if transitionTo == "menu" then
				major = Menu:new()
				major:setGame(menuPage)
				major:setArrow()
			elseif transitionTo == "tetris" then
				love.keyboard.setKeyRepeat(true)
				menuPage = Menu.indexRev.tetris
				major = Tetris:new()
			elseif transitionTo == "snake" then
				love.keyboard.setKeyRepeat(false)
				menuPage = Menu.indexRev.snake
				major = Snake:new()
			end

		elseif mode == "over" then
			isTransition = false
			transition:clear()
		end
	else
		if transitionTo == "menu" then

		else
			exit = major:update(dt)
			if exit == "exit" then
				isTransition = true
				transitionTo = "menu"
			end
		end
	end
end

function love.draw()
	major:draw()

	if isTransition then
		transition:draw()
	end
end

function love.keypressed(key)
	if isTransition == true then
		return
	end

	if transitionTo == "menu" then
		major:keypressed(key)

	else
		exit = major:keypressed(key)
		if exit == "exit" then
			isTransition = true
			transitionTo = "menu"
		end
	end
end

function love.keyreleased(key)
	if isTransition == true then
		return
	end

	if transitionTo == "menu" then
		local game = major:keyreleased(key)
		if game ~= nil then
			local gameName = Menu.index[game]
			isTransition = true
			if gameName == "tetris" then
				transitionTo = "tetris"
			elseif gameName == "snake" then
				transitionTo = "snake"
			end
		end
	end
end



















