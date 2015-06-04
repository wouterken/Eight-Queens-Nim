include Board

for size in 2..9:
  echo "" & $size & "x" & $size
  var rows:seq[int] = @[]
  for i in 0..size-1: rows.add(i)

  var solutions:int = 0
  for swaps in permutations(rows):
    var b:Board = newBoard(size)
    for col, row in pairs(swaps):
      b.set_queen(row, col)
    if b.solved:
      solutions += 1
      stdout.write "\rBoard size: " & $size & " Found " & $solutions & " solutions"
  echo if solutions > 0: "" else: "no solutions"


