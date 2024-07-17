module StressStrainCurves
# Preamble:
import StaticArrays

# Define abstract types:
abstract type StressStrainCurveModel end
abstract type SteelStressStrainCurveModel <: StressStrainCurveModel end
abstract type AluminumStressStrainCurveModel <: StressStrainCurveModel end

export StressStrainCurveModel
export SteelStressStrainCurveModel
export AluminumStressStrainCurveModel

# Include the stress-strain curve models for 
include("Aluminum.jl")
export Rasmussen2003

include("Steel.jl")
export YunGardner2017

include("MakieRecipes.jl")
export stressstrainplot
export stressstrainplot!

function calculate_true_stress(σₑ, ϵₑ)
    σₜ = σₑ * (1 + ϵₑ)

    return σₜ
end

function calculate_true_strain(ϵₑ)
    ϵₜ = log(1 + ϵₑ)

    return ϵₜ
end
end # module StressStrainCurves
