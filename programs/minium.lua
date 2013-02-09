bork_cc.loadAPI('turtle-plus')

local slots = {
	{
		id = 2,
		num = 0
	},
	{
		id = 3,
		num = 0
	},
	{
		id = 5,
		num = 0
	},
	{
		id = 6,
		num = 0
	}
}

local work = true

while work do
	turtle.turnLeft()

	for key,slot in pairs( slots ) do
		slot.num = turtle.load( slot.id, 'suck' )

		if 0 == slot.num then
			slot.num = turtle.distribute( slot.id, slots )
		end

		if 0 == slot.num then
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
