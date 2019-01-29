var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Projections.jl",
    "title": "Projections.jl",
    "category": "page",
    "text": ""
},

{
    "location": "#Projections.jl-1",
    "page": "Projections.jl",
    "title": "Projections.jl",
    "category": "section",
    "text": "Projections.jl is a Julia package that collects commonly used projection operators. It is useful for optimization algorithms such as projected gradient descent.Given a point y in mathbbR^n and a set S subset mathbbR^n, the projection of y onto S is defined as $     \\text{proj}S(y) = \\arg \\min{x \\in S} \\|y - x\\|2^2. $ If S is a closed convex set, then \\text{proj}S(y)$ is unique."
},

{
    "location": "#Installation-1",
    "page": "Projections.jl",
    "title": "Installation",
    "category": "section",
    "text": "This package requires Julia v0.7 or later. The package has not yet been registered and must be installed using the repository location. Start julia and use the ] key to switch to the package manager REPL(v1.0) pkg> add https://github.com/Hua-Zhou/Projections.jl.gitMachine information for this tutorialversioninfo()Julia Version 1.0.3\nCommit 099e826241 (2018-12-18 01:34 UTC)\nPlatform Info:\n  OS: macOS (x86_64-apple-darwin14.5.0)\n  CPU: Intel(R) Core(TM) i7-6920HQ CPU @ 2.90GHz\n  WORD_SIZE: 64\n  LIBM: libopenlibm\n  LLVM: libLLVM-6.0.0 (ORCJIT, skylake)\nEnvironment:\n  JULIA_EDITOR = code"
},

{
    "location": "#Basic-usage-1",
    "page": "Projections.jl",
    "title": "Basic usage",
    "category": "section",
    "text": "This package provides two functions for a set s,project!(s, v, y)overwrites v by projection of y to set s. project(s, y)simply returns projection of y to set s."
},

{
    "location": "#Projection-operators-1",
    "page": "Projections.jl",
    "title": "Projection operators",
    "category": "section",
    "text": "using Projections"
},

{
    "location": "#Box-1",
    "page": "Projections.jl",
    "title": "Box",
    "category": "section",
    "text": "Projection of y onto a closed box S = a_1 b_1 times cdots times a_n b_n is $     \\text{proj}S(y)i = \\begin{cases}     ai & yi < ai \\\n    yi & yi \\in [ai, bi] \\\n    bi & yi > bi     \\end{cases}. $y = [-2.5, -1.5, -0.5, 0.0, 0.5, 1.5, 2.5]\na = fill(-1.0, 7) # vector of all -1\nb = fill( 1.0, 7) # vector of all  1\nproject(Box(a, b), y)7-element Array{Float64,1}:\n -1.0\n -1.0\n -0.5\n  0.0\n  0.5\n  1.0\n  1.0"
},

{
    "location": "#Contributing-1",
    "page": "Projections.jl",
    "title": "Contributing",
    "category": "section",
    "text": "You are welcome to contribute to the Projections.jl package. To add a projection operator, e.g., projection to the affine set, to the package, follow these steps:Fork the Projections.jl package.  \nAdd affine.jl to the src folder that implements the type Affine, the function project!(s::Affine, v, y), and the function project(s, y). \nAdd a line include(\"affine.jl\") to the /src/Projections.jl file.\nAdd test file affine_test.jl to the test folder.\nAdd a line include(\"affine_test.jl\") to the /test/runtests.jl file.  \nMake sure that Pkg.test(\"Projections\") successfully runs.\nAdd documentation for the new projection operator to the Projection operators section of Jupyter notebook /docs/Projections.jl. \nIssue a pull request."
},

]}
