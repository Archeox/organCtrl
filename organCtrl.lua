-- Plays a midi file on the organ
local midi = require "midi"
local rednetWrk = require "rednetWrk"
local midiWrk = require "midiWrk"

-- the path to the file
local file = arg[1]

-- initialise the network, default to the back port
rednetWrk.init("Back")
