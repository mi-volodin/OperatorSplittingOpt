module OperatorSplitting

  export Problem
  using MAT

  SPMatrix{T} = SparseMatrixCSC{T, Int}
  SPArray{T} = SparseMatrixCSC{T, Int}

  if Int === Int64
    Float = Float64
  else
    Float = Float32
  end

  # include("SParray.jl")   # Sparse array
  include("ProblemBlock.jl") # PROBLEM BLOCK

  # LINEAR FUNCTIONAL BLOCK
  struct LinFunctionalBlock
    f::Union{Matrix{Float}, Float} # functional coefficients
    j::Integer # number of the block
    # LinFunctionalBlock(f::Union{Matrix{Float}, Float}, j::Integer) = new(f, j)
  end

  include("Problem.jl")

  # function solveLP(P::Problem)
  #
  #   ##
  #   # INITIALIZATIONS
  #   ##
  #
  #   g_j_c = Array{Any}(N)
  #
  #
  # end

end
