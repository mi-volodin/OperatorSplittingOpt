module OperatorSplitting

  typealias SPMatrix{T} SparseMatrixCSC{T}

  typealias SPArray{T} SparseMatrixCSC{T}

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
  end

  type LinFunctionalBlock
    f::Vector{Float} # functional coefficients
    j::Integer # number of the block

    LinFunctionalBlock(f::Vector{Float}, j::Integer) = new(f, j)
  end

  type Problem
    constraintBlocks::SPMatrix{ProblemBlock}
    objective::Array{LinearFunctionalBlock}

    # nnz_ij::Matrix{Integer} #nonzero block indices

    eps_rel::Float = 1e-3
    eps_abs::Float = 1e-2

    function Problem(MATFilename::String)
      file = matopen(MATFilename) #open file

      # read file contents
      f = read(file, "f")
      A = read(file, "A")
      h = read(file, "h")
      eps_rel = read(file, "eps_rel")
      eps_abs = read(file, "eps_abs")

      M = read(file, "M")
      N = read(file, "N")

      # scan the blocks to
      objective =
        [LinearFunctionalBlock(f[j], j) for eachindex(f)]


      # construct the Problem blocks
      constraintBlocks = SPMatrix{ProblemBlock}(M, N)
      for block in A
        i = block.i
        j = block.j
        constraintBlocks[i, j] = ProblemBlock(block)
      end

      # create object
      return new(constraintBlocks, objective, eps_rel, eps_abs)

    end
  end

end
