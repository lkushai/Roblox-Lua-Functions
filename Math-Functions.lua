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

function module.BezierCurve(Point1, Point2, Point3, Point4, Time)
	local Line1 = Point1 + (Point2 - Point1) * Time
	local Line2 = Point2 + (Point3 - Point2) * Time
	local Line3 = Point3 + (Point4 - Point3) * Time

	local Curve1 = Line1 + (Line2 - Line1) * Time
	local Curve2 = Line2 + (Line3 - Line2) * Time

	return Curve1 + (Curve2 - Curve1) * Time
end
