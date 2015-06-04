import strutils
import permutations

type
  TBoard* = object
    size: int
    rows: seq[seq[int]]
    queens: seq[seq[int]]
  Board = ref TBoard


proc initialize_board(board: Board, n:int):seq[seq[int]]=
  var queens = 1
  board.queens = @[]
  result = @[]
  for i in 1..n:
    var column:seq[int] = @[]
    for j in 1..n:
      var add_queen = j == i and j == queens
      column.add(if add_queen: 1
                 else: 0)
      if add_queen:
        board.queens.add(@[i-1,j-1])
        queens += 1
    result.add(column)


proc check_diagonal(b:Board, q:seq[int]):bool=
  for queen in b.queens:
    if q[0] != queen[0] and q[1] != queen[1]:
      var difference:seq[int] = @[(q[0] - queen[0]).abs, (q[1] - queen[1]).abs]
      if difference[0] == difference[1]:
        return false
  return true

proc solved(b:Board):bool=
  for queen in b.queens:
    if not b.check_diagonal(queen):
      return false
  return true

proc set_queen(b:Board, row, col: int):void=
  var queen = addr(b.queens[row])
  b.rows[queen[0]][queen[1]] = 0
  queen[1] = col
  b.rows[queen[0]][queen[1]] = 1


proc dup(b:Board):Board=
  new(result)
  result.size = b.size
  result.rows = b.rows

proc print*(b:Board):void=
  var rows = b.rows.map do (row:seq[int]) -> string:
    $row
  echo join(rows, "\n")

proc newBoard*(n:int):Board=
  new(result)
  result.size = n
  result.rows = initialize_board(result, n)

