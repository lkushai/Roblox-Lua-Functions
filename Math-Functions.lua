local function ReverseClamp(Number,Min,Max)
	if Number < Max and Number > Min then
		return Max
	elseif Number > Min and Number < Max then
		return Min
	else
		return Number
	end
end

local function ChanceNegativeRandom(Min,Max)
	local RandomNum = math.random(Min,Max)

	if math.random(0,1) == 0 then
		return -RandomNum
	else
		return RandomNum
	end
end
