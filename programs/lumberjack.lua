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

function get_arg( id, message, ... )
	local value = 0

	if args[ id ] then
		value = args[ id ]
	end

	print( message )
	
	for i=1,#arg do
		print( arg[ i ] )
	end

	value = read()

	print('')
	print('')

	return value
end

rows_wide        = tonumber( get_arg( 1, 'How many rows wide is this tree farm?' ) )
rows_long        = tonumber( get_arg( 2, 'How many rows long?' ) )
spacing          = tonumber( get_arg( 3, 'How many blocks between trees?' ) )
direction        = get_arg( 4, 'In which direction does the farm extend?', 'Choose: (r)ight or (l)eft' )
distance         = tonumber( get_arg( 5, 'How many spaces between me and the first tree?' ) )
log_drop_dir     = get_arg( 6, 'Where do I drop off logs? To my:', '  (l)eft, (r)ight,', '  (b)ack, (f)ront,', '  (u)p, or (d)own' )
sapling_suck_dir = get_arg( 7, 'Where do I pick up saplings? From my:', '  (l)eft, (r)ight,', '  (b)ack, (f)ront,', '  (u)p, or (d)own' )

function fell( sapling, log )
	local height = 1

	-- if there is a block and it isn't a sapling
	if turtle.detect() then
		turtle.select( log )

		if turtle.compare() then
			turtle.dig()
			turtle.move('forward', 1)

			while turtle.compareUp() do
				turtle.digUp()
				turtle.up()
				height = height + 1
			end

			for i=1,height,1 do
				turtle.down()
			end
			
			turtle.move( 'forward', 1 )
			turtle.turn( 'back' )
			turtle.select( sapling )
			turtle.place()
			turtle.reset_turn( 'back' )
		else
			turtle.turn( 'right' )
			turtle.move( 'forward', 1 )
			turtle.turn( 'left' )
			turtle.move( 'forward', 2 )
			turtle.turn( 'left' )
			turtle.move( 'forward', 1 )
			turtle.turn( 'right' )
		end
	else
		turtle.move( 'forward', 2 )
	end
end

while true do
	turtle.turn( sapling_suck_dir )
	turtle.load( sapling_slot, sapling_suck_dir )
	turtle.reset_turn( sapling_suck_dir )
	turtle.move( 'forward', distance )

	for width=1,rows_wide do
		for length=1,rows_long do
			fell( sapling_slot, log_slot )
			
			if length ~= rows_long then
				turtle.move( 'forward', spacing - 1 )
			end
		end

		if width ~= rows_wide then
			if width % 2 == 1 then
				turtle.turn( direction )
				turtle.move( 'forward', spacing + 1 )
				turtle.turn( direction )
			else
				turtle.reset_turn( direction )
				turtle.move( 'forward', spacing + 1 )
				turtle.reset_turn( direction )
			end
		end
	end

	if width % 2 == 0 then
		-- if we are in here, we are far from home
		turtle.reset_turn( direction )
		turtle.move( 'forward', 1 )
		turtle.reset_turn( direction )
		turtle.move('forward', rows_long * ( spacing + 1 ) + 2 )
		turtle.turn( direction )
	else
		-- if we are in here, we are close to home
		turtle.turn( direction )
		turtle.move( 'forward', 1 )
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
