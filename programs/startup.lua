-- Name: startup
-- Source: /bork-cc/programs/startup.lua
-- A simple startup script that adds bork-ccto the load path.

-- Shamelessly taken from the awesome repository by
-- @damien: https://github.com/damien/cc-scripts

-- These are additional paths that will be searched when you enter
-- a program name into your in-game computer
--
-- See also: http://en.wikipedia.org/wiki/Path_(computing)
local path = shell.path()
shell.setPath(path .. ":/bork-cc/programs")

-- While we did set the load path, we can't take advantage of
-- it while this file is being parsed, so we need to reference
-- the cc_scripts API using it's full file path.
os.loadAPI("/bork-cc/apis/bork-cc")

-- Print the version of bork-cc in use on startup
print("bork-cc v" .. bork_cc.versionString())
