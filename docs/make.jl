# docs/make.jl
# Make Documentation for BoundedRationals.jl

push!(LOAD_PATH, "../src/")

using Documenter, BoundedRationals

makedocs(
    modules   = [BoundedRationals],
    doctest   = true,
    clean     = false,
    linkcheck = false,
    format    = Documenter.HTML(prettyurls=!("local" in ARGS)),
    sitename  = "BoundedRationals.jl",
    authors   = "Brandon H Gomes",
    pages     = [
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "github.com/bhgomes/BoundedRationals.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
