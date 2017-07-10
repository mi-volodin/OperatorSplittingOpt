struct ProblemBlock
  A::SPMatrix{Float} # block of the problem
  # y::Vector{Float} # rhs for this block
  i::Integer # number of the block
  j::Integer # col number of the block

  xdim::Integer # number of cols
  ydim::Integer # number of rows

  function ProblemBlock(
    A::SPMatrix{Float},
    # y::Vector{Float},
    i::Integer,
    j::Integer)
    xd, yd = size(A)
    return new(A, i, j, xd, yd)
  end

  # function ProblemBlock(
  #   A::SPMatrix{Float},
  #   # y::Number,
  #   i::Integer,
  #   j::Integer)
  #
  #   if y != 0
  #     error("Expected to be zero")
  #   end
  #   xd, yd = size(A)
  #   y = zeros(Float, xd)
  #   return new(A, y, i, j, xd, yd)
  # end

  ProblemBlock(d::Dict{String}) =
    ProblemBlock(d["A"], convert(Int, d["i"]), convert(Int, d["j"]))

end


# Create Problem block from Matlab export
function SPArrayFromMAT(Blocks::Array{Any})
  # assumes block is a dict with A, y, i, j fields
  # Blocks = vec(Blocks)
  # Blocks = sort(vec(Blocks), by=x->[x["i"], x["j"]],
  #   lt=(x::Int,y::Int)-> (x[1] < y[1]) | (x[1] == y[1] & x[2] < y[2])
  # )

  l = length(Blocks)
  # colroword = Matrix{Int}(l,3)
  I = Vector{Int}(l)
  J = Vector{Int}(l)
  # B = Vector{Any}(l)


  for k in eachindex(Blocks)
    I[k] = Blocks[k]["i"]
    J[k] = Blocks[k]["j"]
    # colroword[k, :] = [b["j"], b["i"], k]
  end

  # colroword = sortrows(colroword)

  # colptr = vec(colroword[:, 1])
  # rowval = vec(colroword[:, 2])
  # ptrs = vec(colroword[:, 3])
  # colroword = 0
  nnzval = Vector{ProblemBlock}(l)

  for k in eachindex(Blocks)
    nnzval[k] = ProblemBlock(Blocks[k])
  end

  n = convert(Int, maximum(J))
  m = convert(Int, maximum(I))

  return sparse(I, J, nnzval, m, n)
  # return SPArray{ProblemBlock, Int}(m, n, colptr, rowval, nnzval)
end


# function SPMatrixFromMAT(Blocks::Array{Any})
#   # assumes block is a dict with A, y, i, j fields
#   # Blocks = vec(Blocks)
#   # Blocks = sort(vec(Blocks), by=x->[x["i"], x["j"]],
#   #   lt=(x::Int,y::Int)-> (x[1] < y[1]) | (x[1] == y[1] & x[2] < y[2])
#   # )
#
#   l = length(Blocks)
#   colroword = Matrix{Int}(l,3)
#
#
#   for k in eachindex(Blocks)
#     b = Blocks[k]
#     colroword[k, :] = [b["j"], b["i"], k]
#   end
#
#   colroword = sortrows(colroword)
#
#   colptr = vec(colroword[:, 1])
#   rowval = vec(colroword[:, 2])
#   ptrs = vec(colroword[:, 3])
#   colroword = 0
#   nnzval = Vector{ProblemBlock}(l)
#
#   for k in ptrs
#     nnzval[k] =
#       ProblemBlock(Blocks[k])
#   end
#
#
#   m = convert(Int, maximum(colptr))
#   n = convert(Int, maximum(rowval))
#
#   return sparse(rowval, colptr, nnzval, m, n)
# end
