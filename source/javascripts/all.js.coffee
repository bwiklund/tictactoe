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
      return true if @checkStraightLines( (x,y) => (@xy2index(x,y) ) )
      return true if @checkStraightLines( (x,y) => (@xy2index(y,x) ) )
      return true if @checkDiagonals()
      return false

    # so we can reuse this to check rows and cols
    checkStraightLines: (indexFn) ->

      # check rows. no time to explain
      for y in [0...@width]
        sequence = []
        for x in [0...@width]
          sequence.push( @grid[ indexFn(x,y) ].player )
        return true if @checkSequence sequence

      false

    checkDiagonals: ->
      # no time left, i regret nothing
      return true if @checkSequence( ( @grid[ @xy2index(i,i) ].player          for i in [0...@width] ) )
      return true if @checkSequence( ( @grid[ @xy2index(i,@width-1-i) ].player for i in [0...@width] ) )
      false

    # take an array of squares and say if it's a all one player
    checkSequence: (squares) ->
      lastCell = null

      for thisCell in squares

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



app.factory 'Player', ->
  class Player
    constructor: (@glyph) ->


app.factory 'Game', ( Board, Player) ->
  class Game
    constructor: ->
      @newBoard()

    newBoard: ->
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
      if @board.checkVictory()
        alert("you win congrats etc")
        @newBoard()



app.controller 'GameCtrl', ($scope, Game) ->
  $scope.game = new Game()
