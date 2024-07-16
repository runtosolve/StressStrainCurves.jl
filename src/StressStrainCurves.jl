module StressStrainCurves
# Preamble:
import StaticArrays

# Define abstract types:
abstract type StressStrainModel end
abstract type SteelStessStrainModel <: StressStrainModel end
abstract type AluminumStessStrainModel <: StressStrainModel end

export StressStrainModel
export SteelStressStrainModel
export AluminumStressStrainModel

# Include the stress-strain curve models for 
include("Aluminum.jl")
export Rasmussen2003

include("Steel.jl")
export YunGardner2017

include("MakieRecipes.jl")
export stressstrainplot
export stressstrainplot!


function calculate_true_stress(engineering_stress, engineering_strain)

    true_stress = engineering_stress * (1 + engineering_strain)

end

function calculate_true_strain(engineering_strain)

    true_strain = log(1 + engineering_strain)

end


end # module StressStrainCurves
