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
      console.log @board.game.advanceTurn()


app.factory 'Board', (Square) ->
  class Board
    constructor: (@game,@width) ->
      @grid = ( new Square(this) for i in [0...@width*@width] )

    xy2index: (x,y) ->
      y * @width + x

    checkVictory: ->
      console.log("i am now checking for victory.")

      winner = null

      # check rows. no time to explain
      for y in [0...@width]
        lastCell = null
        for x in [0...@width]
          thisCell = @grid[ @xy2index(x,y) ].player

          # empty square means no winner in this row
          if thisCell == null
            lastCell = null
            break

          # first cell
          if lastCell == null
            lastCell = thisCell
            continue

          # subsequent cells
          if lastCell != thisCell
            lastCell = null
            break

        if lastCell then return true

      false


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
      @board = new Board(this,3) # i guess this game only works with odd widths? no time to check wiki page.
      @currentPlayerIndex = 0

    currentPlayer: ->
      @players[@currentPlayerIndex]

    advanceTurn: ->
      @currentPlayerIndex = (@currentPlayerIndex + 1) % @players.length
      @board.checkVictory()


app.controller 'GameCtrl', ($scope, Game) ->
  $scope.game = new Game()
