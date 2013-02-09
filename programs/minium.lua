bork_cc.loadAPI('turtle-plus')

local slots = {}
local craft_slot = 16
local work = true
local num = 0
local which = 'medium'
local from = 'left'
local to = 'right'

print('Which recipe should I make?')
print('-----------');
print('(s)mall  = minium + 2 slots')
print('(m)edium = minium + 4 slots')
print('(l)arge  = minium + 10 slots')
print('-----------');
print('');
print('Choose: small, medium, or large')

which = read()

print('');
print('Got it. I will make a ' .. which .. ' minium recipe.')
print('');
print('Where do I get stuff? From my:')
print('  (l)eft, (r)ight,')
print('  (b)ack, (f)ront')
print('  (u)p, or (d)own')

from = read()

print('');
print('Where do I put stuff? To my:');
print('  (l)eft, (r)ight,')
print('  (b)ack, (f)ront')
print('  (u)p, or (d)own')
print('');

to = read()

if 's' == which or 'small' == which then
	slots = { 2, 3 }
elseif 'm' == which or 'medium' == which then
	slots = { 2, 3, 5, 6 }
elseif 'l' == which or 'large' == which then
	slots = { 2, 3, 5, 6, 7, 9, 10, 11 }
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
