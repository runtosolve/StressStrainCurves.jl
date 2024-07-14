# Preamble:
using StressStrainCurves
using Test

@testset "Aluminum: Rasmussen (2003)" begin 
    # Define the stress-strain curve parameters:
    E   = 30000 # ksi
    σ₀₂ = 130   # ksi
    σᵤ  = 150   # ksi
    n   = 7

    # Define the stresses of interest:
    σ = collect(range(σ₀₂, σᵤ, 20)) # ksi

    # Create the stress-strain curve:
    Material = Rasmussen2003(E, σ₀₂, σᵤ, n, σ)

    # TODO: Add tests here.
end