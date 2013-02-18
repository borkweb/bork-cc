bork_cc.loadAPI('turtle-plus')

local args = {...}
local slots = {}
local craft_slot = 16
local work = true
local num = 0
local which = 'medium'
local from = 'left'
local to = 'right'
local recipe_type = 'normal'
local stash = false
local stash_dir = 'left'
local stash_this_one = false

if args[1] then
	recipe_type = args[1]
else
	print('Should I make a (m)inium or (n)ormal recipe?')
	recipe_type = read()
end

if 'm' == recipe_type then
	recipe_type = 'minium'
else
	recipe_type = 'normal'
end

if args[2] then
	which = args[2]
else
	term.clear()
	term.setCursorPos(1,1)
	print('What type of ' .. recipe_type .. ' recipe should I make?')
	print('-----------');
	if 'minium' == recipe_type then
		print('(s)mall  = minium + 2 slots')
		print('(m)edium = minium + 4 slots')
		print('(l)arge  = minium + 8 slots')
	else
		print('(s)quare  = 4 slots in a square')
		print('Derp. Use an auto crafting table for more complex stuff.')
	end
	print('-----------');
	print('');

	which = read()
end

if 'minium' == recipe_type then
	if 's' == which then
		which = 'small'
	elseif 'm' == which then
		which = 'medium'
	elseif 'l' == which then
		which = 'large'
	end
else
	which = 'square'
end

if args[3] then
	from = args[3]
else
	term.clear()
	term.setCursorPos(1,1)
	print('Got it. I will make a ' .. which .. ' ' .. recipe_type .. ' recipe.')
	print('');
	print('Where do I get stuff? From my:')
	print('  (l)eft, (r)ight,')
	print('  (b)ack, (f)ront')
	print('  (u)p, or (d)own')

	from = read()
end

if args[4] then
	to = args[4]
else
	term.clear()
	term.setCursorPos(1,1)
	print('Where do I put stuff? To my:');
	print('  (l)eft, (r)ight,')
	print('  (b)ack, (f)ront')
	print('  (u)p, or (d)own')
	print('');

	to = read()
end

if args[5] then
	stash = args[5]
else
	term.clear()
	term.setCursorPos(1,1)
	print('Would you like me to stash every other crafted item?')
	print('(y/n)?')
	print('')

	stash = read()
end

if 'y' == stash then
	stash = true

	if args[6] then
		stash_dir = args[6]
	else
		term.clear()
		term.setCursorPos(1,1)
		print('Where do I stash it?')
		print('  (l)eft, (r)ight,')
		print('  (b)ack, (f)ront')
		print('  (u)p, or (d)own')
		print('');

		stash_dir = read()
	end
else
	stash = false
end

term.clear()
term.setCursorPos(1,1)
print('I will make a ' .. which .. ' ' .. recipe_type .. ' recipe, grabbing items from "' .. from .. '" and storing them "' .. to .. '"' );
if stash then
	print( 'I will also stash every other item "' .. stash_dir .. '"' );
end

if 'minium' == recipe_type then
	if 's' == which or 'small' == which then
		slots = { 2, 3 }
	elseif 'm' == which or 'medium' == which then
		slots = { 2, 3, 5, 6 }
	elseif 'l' == which or 'large' == which then
		slots = { 2, 3, 5, 6, 7, 9, 10, 11 }
	end
else
	slots = { 1, 2, 5, 6 }
end

while work do
	turtle.turn( from )

	for key,slot in pairs( slots ) do
		num = turtle.load( slot, from )

		if 0 == num then
			num = turtle.distribute( slot, slots )
		end

		if 0 == num then
			work = false
		end
	end

	if work then
		turtle.select( craft_slot )
		turtle.craft()
		turtle.reset_turn( from )

		if stash and stash_this_one then
			turtle.turn( stash_dir )
			turtle.dump( craft_slot, stash_dir )
			turtle.reset_turn( stash_dir )
			stash_this_one = false
		else
			turtle.turn( to )
			turtle.dump( craft_slot, to )
			turtle.reset_turn( to )
			stash_this_one = true
		end
	else
		turtle.reset_turn( from )
		work = true
		sleep( 1 )
	end

	sleep( 0.1 )
end
