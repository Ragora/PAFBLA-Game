-- Input.lua
-- Input handler for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Input = { }
Input.keysPressed = { }
Input.mouseButtonPressed = { }

function Input.onKeyPressed(Key, unicode)
	Input.keysPressed[Key] = true
end

function Input.onKeyReleased(Key, unicode)
	Input.keysPressed[Key] = false
end

function Input.onMousePressed(x, y, button)
	Input.mouseButtonPressed[button] = true
end

function Input.onMouseReleased(x, y, button)
	Input.mouseButtonPressed[button] = false
end

function Input.keyPressed(Key)
	if (Input.keysPressed[Key] == nil) then Input.keysPressed[Key] = false end
	return Input.keysPressed[Key]
end

function Input.mousePressed(key)
	if (Input.mouseButtonPressed[key] == nil) then Input.mouseButtonPressed[key] = false end
	return Input.mouseButtonPressed[key]
end

return Input
