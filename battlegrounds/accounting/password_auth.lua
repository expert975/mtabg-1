--[[

					MTA:BG
				MTA Battlegrounds
	Developed By: L, CiBeR, neves768, 1BOY, expert975
			 © 2017 Null System Works
]]--

-- Get unpredictable values
local function entrophySource()
	return getRealTime().timestamp - getTickCount()
end

-- Warm up math.random
local function initRandom()
	math.randomseed(entrophySource())
	math.random() math.random() math.random()
end

initRandom()

-- Extract NaCl
local function generateSalt()
	return hash("sha1", math.random(entrophySource()))
end

local hash = hash
-- Hashe a password + salt multiple times
local function multipleHash(password, salt)
	local saltyPass = salt .. password
	local hashedString = hash("sha256", saltyPass) --hash for the fisrt time
	t = getTickCount()
	for i=1, 25000 do
		hashedString = hash("sha256", hashedString .. saltyPass )
	end
	outputDebugString("Hashing pasword took: " ..getTickCount() - t.. "ms")
	return salt.. "$" ..hashedString
end

-- Compare a password and a password hash
function checkPasswordHash(passwordHash, password)
	local salt = split(passwordHash, "$")[1] --extract salt
	outputDebugString("Salt: " ..salt)
	return multipleHash(password, salt) == passwordHash --pass match?
end

-- Prepare a new passowrd to be stored
function hashNewPassword(_, _, password)
	local newSalt = generateSalt() --new passowrd, new salt. ALWAYS!
	local newPasswordHash = multipleHash(password, newSalt)
	outputDebugString("Hash: " ..newPasswordHash)
	return newPasswordHash
end


local tmpHash
function createPass(_, _, password)
	tmpHash = hashNewPassword(_, _, password)
end
addCommandHandler("r", createPass)

function checkPass(_, _, password)
	outputDebugString("Correct: " ..tostring(checkPasswordHash(tmpHash, password)))
end
addCommandHandler("t", checkPass)