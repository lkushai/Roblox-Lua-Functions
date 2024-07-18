-- Converts a 2 position's into output akin to a turret per say
local function Atan3D(Position1, Position2)
	local Position = Position1 - Position2	
	
	local X, Y, Z = Position.X, Position.Y, Position.Z

	local Magntiude = Vector2.new(X, Z) .Magnitude

	local Yaw = math.atan2(X, Z) + 3.14159
	local Pitch = math.atan2(Y, Magntiude)


	return Vector2.new(Yaw, Pitch)
end

-- Converts yaw, pitch and magnitude into a vector.
local function YawPitchToPos(Angle,Magnitude)
	local RadX, RadY = math.rad(Angle.X), math.rad(Angle.Y)

	local CosineX, CosineY = math.cos(RadX), math.cos(RadY)
	local SineX, SineY = math.sin(RadX), math.sin(RadY)

	local X = CosineY * CosineX
	local Y = SineY
	local Z = CosineY * SineX

	local Position = Vector3.new(X,Y,Z) * Magnitude

	return Position
end
