export Affine

struct Affine{T <: Real} <: ConvexSet
    A::Matrix{T}
    b::Vector{T}
end

function project!(s::Affine{T}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    C = zeros(size(s.A))
    d = zeros(size(s.b))
    pA = pinv(s.A)
    C =  I - pA * s.A
    d = pA * b
    v .= C * y + d
end

function project(s::Affine{A,b}, y::Vector{<:Real})
    project!(s, similar(y), y)
end