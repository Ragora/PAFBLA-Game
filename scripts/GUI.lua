-- GUI.lua
-- The GUI manager for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local GUI = { }
GUI.DataBase = { }
GUI.imageManager = require("scripts/Image.lua")
GUI.inputManager = require("scripts/Input.lua")
require("scripts/vector.lua")

function GUI.update(dt)
	for i = 1, table.getn(GUI.DataBase) do
		local GUIObject = GUI.DataBase[i]
		if (GUIObject ~= nil and GUIObject.DELETE_ME) then
			table.remove(GUI.DataBase, i)
			break
		end
		if (GUIObject ~= nil and GUIObject.update ~= nil) then
			GUIObject.update(dt, GUIObject)
		else
			-- Do something here if you wish.
		end
	end
end

function GUI.clear()
	GUI.DataBase = { }
end

function GUI.getCount()
	return table.getn(GUI.DataBase)
end

function GUI.getElement(id)
	if (GUI.getCount() < id) then
		print("LoveExtension error: Attempted to access GUI element out of range")
		return nil
	else
		return GUI.DataBase[id]
	end
	return nil
end

function GUI.addButton(Idle, Hover, down)
	local Button =
	{ 
		Position = vector2d(0,0), 
		Scale = vector2d(1,1),
		Color = vector4d(255,255,255,255),
		drawDepth = 16,
		Class = "Button",
		Visible = true,
		Animation = { },
		deltaTime = 0,
		Pressed = false,
	}
	
	function Button.getIsVisible()
		return Button.Visible
	end
	
	function Button.setPosition(Position)
		Button.Position = Position
	end
	
	function Button.update(dt, Object)	
		local MX = love.mouse.getX()
		local MY = love.mouse.getY()
		local image = Object.Animation["Up"].Frame[1]
		local Width = image:getWidth()
		local Height = image:getHeight()
	
		local endVector = vector2d( Object.Position.X + ( Width * Object.Scale.X), Object.Position.Y + ( Height * Object.Scale.Y))
		if (GUI.inputManager.mousePressed("l")) then
			for X = Object.Position.X, endVector.X do
				for Y = Object.Position.Y, endVector.Y do
					if (vectorWithin(Object.Position, endVector, vector2d(MX, MY)) and Object.DELETE_ME == nil) then
						Object.currentAnimation = "Down"
						Object.Function()
						Object.Pressed = true
						Object.waitingOnPlayer = true
						return
					else
						if (Object.waitingOnPlayer == false) then
							Object.currentAnimation = "Up"
							Object.Pressed = false
						end
						return
					end
				end
			end
		end
	end
	
	local AnimationUp = 
	{
		Speed = 0,
		Frame = { }
	}
	local AnimationDown = 
	{
		Speed = 0,
		Frame = { }
	}
	
	AnimationDown.FrameCount = 1
	AnimationDown.Frame[1] = GUI.imageManager.loadImage(down)
	AnimationUp.FrameCount = 1
	AnimationUp.Frame[1] = GUI.imageManager.loadImage(Idle)

	Button.Animation["Up"] = AnimationUp
	Button.Animation["Down"] = AnimationDown
	Button.currentAnimation = "Up"
	Button.currentFrame = 1
	table.insert(GUI.DataBase, Button)
	return Button
end

function GUI.addImage(File)
	local Image =
	{ 
		Position = vector2d(0,0), 
		Scale = vector2d(1,1),
		drawDepth = 16,
		Class = "Image",
		Animation = { },
		Visible = true,
		Color = vector4d(255,255,255,255)
	}
	local AnimationImage = 
	{
		Speed = 0,
		Frame = { }
	}
	
	function Image.getIsVisible()
		return Image.Visible
	end
	
	AnimationImage.FrameCount = 1
	AnimationImage.Frame[1] = GUI.imageManager.loadImage(File)

	Image.Animation["Animation"] = AnimationImage
	Image.currentAnimation = "Animation"
	Image.currentFrame = 1
	
	table.insert(GUI.DataBase, Image)
	return Button
end

return GUI
