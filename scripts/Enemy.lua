-- Enemy.lua
-- Enemy manager for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Enemy = { }
Enemy.objectManager = require("scripts/objectManager.lua")
Enemy.DataBase = { }

function Enemy.clear()
	Enemy.DataBase = { }
end

function Enemy.update(dt)
	for i = 1, table.getn(Enemy.DataBase) do
		local enemyObject = Enemy.DataBase[i]
		if (enemyObject.DELETE_ME == true) then
			table.remove(Enemy.DataBase, i)
			break
		end
		
		if (enemyObject.update ~= nil) then
			enemyObject.update(dt, enemyObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Enemy.init()
	Enemy.enemyDataBase = require("scripts/DataBase/Enemies.lua")
end

function Enemy.draw()
	for i = 1, table.getn(Enemy.DataBase) do
		local enemyObject = Enemy.DataBase[i]
		if (enemyObject.draw ~= nil) then
			enemyObject.draw(enemyObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Enemy.getCount()
	return table.getn(Enemy.DataBase)
end

function Enemy.getEnemy(id)
	if (id > Enemy.getCount()) then
		print("LuaExtension Error: Attempted to access enemy out of bounds.")
		return nil
	else
		return Enemy.DataBase[id]
	end
	return nil
end

function Enemy.addEnemy(Def)
	-- Make sure we got a valid definition
	if (Def == nil) then
		return nil	-- Nope. Return nil to indicate a failure
	end
	
	local newDef = { }
	newDef.StartHealth = 100
	newDef.MaxHealth = 150
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
	newDef.Health = Def.StartHealth
	newDef.drawDepth = 10
	newDef.Name = Def.Name
	
	function newDef.getClassName()
		return "Enemy"
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
	
	function newDef.setDrawDepth(Depth)
		newDef.drawDepth = Depth
	end
	
	function newDef.delete()
		newDef.DELETE_ME = true
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
	
	table.insert(Enemy.DataBase, newDef)
	
	return newDef
end

return Enemy
