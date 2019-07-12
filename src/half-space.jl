export Halfspace

struct Halfspace{T <: Real} <: ConvexSet
    a::Vector{T},
    b::T
end

function project!(s::Halfspace{<:Real}, v::Vector{T}, y::Vector{T}) where {T <: Real}
   c = transpose(s.a)* y
  if c > s.b
    v = y -((c - s.b) / sum(abs2, s.a)) * s.a
  else
    v = y
  end
end


function project(s::Halfspace{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
