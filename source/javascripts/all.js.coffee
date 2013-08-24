app = angular.module('tictactoe',[])


# an array of numbers would work but ng-repeat likes unique objects
app.factory 'Square', ->
  class Square
    constructor: (@board) ->
    
    style: -> 
      'player-' + @player
    
    glyph: -> 
      @player?.glyph || "_"

    mark: (player) -> 
      #todo: validation
      @player = player
      @board.checkVictory()


app.factory 'Board', (Square) ->
  class Board
    constructor: (@width) ->
      @grid = ( new Square(this) for i in [0...@width*@width] )

    xy2index: (x,y) ->
      y * @width + x

    checkVictory: ->
      console.log("i am now checking for victory.")
      false #stub


app.factory 'Player', ->
  class Player
    constructor: (@glyph) ->


app.factory 'Game', ( Board, Player) ->
  class Game
    constructor: ->
      @players = [
        new Player("X")
        new Player("O")
      ]
      @board = new Board(3)


app.controller 'GameCtrl', ($scope, Game) ->
  $scope.game = new Game()
