-- Vector.lua
-- Vector functions for LoveExtension library
-- Copyright (c) 2011 Robert MacGregor

function vector2d(X, Y)
	local Vector = { X, Y }
	Vector.X = X
	Vector.Y = Y
	
	function Vector.dotProduct()
		return Vector.X * Vector.Y
	end

	return Vector
end

function vector3d(X, Y, Z)
	local Vector = { X, Y, Z }
	Vector.X = X
	Vector.Y = Y
	Vector.Z = Z
	
	function Vector.dotProduct()
		return Vector.X * Vector.Y * Vector.Z
	end
	
	return Vector
end


function vector4d(X, Y, Z, R)
	local Vector = { X, Y, Z, R }
	Vector.X = X
	Vector.Y = Y
	Vector.Z = Z
	Vector.R = R
	
	function Vector.dotProduct()
		return Vector.X * Vector.Y * Vector.Z * Vector.R
	end
	
	return Vector
end

-- Arithmetic Functions
function vectorAdd(Vec1, Vec2)
	local X = Vec1.X + Vec2.X
	local Y = Vec1.Y + Vec2.Y
	local Z = nil
	local R = nil
	if (Vec1.Z ~= nil and Vec2.Z ~= nil) then
		Z = Vec1.Z + Vec2.Z
	end
	if (Vec1.R ~= nil and Vec2.R ~= nil) then
		R = Vec1.R + Vec2.R
	end
	
	local Vector = nil
	if (Z ~= nil and R ~= nil) then
		Vector = { X, Y, Z, R }
		Vector.Z = Z
		Vector.R = R
	elseif (Z ~= nil and R == nil) then
		Vector = { X, Y, Z }
		Vector.Z = Z
	else
		Vector = { X, Y }
	end
	
	Vector.X = X
	Vector.Y = Y
	
	return Vector
end

function vectorSubtract(Vec1, Vec2)
	local X = Vec1.X - Vec2.X
	local Y = Vec1.Y - Vec2.Y
	local Z = nil
	local R = nil
	if (Vec1.Z ~= nil and Vec2.Z ~= nil) then
		Z = Vec1.Z - Vec2.Z
	end
	if (Vec1.R ~= nil and Vec2.R ~= nil) then
		R = Vec1.R - Vec2.R
	end
	
	local Vector = nil
	if (Z ~= nil and R ~= nil) then
		Vector = { X, Y, Z, R }
		Vector.Z = Z
		Vector.R = R
	elseif (Z ~= nil and R == nil) then
		Vector = { X, Y, Z }
		Vector.Z = Z
	else
		Vector = { X, Y }
	end
	
	Vector.X = X
	Vector.Y = Y
	
	return Vector
end

function vectorMultiply(Vec1, Vec2)
	local X = Vec1.X * Vec2.X
	local Y = Vec1.Y * Vec2.Y
	local Z = nil
	local R = nil
	if (Vec1.Z ~= nil and Vec2.Z ~= nil) then
		Z = Vec1.Z * Vec2.Z
	end
	if (Vec1.R ~= nil and Vec2.R ~= nil) then
		R = Vec1.R * Vec2.R
	end
	
	local Vector = nil
	if (Z ~= nil and R ~= nil) then
		Vector = { X, Y, Z, R }
		Vector.Z = Z
		Vector.R = R
	elseif (Z ~= nil and R == nil) then
		Vector = { X, Y, Z }
		Vector.Z = Z
	else
		Vector = { X, Y }
	end
	
	Vector.X = X
	Vector.Y = Y
	
	return Vector
end

function vectorDivide(Vec1, Vec2)
	local X = Vec1.X / Vec2.X
	local Y = Vec1.Y / Vec2.Y
	local Z = nil
	local R = nil
	if (Vec1.Z ~= nil and Vec2.Z ~= nil) then
		Z = Vec1.Z / Vec2.Z
	end
	if (Vec1.R ~= nil and Vec2.R ~= nil) then
		R = Vec1.R / Vec2.R
	end
	
	local Vector = nil
	if (Z ~= nil and R ~= nil) then
		Vector = { X, Y, Z, R }
		Vector.Z = Z
		Vector.R = R
	elseif (Z ~= nil and R == nil) then
		Vector = { X, Y, Z }
		Vector.Z = Z
	else
		Vector = { X, Y }
	end
	
	Vector.X = X
	Vector.Y = Y
	
	return Vector
end

function vectorWithin(Vec1, Vec2, Vec3)
	local Vector1 = { }
	Vector1.X = Vec1.X
	Vector1.Y = Vec1.Y
	if (Vec1.Z ~= nil) then
		Vector1.Z = Vec1.Z
	else
		Vector1.Z = 0
	end
	if (Vec1.R ~= nil) then
		Vector1.R = Vec1.R
	else
		Vector1.R = 0
	end
	
	local Vector2 = { }
	Vector2.X = Vec2.X
	Vector2.Y = Vec2.Y
	if (Vec2.Z ~= nil) then
		Vector2.Z = Vec2.Z
	else
		Vector2.Z = 0
	end
	if (Vec2.R ~= nil) then
		Vector2.R = Vec2.R
	else
		Vector2.R = 0
	end
	
	local Vector3 = { }
	Vector3.X = Vec3.X
	Vector3.Y = Vec3.Y
	if (Vec3.Z ~= nil) then
		Vector3.Z = Vec3.Z
	else
		Vector3.Z = 0
	end
	if (Vec3.R ~= nil) then
		Vector3.R = Vec3.R
	else
		Vector3.R = 0
	end
	
	if (Vector3.X >= Vector1.X and Vector3.X <= Vector2.X and Vector3.Y >= Vector1.Y and Vector3.Y <= Vector2.Y and Vector3.Z >= Vector1.Z and Vector3.Z <= Vector2.Z and Vector3.R >= Vector1.R and Vector3.R <= Vector2.R) then
		return true
	else
		return false
	end
	
	return false
end
