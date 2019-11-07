# src/BoundedRationals.jl
# Rational Numbers with Bounded Denominators

__precompile__(true)

"""```
module BoundedRationals
```
Rational Numbers with Bounded Denominators
See https://github.com/bhgomes/BoundedRationals.jl for more details.
"""
module BoundedRationals

include("core.jl")
include("impl.jl")

end  # module BoundedRationals
