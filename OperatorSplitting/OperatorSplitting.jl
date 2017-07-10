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

  struct VectorBlock
    v::Union{Matrix{Float}, Float} # vector that might be zeros
    j::Integer # number of the block
  end

  zeros(vb::VectorBlock) = zeros(vb.v)

  include("Problem.jl")



  function solveLP(prb::Problem)


    ##
    # Algorithm variables initializations
    ##
    M, N = size(prb.Ablocks)

    y_i = Array{Vector{Float}}(N); # <- right hand side
    for i in eachindex(y_i)
      y_i(i) = typeof(prb.yblocks[i]) <: Number ? zeros(getydim(prb, i)) : prb.yblocks[i]
    end

    x_j = Array{Vector{Float}}(N); # <- x_0 or zeros vector
    for j in eachindex(x_j)
      x_j(j) = zeros(getxdim(prb, j))
    end

    # x_j_half = copy(x_j); # <- x_j
    # y_i_half = copy(y_i); # <- y_i

    x_ij = 0; # <- x_j for j and any i
    y_ij = 0; # <- y_i for i and any j

    x_ij_half = x_ij; # <- x_ij

    y_i_hat = 0;
    x_j_hat = 0;
    x_ij_hat = 0;
  end

end
