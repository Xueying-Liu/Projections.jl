__precompile__()

module Projections

export project, project!

abstract type ConvexSet end
abstract type NonconvexSet end

"""
    project!(s, v, y)

Overwrite `v` by projection of point `y` to the box set `b`. 
"""
function project!(); end

"""
    project(s, y)

Project point `y` to the box set `b`. 
"""
function project(); end

include("box.jl")
include("ball.jl")
include("simplex.jl")
include("affine.jl")
include("consensus.jl")
include("finite.jl")
include("half-space.jl")
end
