module OperatorSplitting

  export Problem
  using MAT
  using ProximalOperators

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

  # import Base.getindex
  # import Base.convert
  # getindex(vb::VectorBlock, j::Int) = typeof(v) <: Number ? v : v[j]
  # convert(T::Type, vb::VectorBlock) = convert(T, vb.v)
  # zeros(vb::VectorBlock) = zeros(vb.v)

  include("Problem.jl")



  function solveLP(prb::Problem)
    ##
    # Algorithm variables initializations
    ##
    M, N = size(prb.Ablocks)
    display((M,N))

    ## x_j and y_i
    y_i = Array{Vector{Float}}(M); # <- right hand side
    for i in eachindex(y_i)
      y_i[i] = length(prb.yblocks[i].v) == 1 ?
        zeros(getydim(prb, i)) : vec(prb.yblocks[i].v)
    end

    x_j = Array{Vector{Float}}(N); # <- x_0 or zeros vector
    for j in eachindex(x_j)
      x_j[j] = zeros(getxdim(prb, j))
    end

    x_j_half = deepcopy(x_j); # <- x_j
    y_i_half = deepcopy(y_i); # <- y_i

    ## x_ij and y_ij
    I, J = findnz(prb.Ablocks)
    display((maximum(I), maximum(J)))
    x_zerovals = [deepcopy(x_j[j]) for j in J]
    y_zerovals = [deepcopy(y_i[i]) for i in I]

    x_ij = sparse(I, J, x_zerovals, M, N); # <- x_j for j and any i
    y_ij = sparse(I, J, y_zerovals, M, N); # <- y_i for i and any j

    x_ij_half = deepcopy(x_ij); # <- x_ij

    y_i_hat = deepcopy(y_i); # <- zeros of size y_i
    x_j_hat = deepcopy(x_j); # <- zeros of size x_j
    x_ij_hat = deepcopy(x_ij_half); # <- zeros of same as x_ij_half

    ##
    # proximal initializations
    ##


    prox_f = [IndBox(prb.dom_l[j], prb.dom_u[j]) for j in 1:N]
    prox_A = [IndAffine(prb.Ablocks[i, j].A,
                        length(prb.yblocks[i].v) > 1 ?
                          prb.yblocks[i].v :
                          zeros(size(prb.Ablocks[i,j].A, 1))
                        )
                for (i, j) in zip(I, J)]

    ##
    # Algorithm run
    ##

  end
end
