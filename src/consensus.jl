export Simplex

struct Consensus{T <: Real} <: ConvexSet
    
end

function project!(s::Consensus{<:Real}, v::Vector{T}, y::Matrix{T}) where {T <: Real}
  return repeat(mean(Y, dims = 2), inner = [1, size(Y, 2)])
end


function project(s::Simplex{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
