export Consensus

struct Consensus{T <: Real} 
    index::T
end

Consensus() = Consensus(0.0)

using Statistics
function project!(s::Consensus{<:Real}, v::Matrix{T}, y::Matrix{T}) where {T <: Real}
  v = repeat(Statistics.mean(y, dims = 2), inner = [1, size(y, 2)])
end


function project(s::Consensus{<:Real}, y::Matrix{<:Real})
    project!(s, similar(y), y)
end
