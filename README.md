computercraft-scripts
=====================

A collection of my Minecraft (Tekkit) ComputerCraft scripts

## Installation

1. Open the lua interpreter on the in-game computer: `lua`
1. Enter the following snippet to download the installation:
	 `loadstring(http.get('https://raw.github.com/borkweb/bork-cc/master/bootstrap.lua').readAll())()`
1. Follow the instructions given by the installer and you should be good to go!

## Turtle-Plus API

### `turtle.move( dir, times )`

Moves the turtle in a direction.  If there is an obstruction in the way,
the turtle will wait until the obstruction is gone and then continue.

* `dir`: (string) direction to move.  Valid values are `forward`, `back`, `up`, or `down`
* `times`: (int) number of blocks to move

````lua
-- moves the turtle in vertical square motion
turtle.move( 'forward', 3 )
turtle.move( 'up', 3 )
turtle.move( 'back', 3 )
turtle.move( 'down', 3 )
````

### `turtle.distribute( target_slot, slots )`

Attempts to fill the `target_slot` with items in other `slots` if those
slots have more than one item.

* `target_slot`: (int) slot to distribute items to
* `slots`: (table) slots to attempt to get items from

````lua
-- Try to move items from slots 2, 3, 5, and 8
-- into slot 1 if slot 1 is empty

turtle.distribute( 1, { 2, 3, 5, 8 } )
````

### `turtle.dump( slot, dir )`

Dumps items from the `slot` in one of three directions.

* `slot`: (int) slot to drop items from
* `dir`: (string) direction to drop items. Valid values are `up` (or `u`), `down` (or `d), and anything else.  If `up` or `down` is not provided, forward is assumed.

````lua
-- drop items up from slot 1
turtle.drop( 1, 'up' )
turtle.drop( 1, 'u' )

-- drop items down from slot 1
turtle.drop( 1, 'down' )
turtle.drop( 1, 'd' )

-- drop items forward from slot 1
turtle.drop( 1, 'forward' )
turtle.drop( 1, 'bacon' )
````

### `turtle.load( slot, dir )`

Loads (sucks) items into the given `slot` from one of three directions.

* `slot`: (int) slot to drop items from
* `dir`: (string) direction to drop items. Valid values are `up` (or `u`), `down` (or `d), and anything else.  If `up` or `down` is not provided, forward is assumed.

````lua
-- load items from above into slot 1
turtle.load( 1, 'up' )
turtle.load( 1, 'u' )

-- load items from below into slot 1
turtle.load( 1, 'down' )
turtle.load( 1, 'd' )

-- load items from in front into slot 1
turtle.load( 1, 'forward' )
turtle.load( 1, 'bacon' )
````

### `turtle.turn( dir )`

Turns the turtle in a relative direction.

* `dir`: (string) direction to turn the turtle. Values that cause the turtle to turn: `left`, `right`, and `back`. (you can also use the first letter of each direction)

````lua
-- rotate the turtle to its left
turtle.turn( 'left' )

-- make the turtle turn 180 degrees
turtle.turn( 'back' )
````

### `turtle.reset_turn( dir )`

Un-turns the turtle in a relative direction. Basically, this allows you to reverse the effects of `turtle.turn( dir )`

* `dir`: (string) direction the turtle turned that you want to reset. Values that cause the turtle to turn: `left`, `right`, and `back`. (you can also use the first letter of each direction)

````lua
-- turn the turtle to the left
turtle.turn( 'left' )

-- turn the turtle back
turtle.reset_turn( 'left' )
````

## Credits
The installer, bootstrap, and some scripts were cloned from @damien at
https://github.com/damien/cc-scripts
