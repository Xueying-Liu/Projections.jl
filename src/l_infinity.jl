export L_infinity

struct L_infinity{T <: Real} <: ConvexSet
    center::Vector{T}
    radius::T    
end
"""
    
    L_infinityball(c, r)

A ball with center `c` and radius `r`.
"""

function project!(s::L_infinity{<:Real}, v::Vector{T}, y::Vector{T}) where {T <: Real}
     x = y-s.center
   if maximum(abs(x)) <= s.radius
      v = y
   else
      x = max(min(x,s.radius), -s.radius)
      v = x .+ s.center
   end
end

function project(s::L_infinity{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end