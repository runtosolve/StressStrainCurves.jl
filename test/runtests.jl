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
    StressStrainCurveModel = Rasmussen2003(E, σ₀₂, σᵤ, n, σ)

    # TODO: Add tests here.
end

@testset "Steel: Yun and Gardner (2017)" begin 
    # Define the stress-strain curve parameters:
    E   = 29000 # ksi
    Fᵧ  = 50    # ksi
    Fᵤ  = 70    # ksi
    ϵₛₕ  = 0.05

    # Define the strains of interest:
    ϵ = collect(range(0.0, 0.05, 0.005))

    # Create the stress-strain curve:
    StressStrainCurveModel = YunGardner2017(E, Fᵧ, Fᵤ, ϵₛₕ, ϵ)

    # TODO: Add tests here.
end