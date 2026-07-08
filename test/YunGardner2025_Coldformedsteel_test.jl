using StressStrainCurves
using CairoMakie

E = 29500.0
Fᵧ = 50.0
Fᵤ = 65.0

# ϵₛₕ and ϵᵤ are computed internally from E, Fᵧ, Fᵤ, so they are calculated here
# (matching the formulas in Steel.jl) only to size the ϵ range.
ϵₛₕ = min(max((0.1 * (Fᵧ / Fᵤ)) - 0.055, 0.015), 0.03)
ϵᵤ = (1 + (Fᵧ / (0.0008 * E)))^(-1.65)
ϵ = [0.0; Fᵧ / E; range(Fᵧ / E, ϵᵤ, length=20)[2:end]]

curve = StressStrainCurves.YunGardner2025_ColdformedSteel(E, Fᵧ, Fᵤ, ϵ)

@assert curve.ϵₛₕ ≈ ϵₛₕ
@assert curve.ϵᵤ ≈ ϵᵤ

stressstrainplot(curve)

true_strain, true_stress = StressStrainCurves.calculate_true_stress_strain(curve)
