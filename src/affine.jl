export Affine

struct Affine{T <: Real}
    A::Matrix{T}
    b::Vector{T}
end

using LinearAlgebra

function project!(s::Affine{T}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    v = y .- LinearAlgebra.pinv(s.A) * (s.A * y .- s.b)
end

function project(s::Affine{T}, y::Vector{T}) where {T <: Real}
    project!(s, similar(y), y)
end