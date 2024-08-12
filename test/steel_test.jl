using StressStrainCurves

E = 29000.0
Fᵧ = 55.0
Fᵤ = 70.0

ϵₛₕ = 0.01584114727
ϵᵤ = 0.20
ϵ = [0.0; Fᵧ/ E; range(Fᵧ/ E, ϵᵤ, length=20)[2:end]]

curve = StressStrainCurves.YunGardner2017(E, Fᵧ, Fᵤ, ϵₛₕ, ϵᵤ, ϵ)

stressstrainplot(curve)

true_strain, true_stress = StressStrainCurves.calculate_true_stress_strain(curve)

