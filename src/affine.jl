export Affine

struct Affine{T <: Real} <: ConvexSet
    A::Matrix{T}
    b::Vector{T}
end

function project!(s::Affine{T}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    
    pA = pinv(s.A)
    v .= y. - pA*(s.A * y. - s.b)
end

function project(s::Affine{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end