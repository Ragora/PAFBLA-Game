-- Projectile.lua
-- Projectile Manager for Love Extension Library 
-- Copyright (c) 2011 Robert MacGregor

local Projectile = { }
Projectile.DataBase = { }		-- Instanced Player Objects
Projectile.ProjectileDataBase = require("scripts/DataBase/Projectiles.lua")
require("scripts/Vector.lua")

function Projectile.clear()
	Projectile.DataBase = { }
end

function Projectile.update(dt)
	for i = 1, table.getn(Projectile.DataBase) do
		local projectileObject = Projectile.DataBase[i]
		if (projectileObject.DELETE_ME) then
			table.remove(Projectile.DataBase, i)
			break
		end
		if (projectileObject.update ~= nil) then
			projectileObject.update(dt, projectileObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Projectile.draw()
	for i = 1, table.getn(Projectile.DataBase) do
		local projectileObject = Projectile.DataBase[i]
		if (projectileObject.draw ~= nil) then
			projectileObject.draw(projectileObject)
		else
			-- Do something here if you wish.
		end
	end
end

function Projectile.getCount()
	return table.getn(Projectile.DataBase)
end

function Projectile.getProjectile(id)
	return Projectile.DataBase[id]
end

function Projectile.addProjectile(Def)
	-- Make sure we got a valid definition
	if (Def == nil) then
		return nil	-- Nope. Return nil to indicate a failure
	end
	
	local newDef = { }
	newDef.currentFrame = 1 		-- Current frame of our current animation
	newDef.currentAnimation = nil  	-- Notes that are not playing an animation (shows up as nothing)
	
	newDef.Animation = nil 			-- Indicates our object has no animations bound (bad)
	if (Def.Animation ~= nil) then
		newDef.Animation = Def.Animation
	else
		print("LoveExtension Warning: Attempted to create a Player without animation data.")
	end

	if (Def.MaxHealth ~= nil) then
		newDef.MaxHealth = Def.MaxHealth
	end
	
	newDef.Color = vector4d( 255, 255, 255, 255 )
	newDef.Position = vector2d( 0,0 )
	newDef.Scale = vector2d( 0,0 )
	newDef.Rotation = 0
	newDef.Visible = true
	newDef.Health = StartHealth
	newDef.drawDepth = 16
	
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
	
	function newDef.delete()
		newDef.DELETE_ME = true
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
	
	table.insert(Projectile.DataBase, newDef)
	
	return newDef
end

return Projectile
