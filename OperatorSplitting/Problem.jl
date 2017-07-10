struct Problem
  Ablocks::SPArray{ProblemBlock}
  yblocks::Array{VectorBlock}
  objective::Array{VectorBlock}
  dom_l::Array{Vector{Float}}
  dom_u::Array{Vector{Float}}

  dims_x::Array{Int}
  dims_y::Array{Int}

  # nnz_ij::Matrix{Integer} #nonzero block indices

  eps_rel::Float
  eps_abs::Float
end

get_dims(p::ProblemBlock) = (size(p.A, 1),  size(p.A, 2), p.i, p.j)

function Problem(MATFilename::String)

  file = matopen(MATFilename) #open file

  # read file contents
  f = read(file, "f")
  A = read(file, "A")
  h = read(file, "h")
  l = read(file, "l")
  u = read(file, "u")
  eps_rel = read(file, "eps_rel")
  eps_abs = read(file, "eps_abs")

  M = convert(Int, read(file, "M"))
  N = convert(Int, read(file, "N"))

  # scan the blocks to
  objective = [VectorBlock(f[j], j) for j in eachindex(f)]
  yblocks = [VectorBlock(h[j], j) for j in eachindex(h)]
  dom_l = [vec(l[j]) for j in eachindex(l)]
  dom_u = [vec(u[j]) for j in eachindex(u)]


  # construct the Problem blocks
  Ablocks = SPArrayFromMAT(A)
  Mc, Nc = size(Ablocks)

  assert((Mc == M) & (Nc == N))

  dims_x = Array{Int}(Nc)
  dims_y = Array{Int}(Mc)

  # rows = rowvals(A)
  vals = nonzeros(Ablocks)
  @inbounds for j = 1:Nc
    for i = nzrange(Ablocks, j)
      dx, dy, r, c = get_dims(vals[i])
      dims_x[c] = dx
      dims_y[r] = dy
    end
  end

  # create object
  return Problem(Ablocks, yblocks, objective, dom_l, dom_u,
    dims_x, dims_y, eps_rel, eps_abs)

end

getxdim(p::Problem) = p.dims_x
getxdim(p::Problem, j::Int) = p.dims_x[j]

getydim(p::Problem) = p.dims_y
getydim(p::Problem, i::Int) = p.dims_y[i]
