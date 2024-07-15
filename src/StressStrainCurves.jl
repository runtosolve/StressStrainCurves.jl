module StressStrainCurves

using Parameters


abstract type StressStrainModel end


@with_kw struct Rasmussen2003Aluminum <: StressStrainModel
    
    E::Float64
    σ_02::Float64
    ϵ_02::Float64
    E_02::Float64
    σ_u::Float64
    ϵ_u::Float64
    n::Float64
    m::Float64
    σ::Vector{Float64}
    ϵ::Vector{Float64}

    function Rasmussen2003Aluminum(E::Float64, σ_02::Float64, σ_u::Float64, n::Float64, σ::Vector{Float64})

        E_02 = E / (1 + 0.002n * (E / σ_02))

        ϵ_02 = σ_02 / E 

        m = 1 + 3.5 * σ_02 / σ_u

        ϵ_u = 1 - σ_02 / σ_u

        ϵ = (σ .- σ_02) ./ E_02 .+ ϵ_u .* ((σ .- σ_02) ./ (σ_u - σ_02)).^m .+ ϵ_02
      
        return new(E, σ_02, ϵ_02, E_02, σ_u, ϵ_u, n, m, σ, ϵ)

    end    
    

end

function calculate_true_stress(engineering_stress, engineering_strain)

    true_stress = engineering_stress * (1 + engineering_strain)

end

function calculate_true_strain(engineering_strain)

    true_strain = log(1 + engineering_strain)

end


end # module StressStrainCurves
