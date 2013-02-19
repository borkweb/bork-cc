bork_cc.loadAPI('turtle-plus')

local args = {...}

local sapling_slot = 1
local log_slot = 2
local spacing = 4
local rows_wide = 0
local rows_long = 0
local distance_first = 0
local direction = 'r'
local sapling_suck_dir = 0
local log_drop_dir = 0
local log_count = 0

print('This script requires that a sapling be in slot 1 and a log of the type you are farming in slot 2')

if args[1] then
	rows_wide = args[1]
else
	print('How many rows wide is this tree farm?')
	rows_wide = read()
end

if args[2] then
	rows_long = args[2]
else
	print('How many rows long?')
	rows_long = read()
end

if args[3] then
	spacing = args[3]
else
	print('How many blocks between trees?')
	spacing = read()
end

if args[4] then
	direction = args[4]
else
	print('Which direction (relative to me) does the farm stretch to?')
	print('Choose: (r)ight or (l)eft?')
	direction = read()
end

if args[5] then
	distance = args[5]
else
	print('How many spaces between me and the first tree?')
	distance = read()
end

if args[6] then
	log_drop_dir = args[6]
else
	print('Where do I drop off logs? To my:')
	print('  (l)eft, (r)ight,')
	print('  (b)ack, (f)ront')
	print('  (u)p, or (d)own')
	log_drop_dir = read()
end

if args[7] then
	sapling_suck_dir = args[7]
else
	print('Where do I pick up saplings? From my:')
	print('  (l)eft, (r)ight,')
	print('  (b)ack, (f)ront')
	print('  (u)p, or (d)own')
	sapling_suck_dir = read()
end

function fell( sapling, log )
	local height = 1

	turtle.select( sapling )

	-- if there is a block and it isn't a sapling
	if turtle.detect() and not turtle.compare() then
		turtle.dig()
		turtle.move('forward', 1)

		turtle.select( log )
		while turtle.compareUp() do
			turtle.digUp()
			turtle.up()
			height = height + 1
		end

		if height > 1 then
			height = height - 1

			for i=1,height,1 do
				turtle.down()
			end

			-- plant a sapling
			turtle.placeDown()
			turtle.down()
		end
	else
		turtle.turn( 'right' )
		turtle.move( 'forward', 1 )
		turtle.turn( 'left' )
		turtle.move( 'forward', 2 )
		turtle.turn( 'left' )
		turtle.move( 'forward', 1 )
		turtle.turn( 'right' )
	end
end

while true do
	turtle.turn( sapling_suck_dir )
	turtle.load( sapling_slot, sapling_suck_dir )
	turtle.reset_turn( sapling_suck_dir )
	turtle.move( 'forward', distance )

	for width=1,rows_wide,1 do
		for length=1,rows_long,1 do
			turtle.fell( sapling_slot, log_slot )
			turtle.move( 'forward', spacing )
		end

		if width % 2 == 1 then
			turtle.turn( direction )
			turtle.move( 'forward', spacing )
			turtle.reset_turn( direction )
			turtle.move( 'forward', 1 )
			turtle.turn( direction )
			turtle.move( 'forward', 1 )
			turtle.turn( direction )
		else
			turtle.reset_turn( direction )
			turtle.move( 'forward', spacing )
			turtle.turn( direction )
			turtle.move( 'forward', 1 )
			turtle.reset_turn( direction )
			turtle.move( 'forward', 1 )
			turtle.reset_turn( direction )
		end
	end

	if width % 2 == 1 then
		-- if we are in here, we are close to home
		turtle.turn( direction )
		turtle.move('back', 1)
		turtle.turn( direction )
		turtle.move('forward', rows_long * ( spacing + 1 ) + 1 )
		turtle.turn( direction )
	else
		-- if we are in here, we are far from home
		turtle.move('forward', 1)
		turtle.turn( direction )
		turtle.move('forward', 1)
	end

	turtle.move( 'forward', rows_wide * ( spacing + 1 ) - 1 )
	turtle.turn( direction )
	turtle.move( 'forward', distance - 1 )
	turtle.turn( direction )
	turtle.turn( direction )

	turtle.turn( log_drop_dir )
	turtle.select( log_slot )
	log_count = turtle.getItemCount( log_slot )

	for i=3,16,1 do
		turtle.dump( i, log_drop_dir )
	end

	turtle.select( log_slot )
	turtle.transferTo( 3, log_count - 1 )
	turtle.dump( 3, log_drop_dir )
	turtle.reset_turn( log_drop_dir )
end
