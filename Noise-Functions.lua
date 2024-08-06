function module.Noise2D(Position, Seed, NoiseValues)
	local FinalNoise = 0	

	for Octave = 1, NoiseValues.Octaves do
		local OctavedAmplitude = NoiseValues.Amplitude / Octave
		local OctavedFrequency = NoiseValues.Frequency * Octave

		FinalNoise += math.noise(Position.X / OctavedFrequency, Seed, Position.Y / OctavedFrequency) * OctavedAmplitude
	end

	return FinalNoise
end

local NoisePreset1 = {
	Octaves = 3,
	Amplitude = 20,
	Frequency = 50
}

-- Octaves change how detailed the noise is per say
-- Amplitude changes how far the features go vertically for example 20 would be hilly wil 80 would be like mountains
-- Frequency is what changes the features size on the X and Z axis
