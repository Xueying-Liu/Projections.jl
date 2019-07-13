export SecondOrderCone

struct SecondOrderCone{T <: Real} <: ConvexSet
    P::Matrix{T}
    q::Vector{T}
    r::Vector{T}
    s::T  
end

function SecondOrder(y)
#
# This function projects the point y = (x,t) onto the second
# order cone {(x,t)|norm(x)<=t}.
#
   n = norm(y[1:end-1])
   if n <= y[end]
      return y
   elseif n <= -y[end]
      return zeros(size(y))
   else
      z = zeros(size(y))
      r = 0.5*(1.0+y[end]/n)
      z[end] = r*n
      z[1:end-1] = r*y[1:end-1]
      return z
   end
end

function AffineProjection(y,A,b,cached=false,C=zeros(size(A)),d=zeros(size(b)))
#
# This function projects the point y into the affine set 
# {x|Ax = b} based on the projection formula 
# z = y-pinv(A)*(A*y-b). You should call the function via
# z, C, d = AffineProjection(y1,A,b) 
# and then call it again with the new argument y2 via 
# z = AffineProjection(y2,A,b,true,C,d).
# Passing back the cached values C and d speeds up
# calculation of the projected point z.
#
   if cached
      z = C*y+d 
      return z
   else
      pA = pinv(A)
      C = eye(length(y))-pA*A
      d = pA*b
      z = C*y+d
      return (z,C,d)
   end
end

function SecondOrderCone(s::SecondOrderCone{<:Real}, v::Vector{<:Real}, z::Vector{<:Real})
#
# This function projects the point z onto the second-order cone
# constraint {x:||P*x+q||<=r'*x+s}.
#
# Initialize control constants.
#
   rho = 1.0
   rho_inc = 1.05
   rho_max = 10
   eps = 1e-14
   eps_dec = 1.2
   eps_min = 1e-14
   tol = 1e-8
   max_iter = 500
   m = size(s.P,1)
   n = size(s.P,2)
#
# Check whether the point z is already feasible.
#
   u = s.P*z + s.q
   t = s.r'*z + s.s
   if norm(u) <= t
      v = z
   end
#
# Initialize vectors and matrices.
#
   x = [z,u,t]
   y = [z,u,t]
   M = [P -eye(m) zeros(m); r' zeros(m)' -1]
   v = -[s.q,s.s]
   zx = zeros(m+n+1)
#
# Prepare to iterate.
#
   ut = SecondOrder(x[n+1:end])
   x = [x[1:n],ut]
   (y,E,f) = AffineProjection(y,M,v)
   a = sqrt(norm(z-x[1:n])^2+1.0)
   b = sqrt(norm(z-y[1:n])^2+1.0)
   loss = 0.5*(a+b)
   dist = norm(x-y)/sqrt(2.0)
   objective = loss + rho*sqrt(dist^2 + eps) 
#
# Enter the alternating projection loop.
#
   for i = 1:max_iter
      println(i-1," ",objective," ",dist," ",rho," ",eps)
#
# Project onto the second-order cone.
#
      c = 0.5/a
      w = 0.5*rho/sqrt(dist^2+eps)
      x[1:n] = (c/(c+w))*z+(w/(c+w))*y[1:n]
      ut = (c/(c+w))*x[n+1:end]+(w/(c+w))*y[n+1:end]
      x[n+1:end] = SecondOrder(ut)
#      
# Project onto the affine set.
#
      dist = norm(x-y)/sqrt(2.0) 
      d = 0.5/b      
      w = 0.5*rho/sqrt(dist^2+eps)
      zx = (d/(d+w))*[z,y[n+1:end]]+(w/(d+w))*x
      y = AffineProjection(zx,M,v,true,E,f)
#
# Update the objective.
#
      a = sqrt(norm(z-x[1:n])^2+1.0)
      b = sqrt(norm(z-y[1:n])^2+1.0)
      loss = 0.5*(a+b)
      dist = norm(x-y)/sqrt(2.0)
      next_objective = loss + rho*sqrt(dist^2 + eps) 
#
# Check for convergence.
#
      if abs(next_objective - objective)/(objective + 1.0) < tol && dist < tol
         break
      else
         rho = min(rho_inc*rho,rho_max)
         eps = max(eps/eps_dec,eps_min)
         objective = next_objective
      end
   end
   v = 0.5*(x[1:n]+y[1:n])
end

function project(s::SecondOrderCone{<:Real}, y::Vector{<:Real})
    project!(s, similar(y), y)
end
