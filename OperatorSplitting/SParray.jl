struct SPArray{Tv, Ti<:Integer}
  m::Int                  # Number of rows
  n::Int                  # Number of columns
  colptr::Vector{Ti}      # Column i is in colptr[i]:(colptr[i+1]-1)
  rowval::Vector{Ti}      # Row indices of stored values
  nzval::Vector{Tv}       # Stored values, typically nonzeros

  SPArray{Tv, Ti}(
    m::Int, n::Int,
    colptr::Vector{Ti},
    rowval::Vector{Ti},
    nzval::Vector{Tv}) where {Tv, Ti<:Integer}  = new(m,n, colptr, rowval, nzval)
end
