using StressStrainCurves, CairoMakie

E   = 28000.0 # ksi
n   = 7.0
σ₀₂ = 130.0   # ksi
σᵤ  = 150.0   # ksi

σ = collect(range(σ_02, σ_u, 20))

properties = StressStrainCurves.Rasmussen2003Aluminum(E, σ_02, σ_u, n, σ)

scatter(properties.ϵ, properties.σ)