export Simplex

struct Consensus{T <: Real} 
    
end

function project!(s::Consensus{<:Real}, v::Matrix{T}, y::Matrix{T}) where {T <: Real}
  return repeat(mean(Y, dims = 2), inner = [1, size(Y, 2)])
end


function project(s::Consensus{<:Real}, y::Matrix{<:Real})
    project!(s, similar(y), y)
end
