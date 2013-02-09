bork_cc.loadAPI('turtle-plus')

local slots = {}
local create_slot = 16
local work = true
local num = 0
local which = 'medium'
local from = 'left'
local to = 'right'

print('Which recipe do you wish to make?')
print('small  = minium + 2 slots')
print('medium = minium + 4 slots')
print('large  = minium + 10 slots')
print('');
print('Choose: small, medium, or large')

which = read()

if 'small' == which then
	slots = { 2, 3 }
elseif 'medium' == which then
	slots = { 2, 3, 5, 6 }
elseif 'large' == which then
	slots = { 2, 3, 5, 6, 7, 9, 10, 11 }
end

print('Alright, I will make a ' .. which .. ' minium recipe.')
print('Where will I get resources?');
print('To my: (l)eft, (r)ight, (b)ack, (f)ront, (u)p, or (d)own')

from = read()

print('Where will I put crafted stuff?');
print('To my: (l)eft, (r)ight, (b)ack, (f)ront, (u)p, or (d)own')

to = read()

function reset_position( from )
	if 'l' == from then
		turtle.turnRight()
	elseif 'r' == from then
		turtle.turnLeft()
	elseif 'b' == from then
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

function turn( to )
	if 'l' == from then
		turtle.turnLeft()
	elseif 'r' == from then
		turtle.turnRight()
	elseif 'b' == from then
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

while work do
	turn( from )

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
		turtle.select( create_slot )
		turtle.craft()

		reset_position( from )
		turn( to )

		if 'u' == to then
			turtle.dropUp()
		elseif 'd' == to then
			turtle.dropDown()
		else
			turtle.drop()
		end

		reset_position( to )
	else
		reset_position( from )
		work = true
		sleep( 60 )
	end

	sleep( 0.1 )
end
