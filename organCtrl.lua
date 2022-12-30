-- Plays a midi file on the organ
local midi = require "lib/midi"
local rednetWrk = require "lib/rednetWrk"
local midiWrk = require "lib/midiWrk"

-- the path to the file
local file = arg[1]

-- initialise the network, default to the back port
rednetWrk.init("Back")
