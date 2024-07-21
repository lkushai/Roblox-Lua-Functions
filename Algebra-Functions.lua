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
local function YawPitchToPos(Angle, Magnitude)
	local RadX, RadY = math.rad(Angle.X), math.rad(Angle.Y)

	local CosineX, CosineY = math.cos(RadX), math.cos(RadY)
	local SineX, SineY = math.sin(RadX), math.sin(RadY)

	local X = CosineY * CosineX
	local Y = SineY
	local Z = CosineY * SineX

	local Position = Vector3.new(X, Y, Z) * Magnitude

	return Position
end

--triangle spawner thing (i took alot of math refrence from egomoose although i did learn how it works and i didnt copy paste a thing)

local function DrawTriangle(a,b,c,Parent,T1,T2)
	local ab, bc, ca = a - b, b - c, c - a
	local dab, dbc, dca = ab:Dot(ab), bc:Dot(bc), ca:Dot(ca)

	if dbc > dca and dbc > dab then
		a, b, c = b, c, a
	elseif dca > dab and dca > dbc then
		a, b, c = c, a, b
	end
	
	ab, bc, ca = a - b, b - c, c - a

	local Right = ab:Cross(bc).Unit
	local Up = Right:Cross(ab).Unit
	local Back = ab.Unit

	local H = math.abs(bc:Dot(Up))

	if not T1 then
		T1 = SpawnTriangle(Parent,(b + c) / 2, Right, -Up, Back, Vector3.new(1,H,math.abs(ab:Dot(Back))))
		T2 = SpawnTriangle(Parent,(a + c) / 2, -Right, -Up, -Back, Vector3.new(1,H,math.abs(ca:Dot(Back))))
	end

	T1.CFrame = CFrame.fromMatrix((b + c) / 2, Right, -Up, Back)
	T1.Size = Vector3.new(1,H,math.abs(bc:Dot(Back)))

	T2.CFrame = CFrame.fromMatrix((a + c) / 2, -Right, -Up, -Back)
	T2.Size = Vector3.new(1,H,math.abs(ca:Dot(Back)))

	return T1, T2
end

