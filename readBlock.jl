using MAT


filename = "dense_jl.mat"
# read variables
bfile = matopen(filename)
# varnames = names(bfile)
A = read(bfile, "A") # note that this does NOT introduce a variable ``varname`` into scope
f = read(bfile, "f")

A1 = A[1,1]

typeof(A1)

A1["y"]

x = [1 2 ; 3 4 ; 5 6]

sortrows(x, by=x -> x[1])
