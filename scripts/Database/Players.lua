-- Players.Lua
-- Player object definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Players = { }
Players.imageManager = require("scripts/Image.lua")
Players.inputManager = require("scripts/Input.lua")
Players.collisionManager = require("scripts/Collision.lua")
Players.enemyManager = require("scripts/Enemy.lua")
Players.itemManager = require("scripts/Item.lua")
Players.soundManager = require("scripts/Sound.lua")
Players.projectileManager = require("scripts/Projectile.lua")

-- MainPlayer for our PAFBLA game
-- Side view, dodges enemies and other blahblah
local MainPlayer = 
{
	Animation = { },
	StartHealth = 2,
	MaxHealth = 5,
	Name = "MainPlayer",
}
local PlayerAnimation = 
{
	Speed = 0,
	Frame = { }
}
PlayerAnimation.FrameCount = 1
PlayerAnimation.Frame[1] = Players.imageManager.loadImage("media/textures/Bike_Upgrade.png") 
local ShieldAnimationOne = 
{
	Speed = 0,
	Frame = { }
}
ShieldAnimationOne.FrameCount = 1
ShieldAnimationOne.Frame[1] = Players.imageManager.loadImage("media/textures/Bike_Powerup1.png") 
local ShieldAnimationTwo = 
{
	Speed = 0,
	Frame = { }
}
ShieldAnimationTwo.FrameCount = 1
ShieldAnimationTwo.Frame[1] = Players.imageManager.loadImage("media/textures/Bike_Powerup2.png") 
local PlayerDeath =
{
	Speed = 0.5,
	Frame = { }
}
PlayerDeath.FrameCount = 13
PlayerDeath.Frame[1] = Players.imageManager.loadImage("media/textures/PlayerExplode1.png") 
PlayerDeath.Frame[2] = Players.imageManager.loadImage("media/textures/PlayerExplode2.png") 
PlayerDeath.Frame[3] = Players.imageManager.loadImage("media/textures/PlayerExplode3.png") 
PlayerDeath.Frame[4] = Players.imageManager.loadImage("media/textures/PlayerExplode4.png") 
PlayerDeath.Frame[5] = Players.imageManager.loadImage("media/textures/PlayerExplode5.png") 
PlayerDeath.Frame[6] = Players.imageManager.loadImage("media/textures/PlayerExplode6.png") 
PlayerDeath.Frame[7] = Players.imageManager.loadImage("media/textures/PlayerExplode7.png") 
PlayerDeath.Frame[8] = Players.imageManager.loadImage("media/textures/PlayerExplode8.png") 
PlayerDeath.Frame[9] = Players.imageManager.loadImage("media/textures/PlayerExplode9.png") 
PlayerDeath.Frame[10] = Players.imageManager.loadImage("media/textures/PlayerExplode10.png") 
PlayerDeath.Frame[11] = Players.imageManager.loadImage("media/textures/PlayerExplode11.png") 
PlayerDeath.Frame[12] = Players.imageManager.loadImage("media/textures/PlayerExplode12.png") 
PlayerDeath.Frame[13] = Players.imageManager.loadImage("media/textures/PlayerExplode13.png") 

MainPlayer.Animation["PlayerAnimation"] = PlayerAnimation
MainPlayer.Animation["ShieldAnimationOne"] = ShieldAnimationOne
MainPlayer.Animation["ShieldAnimationTwo"] = ShieldAnimationTwo
MainPlayer.Animation["Death"] = PlayerDeath

function MainPlayer.onButtonPressed(Key, Unicode, Object)
end

function MainPlayer.onButtonReleased(Key, Unicode, Object)
end

function MainPlayer.onCollision(Object, ColObject)
end

function MainPlayer.update(dt, Object)
	Object.deltaTime = Object.deltaTime + dt
	if (Object.Alive == false) then return end
	--- Hacked Collision Detection
	for i = 1, Players.itemManager.getCount() do
		local Item = Players.itemManager.getItem(i)
		
		if (Players.collisionManager.checkCollision(Object, Item)) then
			if (Item.Name == "Shield1") then
				Object.runningShieldOne = true
				Object.playAnimation("ShieldAnimationOne")
				love.audio.play( Players.soundManager.loadSound("media/sounds/Shield_get.wav"))
			end
			if (Item.Name == "Shield2") then
				Object.runningShieldTwo = true
				Object.runningShieldOne = true
				Object.playAnimation("ShieldAnimationTwo")
				love.audio.play( Players.soundManager.loadSound("media/sounds/Shield_get.wav"))
			end
			if (Item.Name == "Money") then
				love.audio.play( Players.soundManager.loadSound("media/sounds/Get_cash.wav"))
				Object.Money = Object.Money + Item.Value
			end
			Item.delete()
		end
	end
	
	
	for i = 1, Players.enemyManager.getCount() do
		local Enemy = Players.enemyManager.getEnemy(i)
		Object.justCollided = false
		
		if (Players.collisionManager.checkCollision(Object, Enemy)) then
			love.audio.play( Players.soundManager.loadSound("media/sounds/Damage.wav"))
			if (Object.runningShieldTwo and Object.runningShieldOne and Enemy.DELETE_ME == nil) then
				Object.runningShieldTwo = false
				Object.playAnimation("ShieldAnimationOne")
				Object.justCollided = true
			elseif (Object.runningShieldOne and Object.justCollided == false and Enemy.DELETE_ME == nil) then
				Object.runningShieldOne = false
				Object.playAnimation("PlayerAnimation")
			else
				Object.setHealth(Object.getHealth() - 1)
				if (Object.getHealth() <= 0) then Object.DEAD = true end
			end
			
			Enemy.delete()
			--bject.Health = Object.Health - 1
		end
	end
	
	for i = 1, Players.projectileManager.getCount() do
		local Projectile = Players.projectileManager.getProjectile(i)
		Object.justCollided = false
		
		if (Players.collisionManager.checkCollision(Object, Projectile)) then
			love.audio.play( Players.soundManager.loadSound("media/sounds/Damage.wav"))
			if (Object.runningShieldTwo and Object.runningShieldOne and Projectile.DELETE_ME == nil) then
				Object.runningShieldTwo = false
				Object.playAnimation("ShieldAnimationOne")
				Object.justCollided = true
			elseif (Object.runningShieldOne and Object.justCollided == false and Projectile.DELETE_ME == nil) then
				Object.runningShieldOne = false
				Object.playAnimation("PlayerAnimation")
			else
				Object.setHealth(Object.getHealth() - 1)
				if (Object.getHealth() <= 0) then Object.DEAD = true end
			end
			
			Projectile.DELETE_ME = true
			--bject.Health = Object.Health - 1
		end
	end
	
	-- Up Movement
	if (Players.inputManager.keyPressed("up") or Players.inputManager.keyPressed("w")) then
		Object.movingUp = true
	else
		Object.movingUp = false
	end
	
	-- Down Movement
	if (Players.inputManager.keyPressed("down") or Players.inputManager.keyPressed("s")) then
		Object.movingDown = true
	else
		Object.movingDown = false
	end
	
	-- Right Movement
	if (Players.inputManager.keyPressed("d") or Players.inputManager.keyPressed("right")) then
		Object.movingRight = true
	else
		Object.movingRight = false
	end
	
	-- Idle Left Movement
	if (Players.inputManager.keyPressed("d") == false and Players.inputManager.keyPressed("right") == false) then
		Object.Idling = true
	else
		Object.Idling = false
	end
	
	-- Left Movement
	if (Players.inputManager.keyPressed("a") or Players.inputManager.keyPressed("left")) then
		Object.movingLeft = true
	else
		Object.movingLeft = false
	end
	
	-- Firing our gunz
	if ((Players.inputManager.keyPressed(" ") or Players.inputManager.keyPressed("k")) and (Object.FiringWeapon == nil or Object.FiringWeapon == false)) then
		if (Object.Fired == nil) then Object.Fired = 1 Object.Projectiles = { } end
		
		local ID = nil
		for i = 1, 3 do
			if (Object.Projectiles[i] == nil or Object.Projectiles[i].DELETE_ME == true) then
				ID = i
				break
			end
		end
		
		if (ID == nil) then return end
		local Projectile = Players.projectileManager.addProjectile(Players.projectileManager.ProjectileDataBase.DefaultBeam)
		Projectile.setPosition(vectorAdd(Object.getPosition(), vector2d(27, 10)))
		Projectile.setScale(vector2d(3,3))
		Projectile.playAnimation("BeamAnimation")
		Projectile.setDrawDepth(16)
		Object.FiringWeapon = true
		Object.Projectiles[ID] = Projectile
		Object.Fired = Object.Fired + 1
		love.audio.play( Players.soundManager.loadSound("media/sounds/Shot.wav"))
	end
	
	-- Firing our Missiles
	if ((Players.inputManager.keyPressed(" ") or Players.inputManager.keyPressed("j")) and Object.Missiles ~= 0 and Object.deltaTime >= 0.5) then
		local Projectile = Players.projectileManager.addProjectile(Players.projectileManager.ProjectileDataBase.Missile)
		Projectile.setPosition(vectorAdd(Object.getPosition(), vector2d(27, 10)))
		Projectile.setScale(vector2d(3,3))
		Projectile.playAnimation("Animation")
		Projectile.setDrawDepth(16)
		Object.FiringWeapon = true
		Object.Missiles = Object.Missiles - 1
		Object.deltaTime = 0
		love.audio.play( Players.soundManager.loadSound("media/sounds/Shot.wav"))
	end
	
	if (Players.inputManager.keyPressed("k") == false) then
		Object.FiringWeapon = false
	end
	
	-- Hacky way to do this .. but will be fixed in later versions
	
	if (Object.movingLeft and Object.Position.X > 0) then
		Object.Position.X = Object.Position.X - (105 * dt)
	end
	
	if (Object.movingRight and Object.Position.X < 618) then
		Object.Position.X = Object.Position.X + (100 * dt)
	end
	
	if (Object.movingUp and	Object.Position.Y > 320) then
		Object.Position.Y = Object.Position.Y - (100 * dt)
	end
	
	if (Object.movingDown and Object.Position.Y < 370) then
		Object.Position.Y = Object.Position.Y + (100 * dt)
	end
	
	if (Object.Idling and Object.Position.X > 0) then
		Object.Position.X = Object.Position.X - (70 * dt)
	end
end

function MainPlayer.draw(Object)

end

table.insert(Players, MainPlayer)
Players["MainPlayer"] = MainPlayer

-- TopDownPlayer
-- Exactly as it sounds
local TopDownPlayer =
{
	Animation = { },
	StartHealth = 2,
	MaxHealth = 5,
	Name = "TopDownPlayer",
}
local TopDownPlayerAnimation = 
{
	Speed = 0,
	Frame = { }
}
TopDownPlayerAnimation.FrameCount = 1
TopDownPlayerAnimation.Frame[1] = Players.imageManager.loadImage("media/textures/Upgraded_Bike_Over.png") 

TopDownPlayer.Animation["PlayerAnimation"] = TopDownPlayerAnimation

function TopDownPlayer.update(dt, Object)
	-- Up Movement
	if (Players.inputManager.keyPressed("up") or Players.inputManager.keyPressed("w")) then
		Object.movingUp = true
	else
		Object.movingUp = false
	end
	
	-- Down Movement
	if (Players.inputManager.keyPressed("down") or Players.inputManager.keyPressed("s")) then
		Object.movingDown = true
	else
		Object.movingDown = false
	end
	
	-- Right Movement
	if (Players.inputManager.keyPressed("d") or Players.inputManager.keyPressed("right")) then
		Object.movingRight = true
	else
		Object.movingRight = false
	end
	
	-- Idle Left Movement
	if (Players.inputManager.keyPressed("d") == false and Players.inputManager.keyPressed("right") == false) then
		Object.Idling = true
	else
		Object.Idling = false
	end
	
	-- Left Movement
	if (Players.inputManager.keyPressed("a") or Players.inputManager.keyPressed("left")) then
		Object.movingLeft = true
	else
		Object.movingLeft = false
	end
	
	if (Object.movingLeft) then
		Object.Position.X = Object.Position.X - (105 * dt)
		Object.Rotation = -3.12
	end
	
	if (Object.movingRight) then
		Object.Position.X = Object.Position.X + (100 * dt)
		Object.Rotation = 3.12
	end
	
	if (Object.movingUp) then
		Object.Position.Y = Object.Position.Y - (100 * dt)
		Object.Rotation = -1.6
	end
	
	if (Object.movingDown) then
		Object.Rotation = 1.6
		Object.Position.Y = Object.Position.Y + (100 * dt)
	end
end

table.insert(Players, TopDownPlayer)
Players["TopDownPlayer"] = TopDownPlayer

return Players
