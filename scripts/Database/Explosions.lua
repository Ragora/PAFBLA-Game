-- Explosions.Lua
-- Explosion definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Explosions = { }
Explosions.imageManager = require("scripts/Image.lua")

-- Default Beam
local PlayerExplosion = 
{
	Animation = { },
	StartHealth = 1,
	MaxHealth = 1
}
local PlayerExplosionAnimation = 
{
	Speed = 50,
	Frame = { }
}
PlayerExplosionAnimation.FrameCount = 13
print("loadingExplosion")
PlayerExplosionAnimation.Frame[1] = Enemies.imageManager.loadImage("media/textures/PlayerExplode1.png") 
PlayerExplosionAnimation.Frame[2] = Enemies.imageManager.loadImage("media/textures/PlayerExplode2.png") 
PlayerExplosionAnimation.Frame[3] = Enemies.imageManager.loadImage("media/textures/PlayerExplode3.png") 
PlayerExplosionAnimation.Frame[4] = Enemies.imageManager.loadImage("media/textures/PlayerExplode4.png") 
PlayerExplosionAnimation.Frame[5] = Enemies.imageManager.loadImage("media/textures/PlayerExplode5.png") 
PlayerExplosionAnimation.Frame[6] = Enemies.imageManager.loadImage("media/textures/PlayerExplode6.png") 
PlayerExplosionAnimation.Frame[7] = Enemies.imageManager.loadImage("media/textures/PlayerExplode7.png") 
PlayerExplosionAnimation.Frame[8] = Enemies.imageManager.loadImage("media/textures/PlayerExplode8.png") 
PlayerExplosionAnimation.Frame[9] = Enemies.imageManager.loadImage("media/textures/PlayerExplode9.png") 
PlayerExplosionAnimation.Frame[10] = Enemies.imageManager.loadImage("media/textures/PlayerExplode10.png") 
PlayerExplosionAnimation.Frame[11] = Enemies.imageManager.loadImage("media/textures/PlayerExplode11.png") 
PlayerExplosionAnimation.Frame[12] = Enemies.imageManager.loadImage("media/textures/PlayerExplode12.png") 
PlayerExplosionAnimation.Frame[13] = Enemies.imageManager.loadImage("media/textures/PlayerExplode13.png") 
PlayerExplosion.Animation["Animate"] = PlayerExplosionAnimation

return Explosions
