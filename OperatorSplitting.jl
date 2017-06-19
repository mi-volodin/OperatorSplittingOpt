module OperatorSplitting

  typealias SPMatrix{T} SparseMatrixCSC{T}

  type ProblemBlock
    A::SPMatrix{Float} # block of the problem
    y::Vector{Float} # rhs for this block
    M::Integer # number of the block
    N::Integer # col number of the block

    xdim::Integer # number of cols
    ydim::Integer # number of rows

    function ProblemBlock(
      A::SPMatrix{Float},
      y::Vector{Float},
      M::Integer,
      N::Integer)
      xd, yd = size(A)
      return new(A, y, M, N, xd, yd)
    end
  end

  type LinFunctionalBlock
    f::Vector{Float} # functional coefficients
    N::Integer # number of the block

    LinFunctionalBlock(f::Vector{Float}, N::Integer) = new(f, N)
  end

  type Problem
    constraintBlocks::Matrix{ProblemBlock}
    objective::Array{LinearFunctionalBlock}

    nnz_ij::Matrix{Integer} #nonzero block indices

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

      M, N = size(A)

      # scan the blocks to 


      # construct the Problem blocks
      constraintBlocks = Matrix{ProblemBlock}(M, N)

      # create object
      return new(A, f)

    end
  end

end
