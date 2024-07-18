local ReplicatedStorage = game.ReplicatedStorage
local Materials = ReplicatedStorage.Materials

local function SpawnPart(Part,Parent,Size,Rotation,Position)
	local NewPart = Part:Clone()
	NewPart.Parent = Parent
	NewPart.Size = Size
	NewPart:PivotTo(CFrame.new(Position) * CFrame.fromOrientation(math.rad(Rotation.X),math.rad(Rotation.Y),math.rad(Rotation.Z)))

	return NewPart
end

local function ChanceNegativeRandom(Min,Max)
	local RandomNum = math.random(Min,Max)

	if math.random(0,1) == 0 then
		return -RandomNum
	else
		return RandomNum
	end
end

local function YawPitchToPos(Angle,Magnitude)
	local RadX, RadY = math.rad(Angle.X), math.rad(Angle.Y)

	local CosinedX, CosinedY = math.cos(RadX), math.cos(RadY)
	local SineX, SineY = math.sin(RadX), math.sin(RadY)

	local X = CosinedX * CosinedY
	local Y = SineX
	local Z = CosinedX * SineY

	local Position = Vector3.new(X,Y,Z) * Magnitude

	local Rotation = Vector3.new(0,-Angle.Y,Angle.X)

	return Position, Rotation
end

local function Tree(CurrentPosition,CurrentAngle,CurrentLength,CurrentThickness,Segments,RandomAngle,Model,IsEnd)

	for Segment = 1, Segments do
		CurrentAngle += Vector2.new(math.random(-RandomAngle,RandomAngle),math.random(-RandomAngle,RandomAngle))
		CurrentLength -= 2
		CurrentThickness -= 0.3

		if CurrentThickness < 1.5 then
			for Number = 1, 3 do
				local NewAngle = Vector2.new(ChanceNegativeRandom(35,45),ChanceNegativeRandom(35,45))

				Tree(CurrentPosition,CurrentAngle + NewAngle,CurrentLength,CurrentThickness,Segments - Segment,RandomAngle,Model,true)
			end
		end

		if Segment >= 2 then
			for Number = 1, math.random(1,2) do
				local NewAngle = Vector2.new(ChanceNegativeRandom(35,45),ChanceNegativeRandom(35,45))

				Tree(CurrentPosition,CurrentAngle + NewAngle,CurrentLength,CurrentThickness,Segments - Segment,RandomAngle,Model)
			end
		end

		local NewPosition, NewRotation = YawPitchToPos(CurrentAngle,CurrentLength)	

		SpawnPart(Materials.Wood,Model.Branches,Vector3.new(CurrentLength,CurrentThickness,CurrentThickness),NewRotation,CurrentPosition+(NewPosition/2))

		if IsEnd == true then
			SpawnPart(Materials.Leafs,Model.Leaves,Vector3.new(CurrentLength/3,CurrentThickness*3,CurrentThickness*3),NewRotation,CurrentPosition+NewPosition)
		end

		CurrentPosition += NewPosition
	end
end

local NewTree = Instance.new("Model")
NewTree.Name = "Tree"

local BranchFolder = Instance.new("Folder")
BranchFolder.Name, BranchFolder.Parent = "Branches", NewTree

local Leaves = Instance.new("Folder")
Leaves.Name, Leaves.Parent = "Leaves", NewTree

Tree(Vector3.new(0,-3,0),Vector2.new(90,0),20,3,10,25,NewTree)

NewTree.Parent = workspace.World
