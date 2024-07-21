-- this requires all the functions from chunk functions (just copy paste chunk functions then this in a local script in starter player scripts)

-- obtaining player variables fr

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character.HumanoidRootPart

LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
	Character = NewCharacter	
	HumanoidRootPart = Character.HumanoidRootPart
end)

-- world and chunk variables

local World = workspace.World -- folder you want all parts in chunks to go
local ChunkSize = Vector2.new(32, 32) -- chunk size in studs
local RenderDistance = 10 -- how far it renders is all directions
local ChunksPerFrame = 10 -- how many chunks are rendered per frame great for not lagging to death

local LoadedChunks = {} -- acting both as a list of chunks loaded while storing all the parts instances

while task.wait() do
	local PlayerChunk = GetPlayerChunk(HumanoidRootPart, ChunkSize)

	UnloadAllChunks(PlayerChunk, RenderDistance, LoadedChunks)

	local ChunksToLoad = ChunksNearPlayer(PlayerChunk, RenderDistance, LoadedChunks)

	SortChunks(ChunksToLoad, PlayerChunk)

	LoadAllChunks(ChunksToLoad, LoadedChunks, ChunkSize, World, ChunksPerFrame, HumanoidRootPart)
end
