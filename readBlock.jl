using MAT

function readblock(path::String, i::Integer, j::Integer)
  # filepath
  blockfile = "$path/block_$(i)_$(j).mat"
  domfile = "$path/domain_$(i).mat"

  # read variables
  bfile = matopen(filename)
  # varnames = names(bfile)
  A = read(bfile, "A") # note that this does NOT introduce a variable ``varname`` into scope
  # xdim = read(bfile, "xdim")
  P = read(bfile, "P")
  D = read(bfile, "D")
  L = read(bfile, "L")
  close(file)
end

  string("a", "b")
