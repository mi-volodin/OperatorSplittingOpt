module OperatorSplitting

  export Problem
  using MAT

  typealias SPMatrix{T} SparseMatrixCSC{T, Int}

  typealias Float Float64

  include("SParray.jl")   # Sparse array
  include("ProblemBlock.jl") # PROBLEM BLOCK

  # LINEAR FUNCTIONAL BLOCK
  immutable LinFunctionalBlock
    f::Union{Matrix{Float}, Float} # functional coefficients
    j::Integer # number of the block
    # LinFunctionalBlock(f::Union{Matrix{Float}, Float}, j::Integer) = new(f, j)
  end

  type Problem
    constraintBlocks::SPArray{ProblemBlock, Int}
    objective::Array{LinFunctionalBlock}

    # nnz_ij::Matrix{Integer} #nonzero block indices

    eps_rel::Float
    eps_abs::Float

    function Problem(MATFilename::String)

      file = matopen(MATFilename) #open file

      # read file contents
      f = read(file, "f")
      A = read(file, "A")
      # h = read(file, "h")
      eps_rel = read(file, "eps_rel")
      eps_abs = read(file, "eps_abs")

      M = read(file, "M")
      N = read(file, "N")

      # scan the blocks to
      objective =
        [LinFunctionalBlock(f[j], j)
          for j in eachindex(f)]

      # construct the Problem blocks
      constraintBlocks = SPArrayFromMAT(A)

      # create object
      return new(constraintBlocks, objective, eps_rel, eps_abs)

    end
  end

end
