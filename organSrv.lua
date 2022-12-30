-- --------------------------------------------------------
-- A simple server that manages redstones signal via rednet
-- --------------------------------------------------------
PROTOCOL = "organCtrl"

-- The octave we are listening for
local octave = arg[1]
-- The fraction of this octave to listen for
local fraction = arg[2]
-- the complete hostname
local hostname = "organ_" .. octave .. "_" .. fraction
-- Listen for messages
print("Listening for " .. PROTOCOL .. " as " .. hostname)
rednet.host(hostname, PROTOCOL)
local id, midi = rednet.receive(PROTOCOL)
redstone.setOutput(midi["side"], midi["state"])
