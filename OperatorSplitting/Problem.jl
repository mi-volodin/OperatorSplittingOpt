struct Problem
  constraintBlocks::SPArray{ProblemBlock}
  objective::Array{LinFunctionalBlock}

  # nnz_ij::Matrix{Integer} #nonzero block indices

  eps_rel::Float
  eps_abs::Float
end

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
  return Problem(constraintBlocks, objective, eps_rel, eps_abs)

end
