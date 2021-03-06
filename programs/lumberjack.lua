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
local width = 0
local length = 0

print('Lumberjacker v 1.0')
print('------------------')
print('Requirements:')
print('  * Slot 1: saplings')
print('  * Slot 2: a log of tree being harvested')
print('------------------')
sleep( 1 )

function get_arg( id, message, ... )
	local value = 0

	if args[ id ] then
		value = args[ id ]
	end

	term.clear()
	term.setCursorPos( 1, 1 )

	print( message )
	
	for i=1,#arg do
		print( arg[ i ] )
	end

	value = read()

	print('')
	print('')

	return value
end

direction        = get_arg( 1, 'In which direction does the farm extend?', 'Choose: (r)ight or (l)eft' )
rows_wide        = tonumber( get_arg( 2, 'How many rows wide is this tree farm?' ) )
rows_long        = tonumber( get_arg( 3, 'How many rows long?' ) )
spacing          = tonumber( get_arg( 4, 'How many blocks between trees?' ) )
distance         = tonumber( get_arg( 5, 'How many spaces between me and the first tree?' ) )
sapling_suck_dir = get_arg( 6, 'I will pick up saplings from my:', '  (l)eft, (r)ight,', '  (b)ack, (f)ront,', '  (u)p, or (d)own' )
log_drop_dir     = get_arg( 7, 'I will dump logs to my:', '  (l)eft, (r)ight,', '  (b)ack, (f)ront,', '  (u)p, or (d)own' )

term.clear()
term.setCursorPos( 1, 1 )

print('Harvesting a ' .. rows_wide .. 'x' .. rows_long .. ' farm and dropping logs to my "' .. log_drop_dir .. '"')

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

	if rows_wide % 2 == 1 then
		-- if we are in here, we are far from home
		turtle.turn( direction )
		turtle.move( 'forward', 1 )
		turtle.turn( direction )
		turtle.move( 'forward', ( rows_long - 1 ) * ( spacing + 1 ) + 2 )
		turtle.turn( direction )
		turtle.move( 'forward', 1 )
	else
		-- if we are in here, we are close to home
		turtle.turn( direction )
	end

	turtle.move( 'forward', ( rows_wide - 1 ) * ( spacing + 1 ) )
	turtle.reset_turn( direction )
	turtle.move( 'forward', distance )
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

	sleep( 1 )
end
