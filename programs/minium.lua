local slots = {
	{
		position = 2,
		contains = 0
	},
	{
		position = 3,
		contains = 0
	},
	{
		position = 5,
		contains = 0
	},
	{
		position = 6,
		contains = 0
	}
}

local work = true

while work do
	turtle.turnLeft()

	for key,slot in pairs( slots ) do
		slot.contains = turtle.load( slot.position, 'suck' )

		if 0 == slot.contains then
			slot.contains = turtle.distribute( slot.position, slots )
		end

		if 0 == slot.contains then
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
