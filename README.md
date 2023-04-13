
---
# Connect 4 Swift IOS Game

## Overview

![image](https://user-images.githubusercontent.com/44605305/231791727-7e2c09a0-c23c-49e3-83a6-cf99741f383f.png)
![image](https://user-images.githubusercontent.com/44605305/231792305-3bc1521a-fac9-49c7-a2c0-f78a3089f202.png)
![image](https://user-images.githubusercontent.com/44605305/231792366-b6b63dff-7ea4-4d70-ac83-d2336dc99906.png)

We set out to make a connect 4 board game swift iOS application using storyboard with a Model
View Controller architecture [1]. 
![image](https://user-images.githubusercontent.com/44605305/231793183-21eaa8a5-1448-4405-9dde-e04b2171a4ef.png)

## First Steps
The first thing I did was create the model, then the view and finally the viewController. Some of
the items in viewController would better be moved to view however near the end in time trouble
I added all remaining functionality in viewController. Ideally the viewController should not be
performing any calculations. This should be done in the view. The viewController is simply a
means of presenting the view and the model contains the data structure of the game such as the
number of Columns.

### Model
The connect 4 model file contains a Connect4Model swift class that provides utility functions for
calculating and returning various values related to a Connect 4 game board. The Connect4Model
class has four methods for calculating and returning the grid width, disc radius, initial tile position,
and hole positions on the board. 

### The View
The view is divided in to the connect4 View and the discView.
The DiscView class represents a graphical disc that can be displayed in an iOS user interface [2] [3]

### View Controller
The Connect4ViewController still needs a lot of work. The connect4 Model and the connect 4
View or more less complete.
The Connect4ViewController is responsible for managing the Connect 4 game interface. It has
a number of properties, including a resultLabel for displaying messages to the user, a Connect4View
for displaying the game board, and a Connect4Model for handling game logic.


#### Bibliography
[1] Mozilla, Mozilla mvc. [Online]. Available: https://developer.mozilla.org/en-US/docs/
Glossary/MVC.

[2] R. Chuang, Github. [Online]. Available: https://github.com/5j54d93/Connect-4-iOSGame.

[3] G. Theodoropoulos, Bezier paths introduction. [Online]. Available: https://www.appcoda.com/bezier-paths-introduction/.
