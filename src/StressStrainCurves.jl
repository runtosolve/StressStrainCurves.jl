module StressStrainCurves
# Preamble:
import StaticArrays

# Define abstract types:
abstract type StressStrainCurveModel end
abstract type SteelStessStrainCurveModel <: StressStrainCurveModel end
abstract type AluminumStessStrainCurveModel <: StressStrainCurveModel end

export StressStrainCurveModel
export SteelStessStrainCurveModel
export AluminumStessStrainCurveModel

# Include the stress-strain curve models for 
include("Aluminum.jl")
export Rasmussen2003

include("MakieRecipes.jl")
export stressstraincurveplot
export stressstraincurveplot!
end
