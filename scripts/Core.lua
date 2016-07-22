-- Core.lua
-- Core System for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Core = { }
Core.run = true
Core.inputManager = require("scripts/Input.lua")
Core.objectManager = require("scripts/objectManager.lua")
Core.GUIManager = require("scripts/GUI.lua")
Core.projectileManager = require("scripts/Projectile.lua")
Core.playerManager = require("scripts/Player.lua")
Core.itemManager = require("scripts/Item.lua")
Core.enemyManager = require("scripts/Enemy.lua")
Core.timerManager = require("scripts/Timer.lua")
Core.collisionManager = require("scripts/Collision.lua")

function love.run()
	if love.load then love.load(arg) end

	local dr = 0

	-- Main loop time.
	while true do
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
		if love.graphics then
			love.graphics.clear()
			if love.draw then love.draw() end
		end

		-- Process Events.
		if love.event then
			for e,a,b,c in love.event.poll() do
				if e == "q" or Core.inputManager.keyPressed("escape") or Core.run == false then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				end
			love.handlers[e](a,b,c)
		end
	end

	if love.timer then love.timer.sleep(1) end
	if love.graphics then love.graphics.present() end
	
	end
end

function Core.quit()
	Core.run = false
end

function Core.update(dt)
	Core.collisionManager.update(dt)
	Core.itemManager.update(dt)
	Core.timerManager.update(dt)
	Core.playerManager.update(dt)
	Core.projectileManager.update(dt)
	Core.enemyManager.update(dt)
	Core.objectManager.update(dt)
	Core.GUIManager.update(dt)
end
return Core
