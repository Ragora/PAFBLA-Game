-- Item.lua
-- Item Manager functions for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Item = { }
Item.DataBase = { }
Item.ItemDataBase = require("scripts/DataBase/Items.lua")
require("scripts/Vector.lua")

function Item.clear()
	Item.DataBase = { }
end

function Item.update(dt)
	for i = 1, table.getn(Item.DataBase) do
		local itemObj = Item.DataBase[i]
		if (itemObj.DELETE_ME == true) then
			table.remove(Item.DataBase, i)
			break
		end
		if (itemObj.update ~= nil) then
			itemObj.update(dt, itemObj)
		else
			-- Do something here if you wish.
		end
	end
end

function Item.getCount()
	return table.getn(Item.DataBase)
end

function Item.getItem(id)
	if (id > Item.getCount()) then
		print("LoveExtension Error: Attempted to access item out of bounds. (" .. id .. ").")
		return nil
	else
		return Item.DataBase[id]
	end
	return nil
end

function Item.draw()
	for i = 1, table.getn(Item.DataBase) do
		local itemObj = Item.DataBase[i]
		if (itemObj.draw ~= nil) then
			itemObj.draw(itemObj)
		else
			-- Do something here if you wish.
		end
	end
end

function Item.addItem(Def)
	-- Make sure we got a valid definition
	if (Def == nil) then
		return nil	-- Nope. Return nil to indicate a failure
	end
	
	local newDef = { }
	
	newDef.Color = vector4d( 255, 255, 255, 255 )
	newDef.Position = vector2d( 0,0 )
	newDef.Scale = vector2d( 0,0 )
	newDef.Rotation = 0
	newDef.drawDepth = 5
	newDef.deltaTime = 0
	newDef.totalTime = 0
	
	newDef.Name = "NULL"
	if (Def.Name ~= nil) then newDef.Name = Def.Name end
	
	newDef.currentFrame = 1 		-- Current frame of our current animation
	newDef.currentAnimation = nil  	-- Notes that are not playing an animation (shows up as nothing)
	
	newDef.Animation = nil 			-- Indicates our object has no animations bound (bad)
	if (Def.Animation ~= nil) then
		newDef.Animation = Def.Animation
	else
		print("LoveExtension Warning: Attempted to create an Item without animation data.")
	end
	
	function newDef.getClassName()
		return "Item"
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
	
	function newDef.playAnimation(Animation)
		if (newDef.Animation[Animation] == nil) then
			print("LoveExtension Error: No such animation on object -- ('" .. Animation .. "').")
		else
			newDef.currentAnimation = Animation
		end
	end
	
	function newDef.setColor(nColor, G, B, A)
		if (nColor.X ~= nil and nColor.Y ~= nil and nColor.Z ~= nil and nColor.R ~= nil) then
			newDef.Color = nColor
		else
			newDef.Color.X = nColor
			newdef.Color.Y = G
			newDef.Color.Z = B
			newDef.Color.R = A
		end
	end
	
	function newDef.getColor()
		return newDef.Color
	end
	
	function newDef.getScale()
		return newDef.Scale
	end
	
	function newDef.setDrawDepth(Depth)
		newDef.drawDepth = Depth
	end
	
	function newDef.getDrawDepth()
		return newDef.drawDepth
	end
	
	function newDef.getIsVisible()
		return newDef.Visible
	end
	
	function newDef.setVisible(vis)
		newDef.Visible = vis
	end
	
	function newDef.delete()
		newDef.DELETE_ME = true
	end
	
	newDef.update = Def.update
	newDef.draw = Def.draw
	newDef.onPickup = Def.onPickup
	
	table.insert(Item.DataBase, newDef)
	
	return newDef
end

return Item
