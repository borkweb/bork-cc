-- moves in the specified direction "times" times.  If movement
-- is obstructed, the turtle will pause then try again
function turtle.move( dir, times )
	for i=1,times,1 do
		while not turtle[dir]() do
			sleep(0.1)
		end
	end
end

-- attempts to place items from a collection of slots into
-- the target_slot if it is empty
function turtle.distribute( target_slot, slots )
	local num = 0

	num = turtle.getItemCount( target_slot )

	-- if the target_slot already has items, we don't need to distribute.
	if num > 0 then
		return num
	end

	-- loop over a collection of slots to locate stacks of > 1 to
	-- distribute the items to the target_slot
	for key,slot in pairs( slots ) do
		if not ( target_slot == slot ) then
			num = turtle.getItemCount( slot )

			if num > 1 then
				turtle.select( slot )
				turtle.transferTo( target_slot, 1 )
				return 1
			end
		end
	end

	return 0
end

-- dumps items up, down, or in front
-- @param to string where to dump
function turtle.dump( slot, to )
	turtle.select( slot )

	if 'u' == to or 'up' == from then
		turtle.dropUp()
	elseif 'd' == to or 'down' == from then
		turtle.dropDown()
	else
		turtle.drop()
	end
end

-- loads items into a slot "how" you want it to. Returns
-- the number of items loaded
function turtle.load( slot, from )
	local num = 0

	turtle.select( slot )

	num = turtle.getItemCount( slot )

	if 0 == num then
		if 'u' == from or 'up' == from then
			from = 'suckUp'
		elseif 'd' == from or 'down' == from then
			from = 'suckDown'
		else
			from = 'suck'
		end

		turtle[from]()
		num = turtle.getItemCount( slot )
	end
	
	return num
end

-- reset the turtle's orientation
-- @param from string
--   l turns right
--   r turns left
--   b turns right twice
--   f does nothing
--   u does nothing
--   d does nothing
function turtle.reset_turn( from )
	if 'l' == from or 'left' == from then
		turtle.turnRight()
	elseif 'r' == from or 'right' == from then
		turtle.turnLeft()
	elseif 'b' == from or 'back' == from then
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

-- changes the turtle's orientation
-- @param to string
--   r turns right
--   l turns left
--   b turns right twice
--   f does nothing
--   u does nothing
--   d does nothing
function turtle.turn( to )
	if 'l' == to or 'left' == to then
		turtle.turnLeft()
	elseif 'r' == to or 'right' == to then
		turtle.turnRight()
	elseif 'b' == to or 'back' == to then
		turtle.turnLeft()
		turtle.turnLeft()
	end
end
