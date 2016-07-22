-- ImageManager.lua
-- The image manager for LoveExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Image = { }
Image.DataBase = { }

function Image.loadImage(File)
	if (Image.getImageID(File) == nil) then
		local nImage = love.graphics.newImage(File) 
		Image.DataBase[File] = nImage
		table.insert(Image.DataBase, nImage)
		return nImage
	else
		return Image.getImage(Image.getImageID(File))
	end
	return nil
end

function Image.getImageID(File)
	if (Image.DataBase[File] == nil) then return nil end
	
	local nImage = Image.DataBase[File]
	for i = 0, table.getn(Image.DataBase) do
		if (Image.DataBase[i] == nImage) then
			return i
		end
	end
	return nil
end

function Image.getCount()
	return table.getn(Image.DataBase)
end

function Image.getImage(ID)
	return Image.DataBase[ID]
end

return Image
