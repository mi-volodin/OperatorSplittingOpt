include("OperatorSplitting/OperatorSplitting.jl")

using OperatorSplitting

testprb = Problem("dense_jl.mat")

A = 3.0

typeof(A)<:Float64
