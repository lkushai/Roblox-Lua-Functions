local function Atan3D(Position1, Position2)
	local Position = Position1 - Position2	
	
	local X, Y, Z = Position.X, Position.Y, Position.Z

	local Magntiude = Vector2.new(X, Z) .Magnitude

	local Yaw = math.atan2(X, Z) + 3.14159
	local Pitch = math.atan2(Y, Magntiude)


	return Vector2.new(Yaw, Pitch)
end