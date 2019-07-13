export Lowrank

struct Lowrank{T <: Real} <: ConvexSet
    k::T
end
```
This function projects the matrix y onto the closest matrix of rank k or less.
```
function project!(s::Lowrank{<:Real}, v::Matrix{T}, y::Matrix{T}) where {T <: Real}
    U, S, V = LinearAlgebra.svd(y)
    Z = zeros(size(y))
    for j = 1:s.k
      Z = Z+S[j]*U[:,j]*V[:,j]'   
    end
    v = Z
end

function project(s::Lowrank{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
