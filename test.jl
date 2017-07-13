workspace()
include("OperatorSplitting/OperatorSplitting.jl")
using OperatorSplitting


testprb = Problem("dense_jl.mat")

OperatorSplitting.solveLP(testprb)

g = zeros(5)

using ProximalOperators

a = [1 2  3]
b = [3; 2; 1]

x = [1; 1; 1]

g = IndBox([0;0;0], [1;1;1])

myprox(v, lam) = prox(g, v - lam * a, lam)


v = [3 2.5 3]
myprox(v, 1)

a = sparse([1, 2, 1], [1,2,3], [1,1,1], 2, 3)

pinv(full(a))
