export Finite

struct Finite{T <: Real} <: ConvexSet
    x::Matrix{T}
end

using Distances, LinearAlgebra
function project!(s::Finite{<:Real}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    dist = LinearAlgebra.colwise(Distances.SqEuclidean(), s.x, y)
    j = argmin(dist)
    v = x[:, j]
end

function project(s::Finite{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
