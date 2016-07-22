-- Draw.lua
-- Draw handler for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Draw = { }
require("scripts/vector.lua")
Draw.debugDraw = false
Draw.debugDrawColor = { }
Draw.debugDrawColor["Player"] = vector4d( 0, 0, 255, 255 )	 -- Blue
Draw.debugDrawColor["Item"] = vector4d( 0, 255, 0, 255 )	 -- Green
Draw.debugDrawColor["Enemy"] = vector4d( 255, 0, 0, 255 )	 -- Red
Draw.debugDrawColor["NULL"] = vector4d( 255, 255, 255, 255 ) -- White

Draw.playerManager = require("scripts/Player.lua")
Draw.itemManager = require("scripts/Item.lua")
Draw.genericManager = require("scripts/Generic.lua")
Draw.enemyManager = require("scripts/Enemy.lua")
Draw.inputManager = require("scripts/Input.lua")
Draw.timerManager = require("scripts/Timer.lua")
Draw.projectileManager = require("scripts/Projectile.lua")
Draw.GUIManager = require("scripts/GUI.lua")

function Draw.setDebugDrawEnabled(dbgDraw)
	Draw.debugDraw = dbgDraw
end

-- Function: Draw.getDrawBuffer()
function Draw.getDrawBuffer()
	local tBuffer = { }
	local High = 0
	-- Cycle through the player manager first
	for i = 1, Draw.playerManager.getCount() do
		local Object = Draw.playerManager.getPlayer(i)
		if (Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through the item manager now
	for i = 1, Draw.itemManager.getCount() do
		local Object = Draw.itemManager.getItem(i)
		if (Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through the enemy manager now
	for i = 1, Draw.enemyManager.getCount() do
		local Object = Draw.enemyManager.getEnemy(i)
		if (Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through the Projectile manager now
	for i = 1, Draw.projectileManager.getCount() do
		local Object = Draw.projectileManager.getProjectile(i)
		if (Object ~= nil and Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through the generic object manager now
	for i = 1, Draw.genericManager.getCount() do
		local Object = Draw.genericManager.getItem(i)
		if (Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through the GUI object manager now
	for i = 1, Draw.GUIManager.getCount() do
		local Object = Draw.GUIManager.getElement(i)
		if (Object.drawDepth > High) then High = Object.drawDepth end
		table.insert(tBuffer, Object)
	end
	
	-- Cycle through our temp buffer and sort the objects now
	local Buffer = { }
	for i = 1, High do
		for h = 1, table.getn(tBuffer) do
			local Object = tBuffer[h]
			if (Object.drawDepth == i and Object.getIsVisible()) then
				table.insert(Buffer, Object)
			end
		end
	end
	
	return Buffer
end

function Draw.updateAnimation(Object)
	Object.scheduledAnimation = Draw.timerManager.Schedule(Draw.updateAnimation, Object, 0, 0, Object.Animation[Object.currentAnimation].Speed)

	if (Object.currentFrame >= Object.Animation[Object.currentAnimation].FrameCount) then
		Object.currentFrame = 1
	else
		Object.currentFrame = Object.currentFrame + 1
	end
end

function Draw.draw()
	local Buffer = Draw.getDrawBuffer()
	
	local oR, oG, oB, oA = love.graphics.getColor()
	for i = 1, table.getn(Buffer) do
		local Object = Buffer[i]
		--if (Object.currentAnimation ~= nil) then
		
		if (Object.Rotation == nil) then Object.Rotation = 0 end
		love.graphics.setColor(Object.Color.X, Object.Color.Y, Object.Color.Z, Object.Color.R)
		love.graphics.draw( Object.Animation[Object.currentAnimation].Frame[Object.currentFrame], Object.Position.X, Object.Position.Y,
			Object.Rotation, Object.Scale.X, Object.Scale.Y, 0, 0)
		if (Draw.inputManager.keyPressed("f12")) then
			local doR, doG, doB, doA = love.graphics.getColor()
			local Color = Draw.debugDrawColor[Object.getClassName()]
			if (Color == nil) then Color = Draw.debugDrawColor["NULL"] end
			love.graphics.setColor(Color.X, Color.Y, Color.Z, Color.R )
				
			local Image = Object.Animation[Object.currentAnimation].Frame[Object.currentFrame]
			local Width = Image:getWidth()
			local Height = Image:getHeight()
			love.graphics.rectangle("line", Object.Position.X, Object.Position.Y, Width * Object.Scale.X, Height * Object.Scale.Y)
			love.graphics.setColor(doR, doG, doB, doA)
		end
		if (Object.scheduledAnimation == nil) then
			Object.scheduledAnimation = Draw.timerManager.Schedule(Draw.updateAnimation, Object, 0, 0, Object.Animation[Object.currentAnimation].Speed)
		end
	end
	love.graphics.setColor(oR, oG, oB, oA)
end

return Draw
