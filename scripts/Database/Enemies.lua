-- Enemies.Lua
-- Enemy object definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Enemies = { }
Enemies.imageManager = require("scripts/Image.lua")
Enemies.projectileManager = require("scripts/Projectile.lua")
require("scripts/randomLua.lua")
mTwister = twister(0)

-- PeaShooter for our PAFBLA game
local PeaShooter = 
{
	Name = "PeaShooter",
	Animation = { },
	StartHealth = 1,
	MaxHealth = 1
}
local PeaAnimation = 
{
	Speed = 0,
	Frame = { }
}
PeaAnimation.FrameCount = 1
PeaAnimation.Frame[1] = Enemies.imageManager.loadImage("media/textures/Pea_Shooter.png") 
PeaShooter.Animation["PeaAnimation"] = PeaAnimation

function PeaShooter.update(dt, Object)
	if (Object.Position.X < -30) then Object.delete() end
	Object.setPosition(vector2d(Object.Position.X - (dt * 100), Object.Position.Y))
	
	local Rand = mTwister:random(1,200)
	
	if (Rand < 3) then
		local Projectile = Enemies.projectileManager.addProjectile(Enemies.projectileManager.ProjectileDataBase.PeaShooterBeam)
		Projectile.setPosition(vectorAdd(Object.getPosition(), vector2d(-3, 4)))
		Projectile.setScale(vector2d(3,3))
		Projectile.playAnimation("BeamAnimation")
		Projectile.setDrawDepth(16)
	end
end

function PeaShooter.draw(Object)
end

table.insert(Enemies, PeaShooter)
Enemies["PeaShooter"] = PeaShooter

-- Don't Tell Drew ;)
local RagoraBouncer = 
{
	Name = "RagoraBouncer",
	Animation = { },
	StartHealth = 2,
	MaxHealth = 2
}
local RagoraAnimation = 
{
	Speed = 0,
	Frame = { }
}
RagoraAnimation.FrameCount = 1
RagoraAnimation.Frame[1] = Enemies.imageManager.loadImage("media/textures/Floating_Ball_Thing.png") 
RagoraBouncer.Animation["RagoraAnimation"] = RagoraAnimation

function RagoraBouncer.update(dt, Object)
	if (Object.Position.X < -30) then Object.delete() end
	if (Object.Position.Y > 325 and (Object.Movement == false or Object.Movement == nil) ) then
		Object.setPosition(vector2d(Object.Position.X, Object.Position.Y - (dt * 50)))
	else
		Object.Movement = true
	end
	if (Object.Position.Y < 374 and Object.Movement) then
		Object.setPosition(vector2d(Object.Position.X, Object.Position.Y + (dt * 50)))
	else
		Object.Movement = false
	end
	Object.setPosition(vector2d(Object.Position.X - (dt * 100), Object.Position.Y))
end

function RagoraBouncer.draw(Object)
end

table.insert(Enemies, RagoraBouncer)
Enemies["RagoraBouncer"] = RagoraBouncer

return Enemies
