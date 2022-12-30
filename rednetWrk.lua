-- -----------------------------------
-- Plays a note on the minecraft organ
-- -----------------------------------
PROTOCOL = "organCtrl"

-- table that holds all values for the controller ids
OrganCtrlIds = {}

local function discoverCtrl(hostanme)
    -- search the network for the given hostname
    local id = rednet.lookup(PROTOCOL, hostanme);
    if id ~= nil then
        print("Found " .. hostanme .. "on id " .. id)
        OrganCtrlIds[hostanme] = id
    else
        print("Hostname " .. hostanme .. " wasn't found, dying")
        exit()
    end
end

-- Initialises the connection to the organ controllers
local function init(side)
    -- open the connection
    rednet.open(side)

    -- discoverCtrl("organ_0_0")
    -- discoverCtrl("organ_0_1")
    -- discoverCtrl("organ_0_2")
    discoverCtrl("organ_1_0")
    discoverCtrl("organ_1_1")
    discoverCtrl("organ_1_2")
    -- discoverCtrl("organ_2_0")
    -- discoverCtrl("organ_2_1")
    -- discoverCtrl("organ_2_2")
end

-- Transform a note to a side on a controller
local function noteToSide(note, base)
    local side = "bottom"
    if (note - base) == 0 then
        side = "left"
    elseif (note - base) == 1 then
        side = "back"
    elseif (note - base) == 2 then
        side = "right"
    elseif (note - base) == 3 then
        side = "top"
    end
    return side
end

-- Play a note, given in midi number
local function playNote(note, state)
    -- 54 .. 57 -- organ_1_0
    -- 58 .. 61 -- organ_1_1
    -- 62 .. 65 -- organ_1_2

    if note >= 66 then
        print("Unplayable note " .. playNote)
    elseif note >= 62 then
        -- send a signal to the controller
        local msg = {}
        msg["side"] = noteToSide(note, 62)
        msg["state"] = state
        rednet.send(OrganCtrlIds["organ_1_2"], msg, PROTOCOL)
    elseif note >= 58 then
        -- send a signal to the controller
        local msg = {}
        msg["side"] = noteToSide(note, 58)
        msg["state"] = state
        rednet.send(OrganCtrlIds["organ_1_1"], msg, PROTOCOL)
    elseif note >= 54 then
        -- send a signal to the controller
        local msg = {}
        msg["side"] = noteToSide(note, 58)
        msg["state"] = state
        rednet.send(OrganCtrlIds["organ_1_1"], msg, PROTOCOL)
    else
        print("Unplayable note " .. playNote)
    end
end