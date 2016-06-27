# Terminal Rubiks

Rubiks cube game for the terminal 

## Installation

```
$ git clone https://github.com/at1as/terminal-rubiks.git
$ cd terminal-rubiks
$ ruby play.rb
```

The only dependency is the colorize gem (`sudo gem install colorize`)

## Screenshots

*3D View*

<img src="http://at1as.github.io/github_repo_assets/terminal-rubiks.png">

*Flat View*

<img src="http://at1as.github.io/github_repo_assets/terminal-rubiks-2.png">

## Usage

Instructions will be printed as the game starts. The first is cube display settings:

```
How would you like the cube printed?
    [1] Flat 2D Horizontal View
    [2] Flat 2D Vertical View
    [3] Single Face
    [4] 3-Dimensional View
```

And the insturctions for moving the cube:

```
To rotate the cube type any of the following
    `r <row num> <direction>`  (rotate row number <row num> in the direction <direction>)
    `c <col num> <direction>`  (rotate col number <col num> in the direction <direction>)
    `f <direction>`            (rotate cube face in the direction <direction>)

    Examples:
      `r 2 left`  or `r 2 l`
      `r 3 right` or `r 3 r`
      `c 1 up`    or `c 1 u`
      `c 1 down`  or `c 1 d`
      `f up`      or `f u`
```

### TODO
* Shuffle cube
* Change print display settings mid game
* CLI feels awkward. Needs some work
* Print cube after selecting print settings
