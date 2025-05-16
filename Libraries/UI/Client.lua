local cloneref = cloneref and cloneref or function(...) return ... end 
local gethui = (gethui and gethui()) or cloneref(game:GetService("CoreGui")) 

local players = cloneref(game:GetService("Players"))
local localPlayer = players.LocalPlayer 

local findFirstChild = workspace.FindFirstChild

local library = {
    {},
    {
        fps = 60,
        ping = 100,
        mem = 200
    },
    {
        name = localPlayer.DisplayName,
        vel = 0,
        pos = {0, 0, 0},
        title = "mont3r.lua",
        build = "user",
        version = "1.0.0"
    },
    {
        name = "",
        health = 100,
        vel = 0,
        distance = 0,
        pos = {0, 0, 0},
        vis = false,
        friendly = false 
    },
    {
        font = "",
        image = "",
        gradient = { },
        accent = Color3.fromRGB(255, 100, 100),
        text = Color3.fromRGB(255, 255, 255)
    }
}

function library:create(instance, properties)
    local obj = Instance.new(instance)

    for i, v in pairs(properties) do
        obj[string.upper(string.sub(i, 1, 1)) .. string.sub(i, 2)] = v
    end

    self[1][#self[1] + 1] = obj

    return obj
end

function library:unload()
    for i, v in ipairs(self[1]) do 
        v:Destroy()
    end 
end 

function library:isAlive(player)
    local char = player.Character 
    if char then 
        local root, humanoid = findFirstChild(char, "HumanoidRootPart"), findFirstChild(char, "Humanoid")

        if root and humanoid then 
            if humanoid.Health > 0 then 
                return player, char, root, humanoid 
            end 
        end 
    end 

    return nil, nil, nil, nil 
end 

function library:isFriendly(player)
    return (player.Team == localPlayer.Team)
end 

function library:randomString(name)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, 10 do
        local randIndex = math.random(1, #charset)
        result = result .. string.sub(charset, randIndex, randIndex)
    end
    return name .. result
end

local screenGui = library:create("ScreenGui", {
    name = library:randomString("screenGui"),
    parent = gethui()
})

local title = library:create("Text", {
    name = library:randomString("title"),
    text = library[3].title .. " | build: " .. library[3].build  .. " | v" .. library[3].version,
    parent = screenGui 
})

local content = library:create("Text", {
    name = library:randomString("content"),
    text = [[
        local player
        > username: 
        > velocity:
        > position:
    ]],
    parent = screenGui 
})

local closestPlayerContent = library:create("Text", {
    name = library:randomString("closestPlayerContent"),
    text = [[
        closest player
        > username:
        > velocity:
        > position:
        > distance:
    ]],
    parent = screenGui
})

local titleGradient = library:create("UIGradient", {
    parent = title,
    name = library:randomString("titleGradient"),
    color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, library[5].text),
        ColorSequenceKeypoint.new(0.01, library[5].accent),
        ColorSequenceKeypoint.new(1, library[5].text)
    }
})
