-- Projectiles.Lua
-- Projectile definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Projectiles = { }
Projectiles.imageManager = require("scripts/Image.lua")
Projectiles.enemyManager = require("scripts/Enemy.lua")
Projectiles.collisionManager = require("scripts/Collision.lua")
Projectiles.soundManager = require("scripts/Sound.lua")
Projectiles.itemManager = require("scripts/Item.lua")
require("scripts/Randomlua.lua")
Projectiles.mTwister = twister(0)

-- Default Beam
local DefaultBeam = 
{
	Animation = { },
	StartHealth = 1,
	MaxHealth = 1
}
local DefaultBeamAnimation = 
{
	Speed = 0,
	Frame = { }
}

function DefaultBeam.update(dt, Object)
	if (Object.Position.X >= 650) then Object.delete() end
	Object.setPosition(vector2d(Object.Position.X + (dt * 120), Object.Position.Y)) 
	
	--- Hacked Collision Detection
	for i = 1, Projectiles.enemyManager.getCount() do
		local Enemy = Projectiles.enemyManager.getEnemy(i)
		if (Projectiles.collisionManager.checkCollision(Object, Enemy)) then
			if (Enemy.Health <= 1 and Object.DELETE_ME == nil) then
				Enemy.delete()
				Object.delete()
			
				local Rnd = Projectiles.mTwister:random(1,4)
			
				if (Rnd < 4) then 
					local newItem = Projectiles.itemManager.addItem(Projectiles.itemManager.ItemDataBase.Money)
					newItem.playAnimation("Animation")
					newItem.setPosition(Enemy.getPosition())
					newItem.setScale(vector2d(1.5,1.5))
					newItem.setVisible(true)
					newItem.Value = 10
				end
			
				love.audio.play( Projectiles.soundManager.loadSound("media/sounds/Damage.wav"))	
			elseif (Enemy.Health > 1 and Object.DELETE_ME == nil) then
				Enemy.Health = Enemy.Health - 1
				Object.delete()
				love.audio.play( Projectiles.soundManager.loadSound("media/sounds/Damage.wav"))	
			end
		end
	end
end

DefaultBeamAnimation.FrameCount = 1
DefaultBeamAnimation.Frame[1] = Projectiles.imageManager.loadImage("media/textures/Beam.png") 
DefaultBeam.Animation["BeamAnimation"] = DefaultBeamAnimation

table.insert(Projectiles, DefaultBeam)
Projectiles["DefaultBeam"] = DefaultBeam

-- Missile
local Missile = 
{
	Animation = { },
	StartHealth = 1,
	MaxHealth = 1
}
local MissileAnimation = 
{
	Speed = 0,
	Frame = { }
}

function Missile.update(dt, Object)
	if (Object.Position.X >= 650) then Object.delete() end
	Object.setPosition(vector2d(Object.Position.X + (dt * 120), Object.Position.Y)) 
	
	--- Hacked Collision Detection
	for i = 1, Projectiles.enemyManager.getCount() do
		local Enemy = Projectiles.enemyManager.getEnemy(i)
		if (Projectiles.collisionManager.checkCollision(Object, Enemy)) then
			if (Enemy.Health <= 1 and Object.DELETE_ME == nil) then
				Enemy.delete()
				Object.delete()
			
				local Rnd = Projectiles.mTwister:random(1,4)
			
				if (Rnd < 4) then 
					local newItem = Projectiles.itemManager.addItem(Projectiles.itemManager.ItemDataBase.Money)
					newItem.playAnimation("Animation")
					newItem.setPosition(Enemy.getPosition())
					newItem.setScale(vector2d(1.5,1.5))
					newItem.setVisible(true)
					newItem.Value = 10
				end
			
				love.audio.play( Projectiles.soundManager.loadSound("media/sounds/Damage.wav"))	
			elseif (Enemy.Health > 1 and Object.DELETE_ME == nil) then
				Enemy.Health = Enemy.Health - 2
				Object.delete()
				love.audio.play( Projectiles.soundManager.loadSound("media/sounds/Damage.wav"))	
			end
		end
	end
end

MissileAnimation.FrameCount = 1
MissileAnimation.Frame[1] = Projectiles.imageManager.loadImage("media/textures/Missile.png") 
Missile.Animation["Animation"] = MissileAnimation

table.insert(Projectiles, Missile)
Projectiles["Missile"] = Missile

-- PeaShooter Beam
local PeaShooterBeam = 
{
	Animation = { },
	StartHealth = 1,
	MaxHealth = 1
}
local PeaShooterBeamAnimation = 
{
	Speed = 0,
	Frame = { }
}

function PeaShooterBeam.update(dt, Object)
	if (Object.Position.X <= -20) then Object.delete() end
	Object.setPosition(vector2d(Object.Position.X - (dt * 120), Object.Position.Y)) 
	
end

PeaShooterBeamAnimation.FrameCount = 1
PeaShooterBeamAnimation.Frame[1] = Projectiles.imageManager.loadImage("media/textures/Beam.png") 
PeaShooterBeam.Animation["BeamAnimation"] = PeaShooterBeamAnimation

table.insert(Projectiles, PeaShooterBeam)
Projectiles["PeaShooterBeam"] = PeaShooterBeam


return Projectiles
