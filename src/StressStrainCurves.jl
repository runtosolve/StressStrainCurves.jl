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


function calculate_true_stress(engineering_stress, engineering_strain)

    true_stress = engineering_stress * (1 + engineering_strain)

end

function calculate_true_strain(engineering_strain)

    true_strain = log(1 + engineering_strain)

end


end # module StressStrainCurves
