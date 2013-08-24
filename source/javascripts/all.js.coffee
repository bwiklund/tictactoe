app = angular.module('tictactoe',[])

app.factory 'Board', ->
  class Board
    constructor: (@width) ->
      # grid contains 0 for empty, 1 for player 1, 2 for player 2
      @grid = ( 0 for i in [0..@width*@width] )

    xy2index: (x,y) ->
      y * @width + x

    move: (x,y,playerId) ->
      # TODO: validate
      @grid[ @index(x,y) ] = playerId

    checkVictory: ->
      false #stub

app.controller 'GameCtrl', ($scope, Board) ->
  $scope.board = new Board(3)
