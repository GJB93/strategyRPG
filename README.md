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

This game is dependant on the concepts of encapsulation and polymorphism. I have tried to contain each aspect of the game in its own class. For example, the Unit abstract class is extended by multiple subclasses, each of which will contain an implementation for each of the different unit types I have in mind for the game. The unit types are determined by their stat affinity. This means that a unit that has a high strength stat will be different from a unit that has a high dexterity stat.


  
  
