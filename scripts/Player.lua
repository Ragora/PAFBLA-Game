-- Player.lua
-- Player Manager for Love Extension Library 
-- Copyright (c) 2011 Robert MacGregor

local Player = { }
Player.DataBase = { }		-- Instanced Player Objects
Player.PlayerDataBase = require("scripts/DataBase/Players.lua")
require("scripts/Vector.lua")

function Player.clear()
	Player.DataBase = { }
end

function Player.getPlayer(id)
	if (id > Player.getCount()) then 
		return nil
	else
		return Player.DataBase[id]
	end
end
	
function Player.update(dt)
	for i = 1, table.getn(Player.DataBase) do
		local playerObject = Player.DataBase[i]
		if (playerObject.update ~= nil) then
			playerObject.update(dt, playerObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Player.draw()
	for i = 1, table.getn(Player.DataBase) do
		local playerObject = Player.DataBase[i]
		if (playerObject.draw ~= nil) then
			playerObject.draw(playerObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Player.getCount()
	return table.getn(Player.DataBase)
end

function Player.getPlayer(id)
	return Player.DataBase[id]
end

function Player.addPlayer(Def)
	-- Make sure we got a valid definition
	if (Def == nil) then
		return nil	-- Nope. Return nil to indicate a failure
	end
	
	local newDef = { }
	newDef.Collided = { }
	newDef.StartHealth = 100
	newDef.deltaTime = 0
	newDef.Name = Def.Name
	newDef.MaxHealth = 150
	newDef.runningShieldOne = false
	newDef.runningShieldTwo = false
	newDef.Money = 0
	newDef.Health = 100
	newDef.currentFrame = 1 		-- Current frame of our current animation
	newDef.currentAnimation = nil  	-- Notes that are not playing an animation (shows up as nothing)
	
	newDef.Animation = nil 			-- Indicates our object has no animations bound (bad)
	if (Def.Animation ~= nil) then
		newDef.Animation = Def.Animation
	else
		print("LoveExtension Warning: Attempted to create a Player without animation data.")
	end
	
	if (Def.StartHealth ~= nil) then
		newDef.StartHealth = Def.StartHealth
		newDef.Health = newDef.StartHealth
	end

	if (Def.MaxHealth ~= nil) then
		newDef.MaxHealth = Def.MaxHealth
	end
	
	newDef.Color = vector4d( 255, 255, 255, 255 )
	newDef.Position = vector2d( 0,0 )
	newDef.Scale = vector2d( 0,0 )
	newDef.Rotation = 0
	newDef.Visible = true
	newDef.drawDepth = 10
	
	function newDef.getClassName()
		return "Player"
	end
	
	function newDef.setPosition(nPosition, Y)
		if (nPosition.X ~= nil and nPosition.Y ~= nil) then
			newDef.Position.X = nPosition.X
			newDef.Position.Y = nPosition.Y
		else
			newDef.Position.X = nPosition
			newDef.Position.Y = Y
		end
	end
	
	function newDef.getPosition()
		return newDef.Position
	end
	
	function newDef.setRotation(Rot)
		newDef.Rotation = Rot
	end
	
	function newDef.getRotation()
		return newDef.Rotation
	end
	
	function newDef.setScale(nScale, Y)
		if (nScale.X ~= nil and nScale.Y ~= nil) then
			newDef.Scale.X = nScale.X
			newDef.Scale.Y = nScale.Y
		else
			newDef.Scale.X = nScale
			newdef.Scale.Y = Y
		end
	end
	
	function newDef.setScale(nScale, Y)
		if (nScale.X ~= nil and nScale.Y ~= nil) then
			newDef.Scale.X = nScale.X
			newDef.Scale.Y = nScale.Y
		else
			newDef.Scale.X = nScale
			newDef.Scale.Y = Y
		end
	end
	
	function newDef.getHealth()
		return newDef.Health
	end
	
	function newDef.setHealth(hp)
		newDef.Health = hp
	end
	
	function newDef.setDrawDepth(Depth)
		newDef.drawDepth = Depth
	end
	
	function newDef.getDrawDepth()
		return newDef.drawDepth
	end
	
	function newDef.getColor()
		return newDef.Color
	end
	
	function newDef.getScale()
		return newDef.Scale
	end
	
	function newDef.getIsVisible()
		return newDef.Visible
	end
	
	function newDef.setVisible(vis)
		newDef.Visible = vis
	end
	
	function newDef.playAnimation(Animation)
		if (newDef.Animation[Animation] == nil) then
			print("LoveExtension Error: No such animation on object -- ('" .. Animation .. "').")
		else
			newDef.currentAnimation = Animation
		end
	end
	
	newDef.update = Def.update
	newDef.draw = Def.draw
	
	table.insert(Player.DataBase, newDef)
	
	return newDef
end

return Player
