local function ReverseClamp(Number,Min,Max)
	if Number < Max and Number > Min then
		return Max
	elseif Number > Min and Number < Max then
		return Min
	else
		return Number
	end
end

