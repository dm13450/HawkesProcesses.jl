using Pkg
pkg"activate .."
push!(LOAD_PATH,"../src/")

using Documenter
using HawkesProcesses

const PAGES = Any[
    "Home" => "index.md",
    "Simulating" => "simulating.md",
    "Inference" => "inference.md",
    "Model Checking" => "modelchecking.md"
]


makedocs(
    sitename = "HawkesProcesses",
    authors = "Dean Markwick",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    modules = [HawkesProcesses],
    pages = PAGES
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/dm13450/HawkesProcesses.jl.git"
)
