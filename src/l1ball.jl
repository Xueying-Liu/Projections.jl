export L1ball

struct L1ball{T <: Real} <: ConvexSet
    radius::T
    center::Vector{T}
end
Simplex() = Simplex(1.0)

function project!(s::L1ball{T}, v::Vector{T}, y::Vector{T}) where {T <: Real}
    z = sum(abs, y-s.center)
   if z <= s.radius
      v = y
   else
      p = project(Simplex(s.radius),y)
      v = s.center+sign(y-s.center).*p
   end
end

function project(s::L1ball{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
