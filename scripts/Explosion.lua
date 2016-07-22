-- Input.lua
-- Input handler for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local Explosion = { }
Input.keysPressed = { }

function Input.onKeyPressed(Key, unicode)
	Input.keysPressed[Key] = true
end

function Input.onKeyReleased(Key, unicode)
	Input.keysPressed[Key] = false
end

function Input.keyPressed(Key)
	if (Input.keysPressed[Key] == nil) then Input.keysPressed[Key] = false end
	return Input.keysPressed[Key]
end

return Input
