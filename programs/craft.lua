bork_cc.loadAPI('turtle-plus')

local slots = {}
local craft_slot = 16
local work = true
local num = 0
local which = 'medium'
local from = 'left'
local to = 'right'
local recipe_type = 'normal'

print('Should I make a (m)inium or (n)ormal recipe?')

recipe_type = read()

if 'm' == recipe_type then
	recipe_type = 'minium'
else
	recipe_type = 'normal'
end

print('')
print('')
print('What type of ' .. recipe_type .. ' recipe should I make?')
print('-----------');
if 'minium' == recipe_type then
	print('(s)mall  = minium + 2 slots')
	print('(m)edium = minium + 4 slots')
	print('(l)arge  = minium + 10 slots')
else
	print('(s)quare  = 4 slots in a square')
	print('Derp. Use an auto crafting table for more complex stuff.')
end
print('-----------');
print('');

which = read()

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

print('')
print('')
print('Got it. I will make a ' .. which .. ' ' .. recipe_type .. ' recipe.')
print('');
print('Where do I get stuff? From my:')
print('  (l)eft, (r)ight,')
print('  (b)ack, (f)ront')
print('  (u)p, or (d)own')

from = read()

print('')
print('')
print('Where do I put stuff? To my:');
print('  (l)eft, (r)ight,')
print('  (b)ack, (f)ront')
print('  (u)p, or (d)own')
print('');

to = read()

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

while true do
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
		turtle.turn( to )
		turtle.dump( craft_slot, to )
		turtle.reset_turn( to )
	else
		turtle.reset_turn( from )
		work = true
		sleep( 60 )
	end

	sleep( 0.1 )
end
