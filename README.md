
---
# Connect 4 Swift IOS Game

## Overview

![image](https://user-images.githubusercontent.com/44605305/231791727-7e2c09a0-c23c-49e3-83a6-cf99741f383f.png)

We set out to make a connect 4 board game swift iOS application using storyboard with a Model
View Controller architecture. The base project already gave us a good start. It contained a
gameSession protocol with all the common methods that we would need such as isValidMove
which checks if a discDrop is valid for a given column. The αC4 ai provided us with an ai that
could play connect 4. Furthermore, we were provided some ViewController class that demonstrated
how to implement the protocol and a few other pieces such as the printed board, boardInit function,
etc. [

![image](https://user-images.githubusercontent.com/44605305/231790243-74d02aca-c1e3-44b6-aee3-f1889a72724d.png)
![image](https://user-images.githubusercontent.com/44605305/231791871-a37efac5-f440-4bf2-a525-1d790653e412.png)
![image](https://user-images.githubusercontent.com/44605305/231791925-1a2da1d0-17d8-4e2c-8e36-61eac73888a5.png)

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
and hole positions on the board. The getGridWidth method takes a boardWidth argument and
returns the width of each grid square in the board. The getDiscRadius method takes a boardWidth
argument and returns the radius of the discs in the game. The getInitTile method takes a boardSize
and middle point as arguments and returns the point at which the top-left corner of the board should
be located. The createHolesHelper method takes a boardSize, boardBeginning point, column, and
row integer values as arguments and returns the point at which the center of the disc at the
specified column and row should be placed. The Connect4Model class also has two private helper
methods, goRight and goUp, which are used to calculate the horizontal and vertical offsets for the
hole positions on the board.

### The View
The view is divided in to the connect4 View and the discView.
The DiscView class represents a graphical disc that can be displayed in an iOS user interface.
It is a subclass of UIView and has a single instance variable called discDropped which is a tuple
containing information about the disc such as its color, index, and action. The DiscView class also
has a private instance variable called discLabel which is a UILabel object used to display text on
the disc. The DiscView class has an initializer that takes a CGRect object and an optional tuple
as arguments. It initializes the discDropped instance variable with the tuple if it is provided, or
with default values if it is not. The initializer also sets the discLabel object’s frame, center, and
text alignment properties. It also sets the background color and border properties of the DiscView
object based on the color of the disc. The DiscView class has a displayLabel method that takes
an optional array of integers as an argument and sets the discLabel object’s text to the index of
the disc. The method then adds the discLabel object as a subview of the DiscView object.
The Connect4View class is a subclass of UIView, which is a basic view class provided by the UIKit
framework. It represents a graphical view of a Connect 4 game board and has properties that
store information about the board, such as its width, center point, and colliders. It also has a
private CAShapeLayer object called board that is used to render the board. The Connect4View
class has a boardSources property that is a weak reference to an object that conforms to the
Connect4DataSource protocol, which defines a set of methods that provide information about
the board such as its start point, disc radius, and grid width. The Connect4View class also has
an override of the draw method, which is called when the view needs to be redrawn. In this
method, the board object is removed and a new UIBezierPath object is created and populated
with circles representing the holes in the board and a rounded rectangle representing the board
itself. A CAShapeLayer object is created, its path property is set to the UIBezierPath object, and
its fillRule and fillColor properties are set. The CAShapeLayer object is then added as a sublayer
to the Connect4View object’s layer property. [2] [3]

### View Controller
The Connect4ViewController still needs a lot of work. The connect4 Model and the connect 4
View or more less complete.
The Connect4ViewController is responsible for managing the Connect 4 game interface. It has
a number of properties, including a resultLabel for displaying messages to the user, a Connect4View
for displaying the game board, and a Connect4Model for handling game logic. The Connect4ViewController
class also conforms to the Connect4DataSource protocol, which defines a set of methods for
providing information about the game board.
The Connect4ViewController class has a number of methods for handling game events. These
include methods for handling player turns, resetting the game, and displaying messages to the
user. The class also has a tap method that is called whenever the user taps the screen, and a
playerTurn method that is called whenever it is the player’s turn to make a move. Additionally,
the Connect4ViewController class has a number of private helper methods for handling game logic
and displaying messages to the user.


![image](https://user-images.githubusercontent.com/44605305/231791160-51849d47-5cd2-4ab2-b64f-e643d5c5a771.png)


#### Bibliography
[1] Mozilla, Mozilla mvc. [Online]. Available: https://developer.mozilla.org/en-US/docs/
Glossary/MVC.
[2] R. Chuang, Github. [Online]. Available: https://github.com/5j54d93/Connect-4-iOSGame.
[3] G. Theodoropoulos, Bezier paths introduction. [Online]. Available: https://www.appcoda.
com/bezier-paths-introduction/.
