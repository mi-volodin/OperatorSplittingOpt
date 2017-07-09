workspace()
include("OperatorSplitting/OperatorSplitting.jl")
using OperatorSplitting


testprb = Problem("dense_jl.mat")

testprb.constraintBlocks[1,1]

A = 3.0

assert(1==2)

B = sprand(5,5,0.5)

nzrange(B, 2)[1:1]

rowvals(B)

rows = rowvals(B)
nnz = nonzeros(B)

for j = 1:5
  for i = nzrange(B, j)
    println(rows[i], j, i, j)
  end
end
