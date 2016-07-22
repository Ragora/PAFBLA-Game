-- Items.Lua
-- Item definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Items = { } 
Items.imageManager = require("scripts/Image.lua")

-- Shield1
-- 1/15 chance from enemies
local Shield1 =
{
	Name = "Shield1",
	EnemyPickup = false,
	PlayerPickup = true,
	Animation = { }
}
local Shield1Animation = 
{
	Speed = 500, -- In Milliseconds
	Frame = { }
}
Shield1Animation.FrameCount = 3
Shield1Animation.Frame[1] = Items.imageManager.loadImage("media/textures/Shield1_1.png")
Shield1Animation.Frame[2] = Items.imageManager.loadImage("media/textures/Shield1_2.png") 
Shield1Animation.Frame[3] = Items.imageManager.loadImage("media/textures/Shield1_3.png") 
Shield1.Animation["IdleAnimation"] = Shield1Animation
function Shield1.update(dt, Object)
	Object.setPosition(vector2d(Object.Position.X - (100 * dt), Object.Position.Y))
end

function Shield1.onPickup()
end

function Shield1.draw(Object)
end

Items["Shield1"] = Shield1
table.insert(Items, Shield1)

-- Shield2
-- 1/15 chance from enemies
local Shield2 =
{
	Name = "Shield2",
	EnemyPickup = false,
	PlayerPickup = true,
	Animation = { }
}
local Shield2Animation = 
{
	Speed = 500, -- In Milliseconds
	Frame = { }
}
Shield2Animation.FrameCount = 3
Shield2Animation.Frame[1] = Items.imageManager.loadImage("media/textures/Shield2_1.png")
Shield2Animation.Frame[2] = Items.imageManager.loadImage("media/textures/Shield2_2.png") 
Shield2Animation.Frame[3] = Items.imageManager.loadImage("media/textures/Shield2_3.png") 
Shield2.Animation["IdleAnimation"] = Shield2Animation
function Shield2.update(dt, Object)
	Object.setPosition(vector2d(Object.Position.X - (100 * dt), Object.Position.Y))
end

function Shield2.onPickup()
end

function Shield2.draw(Object)
end

Items["Shield2"] = Shield2
table.insert(Items, Shield2)

-- Money
-- 1/15 chance from enemies
local Money =
{
	Name = "Money",
	EnemyPickup = false,
	PlayerPickup = true,
	Animation = { }
}
local MoneyAnimation = 
{
	Speed = 500, -- In Milliseconds
	Frame = { }
}
MoneyAnimation.FrameCount = 2
MoneyAnimation.Frame[1] = Items.imageManager.loadImage("media/textures/Currency_1.png")
MoneyAnimation.Frame[2] = Items.imageManager.loadImage("media/textures/Currency_2.png") 
Money.Animation["Animation"] = MoneyAnimation
function Money.update(dt, Object)
	Object.setPosition(vector2d(Object.Position.X - (100 * dt), Object.Position.Y))
end

function Money.onPickup()
end

function Money.draw(Object)
end

Items["Money"] = Money
table.insert(Items, Money)

return Items
