export Stiefel

struct Stiefel{T <: Real} <: ConvexSet
    r::T
end
Stiefel() = Stiefel(0.0)

function project!(s::Stiefel{<:Real}, v::Matrix{T}, y::Matrix{T}) where {T <: Real}
    U, S, V = LinearAlgebra.svd(y)
    v = U*V'
end

function project(s::Simplex{<:Real}, y::Matrix{<:Real})
    project!(s, similar(y), y)
end
