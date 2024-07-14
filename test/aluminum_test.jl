using StressStrainCurves


E = 30000.0 #ksi
n = 7.0
σ_02 = 130.0 #ksi
σ_u = 150.0 #ksi

σ = collect(range(σ_02, σ_u, 20))


properties = StressStrainCurves.Rasmussen2003Aluminum(E, σ_02, σ_u, n, σ)
