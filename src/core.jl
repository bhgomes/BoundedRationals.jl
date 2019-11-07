# src/core.jl
# Core Definitions

import AbstractRationals: AbstractRational

export BoundedRational


"""```
```
"""
struct BoundedRational{T, M<:Integer} <: AbstractRational{T}
    num::T
    den::T
    maxden::M
end


"""```
```
"""
numerator(x::BoundedRational) = x.num


"""```
```
"""
denominator(x::BoundedRational) = x.den


"""```
```
"""
maxden(x::BoundedRational) = x.maxden

