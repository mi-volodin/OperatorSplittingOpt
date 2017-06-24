immutable SParray{Tv,Ti<:Integer}
  m::Int                  # Number of rows
  n::Int                  # Number of columns
  colptr::Vector{Ti}      # Column i is in colptr[i]:(colptr[i+1]-1)
  rowval::Vector{Ti}      # Row indices of stored values
  nzval::Vector{Tv}       # Stored values, typically nonzeros
end

function SPArrayFromProblem(Blocks::Array{Any}, Tv::Type)
  # assumes block is a dict with A, y, M, N fields
  maxM, maxN = 0, 0
  l = length(Blocks)
  nzval = Vector{Tv}(l)

  colrow = Matrix{Int}(l, 3)

  for k in eachindex(Blocks)
    block = Blocks[k]
    i = block["i"]
    j = block["j"]
    maxM = maxM < i ? i : maxM
    maxN = maxN < j ? j : maxN

    colrow[j, :] = [i j k]
  end

  sortrows(colrow, by= x->x[1:2])

  colptr = colrow[:, 1]
  rowval = colrow[:, 2]

  for k in colrow[:, 3]
    nzval[k] = Blocks[k]

end
