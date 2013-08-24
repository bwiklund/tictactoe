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
      @board.game.advanceTurn()


app.factory 'Board', (Square) ->
  class Board
    constructor: (@game,@width) ->
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
      @board = new Board(this,3)
      @currentPlayerIndex = 0

    currentPlayer: ->
      @players[@currentPlayerIndex]

    advanceTurn: ->
      @currentPlayerIndex = (@currentPlayerIndex + 1) % @players.length


app.controller 'GameCtrl', ($scope, Game) ->
  $scope.game = new Game()
