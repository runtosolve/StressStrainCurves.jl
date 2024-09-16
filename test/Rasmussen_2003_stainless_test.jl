using StressStrainCurves 

E0 = 29000000.0
ν = 0.30

σ02 = 25000.0
σu = 70000.0
ϵu = 0.50 #from Table 1, Rasmussen(2003)
n = 6  #from Table 1, Rasmussen(2003)

σ = [0.0; σ02; range(σ02, σu, length=20)[2:end]]

curve = StressStrainCurves.Rasmussen2003StainlessSteel(E0, σ02, σu, ϵu, n, σ)

stressstrainplot(curve)