# Strategy RPG

## Introduction

The aim for this assignment was to create a game. Around the time that this assignment was set, I had an interest in games such as XCOM and Fire Emblem, so I decided that I would try to make something similar. The key features of these games are

* Each side has a limited number of units
* Each side takes a turn to move their units
* These units have restricted movement and attack ranges
* Units cannot act outside these ranges
* The game will end once one player's team has been eliminated
	
At first, I had planned to add an AI player, but I found that it would probably end up taking too long to implement in order to have the assignment ready by the assigned date. As such, I decided this would be a two-player game, where each player takes turns to control their team from the same computer.

## Assignment Plan

### Player Units

My plan is to have a number of different unit types that will be determined by the stats that have been allocated to that unit.
The stats will comprise of the following

* A strength stat, which will determine attack strength, defense, and hit points
* A dexterity stat, which will determine evasiveness, speed and movement ranges
* A magic stat, which will determine spell strength and critical strike chance

Each of these stats have an associated colour, which will mix together to create the hybrid unit types. The colours chosen are:

* Red for strength
* Green for dexterity
* Blue for magic
	
The unit types will be as follows:

* Tank, a pure strength unit
* Ranger, a pure dexterity unit
* Mage, a pure magic unit
* Assassin, a dexterity and magic hybrid unit
* Templar, a strength and magic hybrid unit
* Swordsman, a strength and dexterity hybrid unit
	
### Game board

The game board will consist of a number of cells that will create a grid. This grid will always have equal rows and columns. Each cell can contain a single unit. On a player's turn, they can choose to move one of their units to an empty cell, or they can attack an enemy unit, providing that the action is viable.

## Implementation

This game is dependant on the concepts of encapsulation and polymorphism. I have tried to contain each aspect of the game in its own class. For example, the Unit abstract class is extended by multiple subclasses, each of which will contain an implementation for each of the different unit types.

Each cell on the board will also have its own class, which will contain information on the unit it might contain, its position on the board, and its current state.

The Board class will then have control over each cell, and will check for player input and change the board state accordingly, or display a message if the move wasn't possible.

Each of these classes come together in the Game class, which controls team creation and board rendering, as well as the game state.

## How to play

* Left-click a unit that has a white highlight in order to select it
* Left-click any of the blue-highlighted cells to move your selected unit to that cell
* Left-click any unit in a red-highlighted cell in order to attack that unit
* Right-click any selected unit to deselect the unit without spending a turn
* The next player moves their units once the current player has moved all of their units
* A unit dies once its HP reaches zero.
* The game ends once a player has lost all their units

## Screenshots

### Initial board
![Initial Board](https://github.com/GJB93/strategyRPG/blob/master/readmeImages/initialBoard.PNG?raw=true)

### Moving a unit
![Moving](https://github.com/GJB93/strategyRPG/blob/master/readmeImages/move.PNG?raw=true)

### Attack move available
![Attack Move](https://github.com/GJB93/strategyRPG/blob/master/readmeImages/attack.PNG?raw=true)
