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
    n = length(y)
    d = y-s.center
   if maximum(abs,d) <= s.radius
      v = y
   else
      sgn = zeros(n)
      for i in 1:n
            if d[i] > 0
                sgn[i] = 1
            elseif d[i] == 0
                sgn[i] = 0
            else
                sgn[i] = -1
            end
      end  
      v = s.center .+ s.radius.* sgn
   end
end

function project(s::L_infinity{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
