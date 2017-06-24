module OperatorSplitting

  export Problem
  using MAT

  typealias SPMatrix{T} SparseMatrixCSC{T, Int}

  typealias Float Float64

  type ProblemBlock
    A::SPMatrix{Float} # block of the problem
    y::Vector{Float} # rhs for this block
    i::Integer # number of the block
    j::Integer # col number of the block

    xdim::Integer # number of cols
    ydim::Integer # number of rows

    function ProblemBlock(
      A::SPMatrix{Float},
      y::Vector{Float},
      i::Integer,
      j::Integer)
      xd, yd = size(A)
      return new(A, y, i, j, xd, yd)
    end

    function ProblemBlock(
      A::SPMatrix{Float},
      y::Number,
      i::Integer,
      j::Integer)

      if y != 0
        error("Expected to be zero")
      end
      xd, yd = size(A)
      y = zeros(Float, xd)
      return new(A, y, i, j, xd, yd)
    end
  end

  type LinFunctionalBlock
    f::Union{Matrix{Float}, Float} # functional coefficients
    j::Integer # number of the block

    LinFunctionalBlock(f::Union{Matrix{Float}, Float}, j::Integer) = new(f, j)
  end

  type Problem
    constraintBlocks::SPMatrix{ProblemBlock}
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
      constraintBlocks = SPMatrix{ProblemBlock}(M, N)
      # for block in A
      #   i = block["i"]
      #   j = block["j"]
      #   constraintBlocks[i, j] =
      #     ProblemBlock(block["A"], block["y"], block["i"], block["j"])
      # end

      # create object
      return new(constraintBlocks, objective, eps_rel, eps_abs)

    end
  end

end
