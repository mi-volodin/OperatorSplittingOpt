workspace()
include("OperatorSplitting/OperatorSplitting.jl")
using OperatorSplitting

testprb = Problem("dense_jl.mat")

A = 3.0

convert(Int, A)

typeof(A)<:Float64

a = ["1" 2 3 "5"]
vec(a)
maximum(a)

sortrows(a,by=x-> x[[2,1]], lt=(x,y)->isless2(x,y) )


function isless2(x::Vector{Float64}, y::Vector{Float64})
  for i in eachindex(x)
    if !isless(x[i], y[i])
      return false
    end
  end
  true
end
