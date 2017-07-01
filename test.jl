workspace()
include("OperatorSplitting/OperatorSplitting.jl")
using OperatorSplitting


testprb = Problem("dense_jl.mat")

A = 3.0

dd = Dict



convert(Int, A)

typeof(A)<:Float64

a = ["1" 2 3 "5"]

methods(indexin)

vec(a)
maximum(a)

sortrows(a,by=x-> x[[2,1]], lt=(x,y)->isless2(x,y) )

struct MMM
  A::Matrix{Int}
end

M = MMM(ones(5,10))

import Base.getindex

function getindex(X::MMM, I_1)
  print(I_1)
  I_1
end

M[1:4] + 1
