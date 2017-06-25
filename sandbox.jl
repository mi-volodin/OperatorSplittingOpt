type OperatorSplittingProblem
  A::SparseMatrixCSC{Float} # block of the problem
  y::Array{Float} # rhs for this block
  M::Integer # number of the block
  N::Integer # col number of the block

  getxdim::Function
  getydim::Function
end
