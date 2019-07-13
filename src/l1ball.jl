export L1ball

struct L1ball{T <: Real} <: ConvexSet
    radius::T
    center::Vector{T}
end

function project!(s::L1ball{T}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    n = length(y)
    z = sum(abs, y-s.center)
   if z <= s.radius
      v = y
   else
      w = project(Projections.Simplex(s.radius),y)
      sgn = zeros(n)
      d = y-s.center
      for i in 1:n
            if d[i] > 0
                sgn[i] = 1
            elseif d[i] == 0
                sgn[i] = 0
            else
                sgn[i] = -1
            end
      end
        v = s.center .+ sgn. * w 
   end
end

function project(s::L1ball{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
