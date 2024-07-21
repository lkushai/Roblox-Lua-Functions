local function SortChunks(Chunks, PlayerChunk)
	table.sort(Chunks, function(a, b)
		local value1 = (PlayerChunk - a) .Magnitude
		local value2 = (PlayerChunk - b) .Magnitude

		return value1 < value2
	end)
end

local function GetPlayerChunk(HumanoidRootPart, ChunkSize)
	if not HumanoidRootPart then return end

	local RawPosition = HumanoidRootPart.Position

	local X = math.round(RawPosition.X / ChunkSize.X)
	local Y = math.round(RawPosition.Z / ChunkSize.Y)

	return Vector2.new(X, Y)
end

local function ChunksNearPlayer(PlayerChunk, RenderDistance, LoadedChunks)
	local ChunksNearPlayer = {}

	for Xaxis = -RenderDistance, RenderDistance do
		for Zaxis = -RenderDistance, RenderDistance do
			local CurrentChunk = Vector2.new(Xaxis, Zaxis)
			local RealChunkPos = CurrentChunk + PlayerChunk

			if LoadedChunks[RealChunkPos.X] == nil then
				LoadedChunks[RealChunkPos.X] = {}
			end

			if CurrentChunk.Magnitude < RenderDistance and not LoadedChunks[RealChunkPos.X][RealChunkPos.Y] then

				table.insert(ChunksNearPlayer, RealChunkPos)
			end
		end
	end

	return ChunksNearPlayer
end

local function UnloadChunk(Chunk)
	if not Chunk then return end

	if Chunk:IsA("Part") or Chunk:IsA("Model") then
		Chunk:Destroy()
	else
		for Number, Part in Chunk do
			Part:Destroy()
		end
	end
end

local function UnloadAllChunks(PlayerChunk, RenderDistance, LoadedChunks)
	local ChunksToUnload = {}

	for Xaxis, ZChunks in LoadedChunks do
		for Zaxis, ChunkData in ZChunks do
			local CurrentChunk = Vector2.new(Xaxis, Zaxis)

			if (CurrentChunk - PlayerChunk).Magnitude > RenderDistance then
				UnloadChunk(ChunkData)
				
				ZChunks[Zaxis] = nil
			end
		end
	end
end

local function LoadChunk(ChunkPosition, ChunkSize, Parent)
	local NewChunk = Instance.new("Part")
	NewChunk.Anchored = true
	NewChunk.TopSurface = Enum.SurfaceType.Smooth 
	NewChunk.Size = Vector3.new(ChunkSize.X, 5, ChunkSize.Y)
	NewChunk.Position = Vector3.new(ChunkPosition.X * ChunkSize.X, 0, ChunkPosition.Y * ChunkSize.Y)
	NewChunk.Parent = Parent

	return NewChunk
end

local function LoadAllChunks(ChunksToLoad, ChunksLoaded, ChunkSize, ChunkParent, ChunksPerFrame, HumanoidRootPart)
	local Counter = 0

	local StartChunk = GetPlayerChunk(HumanoidRootPart, ChunkSize)

	for Number, Chunk in ChunksToLoad do
		if StartChunk ~= GetPlayerChunk(HumanoidRootPart, ChunkSize) then return end

		local NewChunk = LoadChunk(Chunk, ChunkSize, ChunkParent)	

		if ChunksLoaded[Chunk.X] == nil then
			ChunksLoaded[Chunk.X] = {}
		end

		ChunksLoaded[Chunk.X][Chunk.Y] = NewChunk

		Counter += 1
		if Counter > ChunksPerFrame then
			Counter = 0
			task.wait()
		end
	end
end
