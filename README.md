# Love 2D modules

These modules are small applications to test different [Love 2D][credits-love2d] features. This repository's goal is to provide a [Lua][credits-lua] syntax guide, and to try out functions and custom _Lua_ modules to be shared across all 2D game projects, using the _Love 2D_ framework.

## <a name='ToC'>Table of Contents</a>

  - ***Module 0:*** [Hello World](#hello)
  - ***Module 1:*** [Low-res](#low-res)
  - ***Module 2:*** [Font](#font)
  - ***Module 3:*** [Grid](#grid)
  - ***Module 4:*** [Corners](#corners)
  - ***Module 5:*** [Circle](#circle)
  - ***Module 6:*** [Current time](#current-time)
  - ***Module 7:*** [Font sizes](#font-sizes)
  - ***Module 8:*** [Square object](#square-object)
  - ***Module 9:*** [Grid object](#grid-object)
  - ***Module 10:*** [Circle object](#circle-object)
  - ***Module 11:*** [Random circle](#random-circle)
  - ***Module 12:*** [Basic timer](#basic-timer)
  - ***Module 13:*** [Square move](#square-move)
  - ***Module 14:*** [Timer object](#timer-object)
  - ***Module 15:*** [Color Mapper](#color-mapper)
  - ***Module 16:*** [Square chain](#square-chain)
  - ***Module 17:*** [Chain object](#chain-object)
  - ***Module 18:*** [Quit game](#quit-game)
  - ***Module 19:*** [Title](#title)
  - ***Module 20:*** [FPS](#fps)
  - ***Module 21:*** [Chain move](#chain-move)
  - ***Module 22:*** [Chain grow](#chain-grow)
  - ***Module 23:*** [Chain velocity](#chain-velocity)

## ***Module 0:*** <a name='hello'>[Hello World][module-0]</a>

Prints "Hello World" at the center of the screen, with the default Font.

**[[⬆]](#ToC)**

## ***Module 1:*** <a name='low-res'>[Low-res][module-1]</a>

Prints the same text as the first module, but with a low resolution, crisp, pixelated aesthetic. It uses Ulydev's [push][library-push] library to do so.

**[[⬆]](#ToC)**

## ***Module 2:*** <a name='font'>[Font][module-2]</a>

Imports an old-fashioned font, and applies it to the welcome message from the previous module.

It uses Ulydev's [push][library-push] library.

```lua
-- main.lua
-- .........

  -- Bootstrap the `push` library
  push = require 'push'

  -- ...

  function love.load()

    -- ...
   
    -- Define "retro-looking" font object to use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)
   
    -- Set Love 2D's active font to the smallFont object
    love.graphics.setFont(smallFont)
   
    -- ...
   
  end
   
  function love.draw()
   
    -- Begin rendering at virtual resolution
    push:start()
   
    -- Use `love.graphics.printf` to display the text at the center of the screen
   
    -- End rendering at virtual resolution
    push:finish()
   
  end
```

**[[⬆]](#ToC)**

## ***Module 3:*** <a name='grid'>[Grid][module-3]</a>

Defines a 16 by 16 pixel square, and uses it to draw as many copies as needed for them to cover the entire screen.

Used for debugging.

**[[⬆]](#ToC)**

## ***Module 4:*** <a name='corners'>[Corners][module-4]</a>

Prints text at each of the corners of the screen, with a low-res aesthetic, and a "retro-looking" Font.

Defines an offset for both 'x' and 'y' positions.

Draws the 4 texts by applying the offsets to the rectangles used for each text alignment.

**[[⬆]](#ToC)**

## ***Module 5:*** <a name='circle'>[Circle][module-5]</a>

Displays a circle inside one of the 16x16 pixel grid cells.

Defines values for both the circle's center position and the circle's pivot. It draws a small rectangle to indicate the aforementioned pivot.

**[[⬆]](#ToC)**

## ***Module 6:*** <a name='current-time'>[Current time][module-6]</a>

Prints the current time in 12 hour format, at the center of the screen.

**[[⬆]](#ToC)**

## ***Module 7:*** <a name='font-sizes'>[Font sizes][module-7]</a>

Prints a couple of font sizes inside a margin.

Draws a small text at the top center of the screen, and a large text at the botton center of the screen.

**[[⬆]](#ToC)**

## ***Module 8:*** <a name='square-object'>[Square object][module-8]</a>

Displays a filled square as a class object.

Defines values for both the 'x' and 'y' position, and the width of the square.

Uses vrld's [class][library-class] library to represent the square object as code, and place all of its properties and functions in a separate file.

Draws the aforementioned square inside one of the grid cells.

**[[⬆]](#ToC)**

## ***Module 9:*** <a name='grid-object'>[Grid object][module-9]</a>

Displays a 16x16 pixel grid as a class object.
                    
Defines values for the width, the height, and the unit of measurement for each cell of the grid.

Represents the grid object as code, and places all of its properties and functions in a separate file. It uses vrld's [class][library-class] library to do so.

Draws the aforementioned grid to cover the entire screen.

Used for debugging.

**[[⬆]](#ToC)**

## ***Module 10:*** <a name='circle-object'>[Circle object][module-10]</a>

Displays a circle as a class object, using vrld's [class][library-class] library.

Defines values for both the circle's center position and the circle's center indicator.

It draws both the shape and the aforementioned indicator inside one of the grid cells.

**[[⬆]](#ToC)**

## ***Module 11:*** <a name='random-circle'>[Random circle][module-11]</a>

Displays a circle, represented as a class object, inside of a random grid cell. It uses vrld's [class][library-class] library to do so, just like in the previous module.

Updates the Circle class to that it receives a grid and, if the x and y positions of the center of the circle are not specified, it places the shape inside a grid cell that varies every time on startup.

**[[⬆]](#ToC)**

## ***Module 12:*** <a name='basic-timer'>[Basic timer][module-12]</a>

Prints a timer that affects the position of a circle on the screen.

Sets a second timer to increase by delta time, and switch the position of the circle, between 2 grid cells, every 2 seconds.

**[[⬆]](#ToC)**

## ***Module 13:*** <a name='square-move'>[Square move][module-13]</a>

Gets the user's input to move a filled square, represented as a class object, in 4 directions. It uses vrld's [class][library-class] library to represent the square object as code.

Takes the input to set the direction of the movement.

Moves the square in one of four directions to adjacent grid cells, depending on the pressed key, one grid cell at a time.

Updates the square position every second.

**[[⬆]](#ToC)**

## ***Module 14:*** <a name='timer-object'>[Timer object][module-14]</a>

Set 2 timers, represented as class objects. It uses vrld's [class][library-class] library to do it.

Defines a timer class that affects an output on the screen, at certain intervals, by executing a given callback action.

Sets a second timer to increase by delta time, and switch the position of a circle, between 2 grid cells, every 2 seconds (just like in the [Basic timer](#basic-timer) module).

It also sets another timer to update a seconds counter every second.

**[[⬆]](#ToC)**

## ***Module 15:*** <a name='color-mapper'>[Color Mapper][module-15]</a>

Displays shapes with a cross-version color mapper.

In versions prior to 11.0, color component values were within the range of 0 to 255 instead of 0 to 1.

[https://love2d.org/wiki/love.graphics.clear][function-clear]

Represents the color mapper as a class object, which calls color related operations and modifies component values as needed. It uses vrld's [class][library-class] library to do so, as usual.

Draws 2 colored squares inside different grid cells, and applies the same color for both shapes, one with component values within the range of 0 to 255, and the other with component values ranging from 0 to 1.

**[[⬆]](#ToC)**

## ***Module 16:*** <a name='square-chain'>[Square Chain][module-16]</a>

Displays a chain of filled squares, represented as class objects, inside a 16x16 pixel grid.

Uses vrld's [class][library-class] library to represent the squares as data, and uses the [Color Mapper](#color-mapper) class from the previous module to apply different colors to the structure, and highlight the chain's head and tail.

**[[⬆]](#ToC)**

## ***Module 17:*** <a name='chain-object'>[Chain object][module-17]</a>

Displays the chain from the previous module, and represents it as a single class object. Uses vrld's [class][library-class] library to do so; and uses the [Color Mapper](#color-mapper) class from module 15 for the same reasons as the previous module.

It places the structure into a 16x16 pixel grid as well.

**[[⬆]](#ToC)**

## ***Module 18:*** <a name='quit-game'>[Quit game][module-18]</a>

Prints a message at the center of the screen that indicates the user what key to press to quit the game, and terminates the
game when that key is pressed.

**[[⬆]](#ToC)**

## ***Module 19:*** <a name='title'>[Title][module-19]</a>

Sets the title of the game window as 'Game title'.

**[[⬆]](#ToC)**

## ***Module 20:*** <a name='fps'>[FPS][module-20]</a>

Renders a simple FPS display for debugging, and draws a filled square, represented as a class object, inside one of the grid cells. Uses the [Color Mapper](#color-mapper) class from module 15 to highlight the display, and vrld's [class][library-class] library to represent the square as data.

The game takes input from the user and moves the square in one of four directions to adjacent grid cells, depending on the pressed key; and updates the square position every second. Applies the same logic from the [Square move](#square-move) module.

**[[⬆]](#ToC)**

## ***Module 21:*** <a name='chain-move'>[Chain move][module-21]</a>

Gets the user's input to move a chain of filled squares. It uses vrld's [class][library-class] library to represent the chain object as code; and uses the [Color Mapper](#color-mapper) class from module 15 for the same reason as the [Square chain](#square-chain) module, to highlight the chain's head and tail.

Takes the input to set the direction of the movement.

Moves the chain's head in one of four directions to adjacent grid cells, depending on the pressed key, one grid cell at a time.

Updates the chain's head position every second. Modifies the rest of the squares so that they follow its trajectory.

**[[⬆]](#ToC)**

## ***Module 22:*** <a name='chain-grow'>[Chain grow][module-22]</a>

Takes the user's input to increase the chain size. It uses vrld's [class][library-class] library and the [Color Mapper](#color-mapper) class from module 15 for the same reason mentioned in the [Square chain](#square-chain) module.

Gets the input to set a growth flag to true. Sets that flag back to false right after a new square is added to the chain.

It also gets input from the user to move the chain's head in one of four directions to adjacent grid cells, depending on the
pressed key, as the rest of the squares follow the head's trajectory. This feature was implemented in the previous module.

If the structure has a single square, the growth flag is set to true, and the chain's size is increased once by 1 as well.

Changes the head's color while the chain is growing, with the Color Mapper, to display visual feedback.

Updates the chain's state every second.

**[[⬆]](#ToC)**

## ***Module 23:*** <a name='chain-velocity'>[Chain velocity][module-23]</a>

Gets the user's input to increase the chain velocity. It uses vrld's [class][library-class] library and the [Color Mapper](#color-mapper) class from module 15 for the same reason as mentioned in the [Square chain](#square-chain) module.

Takes the input to set a momentum percentage to 25%. Uses that value to reduce the structure's refresh rate by that amount.

It also gets input from the user to move the chain's head in one of four directions to adjacent grid cells, as it was mentioned in the [Chain move](#chain-move) module.

Ensures the refresh rate isn't so low that the game becomes unplayable.

Updates the chain's state, depending on the amount of seconds specified by the structure's refresh rate.

**[[⬆]](#ToC)**

## <a name='FrM'>Future modules</a>

  - ***Module 24:*** Offset grid
  - ***Module 25:*** Inner bounds
  - ***Module 26:*** Self collision
  - ***Module 27:*** Game over
  - ***Module 28:*** Game reset
  - ***Module 29:*** Game state
  - ***Module 30:*** Sounds
  - ***Module 31:*** State object

**[[⬆]](#ToC)**

---

### Credits ###

This repository was inspired by [CS50's Introduction to Game Development][credits-course] online course, which was mainly instructed by [Colton Ogden][credits-instructor], and contains lectures and hands-on projects related to the development of 2D and 3D interactive games. It was also inspired by that [course's repository][credits-repo], Olivine Labs' [Lua Style Guide][credits-lua-style], cocos2d's [cocos2d Javascript test and games][credits-cocos2d-games], and OneSignal's [Emoji Picker][credits-emoji-picker]. This version is focused on the basics of the [Lua programming language][credits-lua], and the [Love 2D framework][credits-love2d].

**[[⬆]](#ToC)**

### Technical specifications ###

   * Operating system: Windows
   * Text editor of choice: Sublime Text 3

**[[⬆]](#ToC)**

### Websites ###

   * Lua programming language: [http://www.lua.org][credits-lua]
   * Love 2D: [https://love2d.org][credits-love2d]

   [library-push]: https://github.com/Ulydev/push "Ulydev's push repository"
   [library-class]: https://github.com/vrld/hump/blob/master/class.lua "vrld's class repository"
   [function-clear]: https://love2d.org/wiki/love.graphics.clear "Love 2d clear function"
   
   [credits-course]: https://online-learning.harvard.edu/course/cs50s-introduction-game-development "CS50's Introduction to Game Development online course"
   [credits-instructor]: https://github.com/coltonoscopy "Colton Ogden's Github profile"
   [credits-repo]: https://github.com/games50/ "CS50's Introduction to Game Development Github repository"
   [credits-lua]: http://www.lua.org "Lua website"
   [credits-love2d]: https://love2d.org "Love 2D website"
   [credits-lua-style]: https://github.com/Olivine-Labs/lua-style-guide "Lua Style Guide repository"
   [credits-cocos2d-games]: https://github.com/cocos2d/cocos2d-js-tests "Cocos2d Javascript test and games repository"
   [credits-emoji-picker]: https://github.com/OneSignal/emoji-picker "Emoji Picker repository"

   [module-0]: https://github.com/e2matheus/love2d-modules/tree/master/module-0-hello "Hello World module code"
   [module-1]: https://github.com/e2matheus/love2d-modules/tree/master/module-1-low-res "Low-res module code"
   [module-2]: https://github.com/e2matheus/love2d-modules/tree/master/module-2-font "Font module code"
   [module-3]: https://github.com/e2matheus/love2d-modules/tree/master/module-3-grid "Grid module code"
   [module-4]: https://github.com/e2matheus/love2d-modules/tree/master/module-4-corners "Corners module code"
   [module-5]: https://github.com/e2matheus/love2d-modules/tree/master/module-5-circle "Circle module code"
   [module-6]: https://github.com/e2matheus/love2d-modules/tree/master/module-6-current-time "Current time module code"
   [module-7]: https://github.com/e2matheus/love2d-modules/tree/master/module-7-font-sizes "Font sizes module code"
   [module-8]: https://github.com/e2matheus/love2d-modules/tree/master/module-8-square-object "Square object module code"
   [module-9]: https://github.com/e2matheus/love2d-modules/tree/master/module-9-grid-object "Grid object module code"
   [module-10]: https://github.com/e2matheus/love2d-modules/tree/master/module-10-circle-object "Circle object module code"
   [module-11]: https://github.com/e2matheus/love2d-modules/tree/master/module-11-random-circle "Random circle module code"
   [module-12]: https://github.com/e2matheus/love2d-modules/tree/master/module-12-basic-timer "Basic timer module code"
   [module-13]: https://github.com/e2matheus/love2d-modules/tree/master/module-13-square-move "Square move module code"
   [module-14]: https://github.com/e2matheus/love2d-modules/tree/master/module-14-timer-object "Timer object module code"
   [module-15]: https://github.com/e2matheus/love2d-modules/tree/master/module-15-color-mapper "Color Mapper module code"
   [module-16]: https://github.com/e2matheus/love2d-modules/tree/master/module-16-square-chain "Square Chain module code"
   [module-17]: https://github.com/e2matheus/love2d-modules/tree/master/module-17-chain-object "Chain object module code"
   [module-18]: https://github.com/e2matheus/love2d-modules/tree/master/module-18-quit-game "Quit game module code"
   [module-19]: https://github.com/e2matheus/love2d-modules/tree/master/module-19-title "Title module code"
   [module-20]: https://github.com/e2matheus/love2d-modules/tree/master/module-20-fps "FPS module code"
   [module-21]: https://github.com/e2matheus/love2d-modules/tree/master/module-21-chain-move "Chain move module code"
   [module-22]: https://github.com/e2matheus/love2d-modules/tree/master/module-22-chain-grow "Chain grow module code"
   [module-23]: https://github.com/e2matheus/love2d-modules/tree/master/module-23-chain-velocity "Chain velocity module code"
   
**[[⬆]](#ToC)**
