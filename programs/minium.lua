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

function load_items( slot )
	local contains = 0

	turtle.select( slot )

	contains = turtle.getItemCount( slot )

	if 0 == contains then
		turtle.suck()
		contains =  turtle.getItemCount( slot )
	end

	return contains
end

function distribute_items( target )
	local num = 0

	for key,slot in pairs( slots ) do
		if not ( target == slot.position ) then
			num = turtle.getItemCount( slot.position )

			if num > 1 then
				turtle.select( slot.position )
				turtle.transferTo( target, 1 )
				return 1
			end
		end
	end

	return 0
end

while work do
	turtle.turnLeft()

	for key,slot in pairs( slots ) do
		slot.contains = load_items( slot.position )

		if 0 == slot.contains then
			slot.contains = distribute_items( slot.position )
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
