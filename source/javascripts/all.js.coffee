app = angular.module('tictactoe',[])

# an array of numbers would work but ng-repeat likes unique objects
app.factory 'Square', ->
  class Square
    mark: (@player) ->
    style: -> 'player-' + @player
    glyph: -> @player?.glyph || "_"

app.factory 'Board', (Square) ->
  class Board
    constructor: (@width) ->
      @grid = ( new Square for i in [0...@width*@width] )

    xy2index: (x,y) ->
      y * @width + x

    move: (x,y,player) ->
      # TODO: validate
      @grid[ @index(x,y) ].mark player

    checkVictory: ->
      false #stub

app.factory 'Player', ->
  class Player
    constructor: (@glyph) ->

app.controller 'GameCtrl', ($scope, Board, Player) ->
  $scope.players = [
    new Player("X")
    new Player("O")
  ]
  $scope.board = new Board(3)
