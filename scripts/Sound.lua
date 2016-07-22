-- Sound.lua
-- The sound manager for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Sound = { }
Sound.DataBase = { }

function Sound.loadSound(File, Type)
	if (Sound.getSoundID(File) == nil) then
		local nSound = love.audio.newSource(File, Type) 
		Image.DataBase[File] = nSound
		table.insert(Sound.DataBase, nSound)
		return nSound
	else
		return Sound.getSound(Sound.getSoundID(File))
	end
	return nil
end

function Sound.getSoundID(File)
	if (Sound.DataBase[File] == nil) then return nil end
	
	local nSound = Sound.DataBase[File]
	for i = 0, table.getn(Sound.DataBase) do
		if (Sound.DataBase[i] == nSound) then
			return i
		end
	end
	return nil
end

function Sound.getCount()
	return table.getn(Sound.DataBase)
end

function Sound.getSound(ID)
	return Sound.DataBase[ID]
end

return Sound
