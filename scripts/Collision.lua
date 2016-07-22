-- Collision.lua
-- Collision manager for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Collision = { }
require("scripts/Vector.lua")
Collision.enemyManager = require("scripts/Enemy.lua")
Collision.itemManager = require("scripts/Item.lua")
Collision.genericManager = require("scripts/Generic.lua")

function Collision.update(dt)
	
end

function Collision.checkCollision(ObjectOne, ObjectTwo, Mode)
	if (Mode == nil) then Mode = "Pixel" end	-- "Pixel" mode will be added in later versions
	--return false
	-- For now only supports "box" mode
	local Pos1 = ObjectOne.getPosition()
	local Pos2 = ObjectTwo.getPosition()
	local Image1 = ObjectOne.Animation[ObjectOne.currentAnimation].Frame[ObjectOne.currentFrame]
	local Image2 = ObjectTwo.Animation[ObjectTwo.currentAnimation].Frame[ObjectTwo.currentFrame]
	local Width1 = Image1:getWidth()
	local Height1 = Image1:getHeight()
	local Width2 = Image2:getWidth()
	local Height2 = Image2:getHeight()
	
	if (Mode == "Iteration") then	-- Slow as crap, not really recommended
		local StopVector1 = vector2d( Pos1.X + (Width1 * ObjectOne.Scale.X), Pos1.Y + (Height1 * ObjectOne.Scale.Y))
		local StopVector2 = vector2d( Pos2.X + (Width2 * ObjectTwo.Scale.X), Pos2.Y + (Height2 * ObjectTwo.Scale.Y))

		-- Check Collision, FirstObject
		for X = Pos1.X, StopVector1.X do
			for Y = Pos1.Y, StopVector1.Y do
				if (vectorWithin(Pos2, StopVector2, vector2d(X,Y))) then return true end
			end
		end
		return false
	end
	
	local Point1_2 = vector2d( Pos1.X + (Width1 * ObjectOne.Scale.X), Pos1.Y)
	local Point1_3 = vector2d( Pos1.X, Pos1.Y + (Height1 * ObjectOne.Scale.Y))
	local Point1_4 = vector2d( Pos1.X + (Width1 * ObjectOne.Scale.X), Pos1.Y + (Height2 * ObjectTwo.Scale.Y))
	
	--local Point2_2 = vector2d( Pos2.X + (Width2 * ObjectTwo.Scale.X), Pos2.Y)
	--local Point2_3 = vector2d( Pos2.X, Pos2.Y + (Height2 * ObjectTwo.Scale.Y))
	local Point2_4 = vector2d( Pos2.X + (Width2 * ObjectTwo.Scale.X), Pos2.Y + (Height2 * ObjectTwo.Scale.Y))
	
	if (vectorWithin(Pos2, Point2_4, Pos1) or vectorWithin(Pos2, Point2_4, Point1_2) or vectorWithin(Pos2, Point2_4, Point1_3) or vectorWithin(Pos2, Point2_4, Point1_4)) then
		return true
	else
		return false
	end
end

return Collision
