-- GenericObjects.Lua
-- Generic Object definitions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

local GenericObjects = { }
GenericObjects.imageManager = require("scripts/Image.lua")

-- Road for our PAFBLA game
local MainRoad = 
{
	Animation = { },
}
local RoadAnimation = 
{
	Speed = 0,
	Frame = { }
}
RoadAnimation.FrameCount = 1
RoadAnimation.Frame[1] = GenericObjects.imageManager.loadImage("media/textures/Road_Railed.png") 
MainRoad.Animation["RoadAnimation"] = RoadAnimation

table.insert(GenericObjects, MainRoad)
GenericObjects["MainRoad"] = MainRoad

-- Road for our PAFBLA game
local ForegroundRail = 
{
	Animation = { },
}
local ForegroundRailAnimation = 
{
	Speed = 0,
	Frame = { }
}
ForegroundRailAnimation.FrameCount = 1
ForegroundRailAnimation.Frame[1] = GenericObjects.imageManager.loadImage("media/textures/Rail.png") 
ForegroundRail.Animation["RailAnimation"] = ForegroundRailAnimation

table.insert(GenericObjects, ForegroundRail)
GenericObjects["ForegroundRail"] = ForegroundRail

return GenericObjects
