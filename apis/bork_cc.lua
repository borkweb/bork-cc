-- API: cc_scripts
-- Source: /bork-cc/apis/bork-cc.lua
-- Description: An API that provides information about the local bork-cc installation,
--   as well as some utility functions for loading bork-cc APIs.

-- The bork-cc installer, shamelessly taken from the awesome repository by
-- @damien: https://github.com/damien/cc-scripts

-- This is where we set the current version of bork-cc in use.
-- Reference: http://semver.org/
local VERSION = {
  major = 0,
  minor = 0,
  patch = 1,
  identifier = ""
}

function version()
  return VERSION
end

function versionString()
  local string = VERSION.major .. "." .. VERSION.minor .. "." .. VERSION.patch
  if VERSION.identifier ~= "" then string = string .. "-" .. identifier end
  return string
end

function loadAPI(name)
  os.loadAPI("/bork-cc/apis/" .. name)
end
