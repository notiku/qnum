--!strict

local Constants = require(script.Parent.Constants)
local Types = require(script.Parent.Types)

type QNum = Types.QNum

local SuffixByIndex: { [number]: string } = {}
local IndexBySuffix: { [string]: number } = {}

local Format = {}

-- Generates a suffix without using the cache.
local function generateSuffix(index: number): string
	if index <= 0 then
		return ""
	end

	if index <= #Constants.SETS then
		return Constants.SETS[index]
	end

	local adjustedIndex = index - #Constants.SETS

	local firstIndex = adjustedIndex % 10
	local secondIndex = math.floor(adjustedIndex / 10) % 10
	local thirdIndex = math.floor(adjustedIndex / 100) % 10
	local multIndex = math.floor(adjustedIndex / 1000) + 1

	local first = Constants.FIRST_ONES[firstIndex + 1] or ""
	local second = Constants.SECOND_ONES[secondIndex + 1] or ""
	local third = Constants.THIRD_ONES[thirdIndex + 1] or ""
	local mult = Constants.MULT_ONES[multIndex] or ("e" .. tostring(adjustedIndex * 3))

	return first .. second .. third .. mult
end

--[[
	Generates a suffix for a suffix index.

	Index examples:
		1 -> k
		2 -> M
		3 -> B
		4 -> U
		14 -> UDe

	If the generated suffix exceeds the provided suffix arrays,
	it falls back to scientific-like suffix text.
]]
local function getGeneratedSuffix(index: number): string
	if index <= 0 then
		return ""
	end

	if index <= #Constants.SETS then
		return Constants.SETS[index]
	end

	index -= #Constants.SETS

	local firstIndex = index % 10
	local secondIndex = math.floor(index / 10) % 10
	local thirdIndex = math.floor(index / 100) % 10
	local multIndex = math.floor(index / 1000) + 1

	local first = Constants.FIRST_ONES[firstIndex + 1] or ""
	local second = Constants.SECOND_ONES[secondIndex + 1] or ""
	local third = Constants.THIRD_ONES[thirdIndex + 1] or ""
	local mult = Constants.MULT_ONES[multIndex] or ("e" .. tostring(index * 3))

	return first .. second .. third .. mult
end

--[[
	Formats a QNum using scientific notation.

	Example:
		1.25e6
]]
function Format.toScientific(value: QNum, decimals: number?): string
	decimals = decimals or 2

	return string.format(
		"%." .. tostring(decimals) .. "fe%d",
		value.mantissa,
		value.exponent
	)
end

--[[
	Formats a QNum using generated suffixes.

	Example:
		1.25e6 -> 1.25M
]]
function Format.withSuffix(value: QNum, decimals: number?): string
	decimals = decimals or 2

	if value.mantissa == 0 then
		return "0"
	end

	local suffixIndex = math.floor(value.exponent / 3)

	if suffixIndex <= 0 then
		local normalNumber = value.mantissa * (10 ^ value.exponent)
		return string.format("%." .. tostring(decimals) .. "f", normalNumber)
	end

	local suffix = Format.getSuffix(suffixIndex)
	local suffixExponent = suffixIndex * 3
	local displayNumber = value.mantissa * (10 ^ (value.exponent - suffixExponent))

	return string.format(
		"%." .. tostring(decimals) .. "f%s",
		displayNumber,
		suffix
	)
end

--[[
	Formats a QNum for normal display.

	Small values are shown as regular whole numbers.
	Large values use suffix formatting.
]]
function Format.format(value: QNum, decimals: number?): string
	if value.exponent < 3 then
		local normalNumber = value.mantissa * (10 ^ value.exponent)
		return tostring(math.floor(normalNumber))
	end

	return Format.withSuffix(value, decimals)
end

--[[
	Returns the suffix for a given suffix index and caches the result.

	Useful for testing or custom UI.
]]
function Format.getSuffix(index: number): string
	local cached = SuffixByIndex[index]

	if cached then
		return cached
	end

	local suffix = generateSuffix(index)

	SuffixByIndex[index] = suffix
	IndexBySuffix[suffix] = index

	return suffix
end

-- Returns a suffix index by suffix string and uses the cache.
-- Example:
-- "k" -> 1
-- "M" -> 2
-- "B" -> 3
function Format.getSuffixIndex(suffix: string): number?
	local cached = IndexBySuffix[suffix]

	if cached then
		return cached
	end

	for index = 1, 100000 do
		local generatedSuffix = Format.getSuffix(index)

		if generatedSuffix == suffix then
			return index
		end
	end

	return nil
end

return Format
