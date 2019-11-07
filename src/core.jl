# src/core.jl
# Core Definitions

import AbstractRationals: AbstractRational, missing_api, build_ratio
import Base: +, *, fma

export BoundType,
       isnonbinding,
       isbinding,
       mostbinding,
       AbstractBoundedRational,
       bound,
       isbounded,
       resolve


"""```
const BoundType
    === Union{<:Number, Missing, Nothing}
```
"""
const BoundType = Union{<:Number,Missing,Nothing}


"""```
isnonbinding(bound::BoundType)
```
"""
function isnonbinding(bound::BoundType)::Bool
    return isinf(bound) | ismissing(bound) | isnothing(bound) | isnan(bound)
end


"""```
isbinding(bound::BoundType)
```
"""
function isbinding(bound::BoundType)::Bool
    return !isinf(bound) & !ismissing(bound) & !isnothing(bound) & !isnan(bound)
end


"""```
mostbinding(bounds::BoundType...)
```
"""
function mostbinding(bounds::BoundType...)::BoundType
    components = filter(isbinding, bounds)
    return isempty(components) ? nothing : min(components)
end


"""```
abstract type AbstractBoundedRational{T, B <: BoundType}
    <: AbstractRational{T}
```
"""
abstract type AbstractBoundedRational{T,B<:BoundType} <: AbstractRational{T} end


"""```
bound(x::AbstractBoundedRational)
```
"""
function bound(x::AbstractBoundedRational{T,B})::B where {T,B}
    missing_api("bound", x)
end


"""```
isbounded(x::AbstractBoundedRational)
    === isbinding(bound(x))
```
"""
function isbounded(x::AbstractBoundedRational)
    return isbinding(bound(x))
end


"""```
resolve(num::T, den::T, bound::B)
```
"""
function resolve(num::T, den::T, bound::B) where {T<:Integer,B<:BoundType}
    if isnonbinding(bound)
        return num, den
    end
    scaled = num * bound
    n, r = divrem(scaled, den)
    return (r <= den - r ? n : n + one(n), bound)
end


"""```
x::AbstractBoundedRational * y::AbstractBoundedRational
```
"""
function *(x::AbstractBoundedRational, y::AbstractBoundedRational)
    return build_ratio(
        typeof(x),
        resolve(
            numerator(x) * numerator(y),
            denominator(x) * denominator(y),
            mostbinding(bound(x), bound(y)),
        )...,
    )
end


"""```
x::AbstractBoundedRational + y::AbstractBoundedRational
```
"""
function +(x::AbstractBoundedRational, y::AbstractBoundedRational)
    return build_ratio(
        typeof(x),
        resolve(
            numerator(x) * denominator(y) + numerator(y) * denominator(x),
            denominator(x) * denominator(y),
            mostbinding(bound(x), bound(y)),
        )...,
    )
end


"""```
fma(x::AbstractBoundedRational, y::AbstractBoundedRational, z::AbstractBoundedRational)
```
"""
function fma(x::AbstractBoundedRational, y::AbstractBoundedRational, z::AbstractBoundedRational)
    return build_ratio(
        typeof(x),
        resolve(
            numerator(x) * numerator(y),
            denominator(x) * denominator(y),
            mostbinding(bound(x), bound(y), bound(z)),
        )...,
    )
end
