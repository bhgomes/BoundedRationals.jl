# src/impl.jl
# Implementation of a Bounded Rational type

export BoundedRational


"""```
struct BoundedRational{T,B}
    <: AbstractBoundedRational{T,B}
```
"""
struct BoundedRational{T,B} <: AbstractBoundedRational{T,B}
    num::T
    den::T
    bound::B
end


"""```
build_ratio(::Type{BoundedRational{T,B}}, num, den, bound::B = nothing)
```
"""
function build_ratio(::Type{BoundedRational{T,B}}, num, den, bound::B = nothing) where {T,B}
    return BoundedRational(num, den, bound)
end


"""```
numerator(x::BoundedRational)
    === x.num
```
"""
numerator(x::BoundedRational) = x.num


"""```
denominator(x::BoundedRational)
    === x.den
```
"""
denominator(x::BoundedRational) = x.den


"""```
bound(x::BoundedRational)
    === x.bound
```
"""
bound(x::BoundedRational) = x.bound
