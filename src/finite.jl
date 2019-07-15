export Finite

struct Finite{T <: Real} <: ConvexSet
    x::Matrix{T}
end

function project!(s::Finite{<:Real}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    dist = Distances.colwise(Distances.SqEuclidean(), s.x, y)
    j = argmin(dist)
    v = s.x[:, j]
end

function project(s::Finite{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
