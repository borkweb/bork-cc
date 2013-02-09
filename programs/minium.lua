bork_cc.loadAPI('turtle-plus')

local slots = { 2, 3, 5, 6 }
local work = true
local num = 0

while work do
	turtle.turnLeft()

	for key,slot in pairs( slots ) do
		num = turtle.load( slot, 'suck' )

		if 0 == num then
			num = turtle.distribute( slot, slots )
		end

		if 0 == num then
			work = false
		end
	end

	if work then
		turtle.select(7)
		turtle.craft()
		turtle.turnRight()
		turtle.turnRight()
		turtle.drop()
		turtle.turnLeft()
	else
		turtle.turnRight()
		work = true
		sleep( 60 )
	end

	sleep( 0.1 )
end
