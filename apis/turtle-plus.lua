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

-- loads items into a slot "how" you want it to. Returns
-- the number of items loaded
function turtle.load( slot, how )
	local num = 0

	turtle.select( slot )

	num = turtle.getItemCount( slot )

	if 0 == num then
		if 'u' == how then
			how = 'suckUp'
		elseif 'd' == how then
			how = 'suckDown'
		elseif 's' ~= strsub( how, 1, 1 ) then
			how = 'suck'
		end

		turtle[how]()
		num = turtle.getItemCount( slot )
	end
	
	return num
end
