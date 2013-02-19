-- Name: bootstrap
-- Source: /bork-cc/bootstrap.lua
-- The bork-cc installer, shamelessly taken from the awesome repository by
-- @damien: https://github.com/damien/cc-scripts

-- First thing's first: save the installer to root of the current
-- computer. We want the user to be able to resume this process
-- if the install fails.
fs.makeDir("/bork-cc")
bootstrap = fs.open("/bork-cc/bootstrap", "w")
bootstrapConnection = http.get("https://raw.github.com/borkweb/bork-cc/master/bootstrap.lua")

assert(bootstrap, "Unable to save installer to disk! Please make sure your in-game computer has space available and try again!")
assert(bootstrapConnection, "Unable to download installer components! Is your internet working? See if you can access https://raw.github.com/damien/cc-scripts/master/bootstrap.lua")

bootstrap.write(bootstrapConnection.readAll())
bootstrapConnection.close()
bootstrap.close()

-- A manifest of all the APIs and programs the installer will include
-- by default.
apis = {
  "bork_cc",
  "installer",
	"turtle-plus"
}

programs = {
  "craft",
	"lumberjack",
  "startup"
}

-- Clear the screen and reset the cursor position
function nextScreen()
  term.clear()
  term.setCursorPos(1,1)
end

-- Splash screen
nextScreen()
print("bork-cc installer has been initialized!")
sleep(1)
nextScreen()

-- Show the user what's going to be installed
print("A total of " .. #apis .. " apis and " .. #programs .. " programs will be installed.")

-- Give the user the option to opt-out before we start
-- installing stuff
print()
print("Type 'yes' and hit return to continue,")
print("enter anything else to abort:")

if read() ~= "yes" then
  nextScreen()
  print("You have exited the bork-cc installer!")
  print()
  print("You can run the installer again from")
  print("/bork-cc/bootstrap")
  print()
  print("If you'd like to remove bork-cc,")
  print("simply delete /bork-cc")
  return
end

-- Install all the things!
--
-- This is pretty much just a selective copy from the latest
-- code on Github.
function install(path)
  local url = "https://raw.github.com/borkweb/bork-cc/master/" .. path .. ".lua"
  local installPath = "/bork-cc/" .. path
  local updated = fs.exists(installPath)

  print("Downloading " .. path .. " ...")
  local conn = http.get("https://raw.github.com/borkweb/bork-cc/master/" .. path .. ".lua")
  local file = fs.open(installPath, "w")

  assert(conn, "Unable to download " .. path .. " - aborting!")
  assert(file, "Unable to save " .. path .. " to " .. installPath .. " - aborting!")

  file.write(conn.readAll())

  file.close()
  conn.close()

  if updated then
    print("Updated " .. path)
  else
    print("Installed " .. path)
  end
end

function configureStartup()
  local hadStartup = fs.exists("/startup")

  -- Clobber any previous startup script
  if hadStartup then
    fs.delete("/startup")
  end

  fs.copy("/bork-cc/programs/startup", "/startup")
end

nextScreen()
print("Starting installation...")
print()
-- Install all our APIs
fs.makeDir("/bork-cc/apis")
for i = 1, #apis do
  install("apis/"..apis[i])
end

-- Install all of our programs
fs.makeDir("/bork-cc/programs")
for i = 1, #programs do
  install("programs/"..programs[i])
end

-- Install the startup script, this ensures that
-- all the newly installed scripts and apis are
-- immidiately available
configureStartup()

print()
print("Installation completed! Enjoy bork-cc!")
print()
print("Your computer will reboot in 3 seconds!")
sleep(3)
os.reboot()
