export PositiveSemidefinite

struct PositiveSemidefinite{T <: Real} <: ConvexSet
    r::T
end
PositiveSemidefinite() = PositiveSemidefinite(0.0)
```
This function projects the symmetric matrix Y onto the closest positive definite matrix.
```

function project!(s::PositiveSemidefinite{<:Real}, v::Matrix{T}, y::Matrix{T}) where {T <: Real}
   (D,V) = LinearAlgebra.eigen(y)
   X = zeros(size(y))
   for j = 1:size(y,1)
      if D[j] > 0.0
         X = X .+ V[:,j] * D[j] * V[:,j]'
      end   
   end
   v = X
end

function project(s::PositiveSemidefinite{<:Real}, y::Matrix{<:Real})
    project!(s, similar(y), y)
end
