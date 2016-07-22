-- Timer.lua
-- Timing Library for LuaExtension Library
-- Copyright (c) 2011 Robert MacGregor

local Timer = { }
Timer.gameTime = 0
Timer.Scheduled = { }

function Timer.getGameTime()
	return Timer.gameTime
end

function Timer.update(dt)
	Timer.gameTime = Timer.gameTime + dt
	for i = 1, table.getn(Timer.Scheduled) do
		local Entry = Timer.Scheduled[i]
		if (Entry.Function == nil and Entry.Endtime == nil and Entry.StartTine == nil) then
			table.remove(Timer.Scheduled, i)
			break
		end
		if (Entry.Endtime <= Timer.gameTime) then
			Entry.Function(Entry.Argument1, Entry.Argument2, Entry.Argument3)
			table.remove(Timer.Scheduled, i)
			break
		end
	end
end

function Timer.Schedule(functionName, Arg1, Arg2, Arg3, timeOffset)	
	local Entry = 
	{
		Function = functionName,
		Argument1 = Arg1,
		Argument2 = Arg2,
		Argument3 = Arg3,
		Endtime = Timer.gameTime + (timeOffset / 1000),
		StartTime = Timer.gameTime
	}
	
	function Entry.cancel()
		Entry.Function = nil
		Entry.Endtime = nil
		Entry.StartTine = nil
	end
	
	table.insert(Timer.Scheduled, Entry)
	return Entry
end

return Timer
