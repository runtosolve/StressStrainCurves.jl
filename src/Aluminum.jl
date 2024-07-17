mutable struct Rasmussen2003{N, F} <: AluminumStressStrainCurveModel where {F <: AbstractFloat}
    E  
    E₀₂
    σ₀₂
    ϵ₀₂
    σᵤ 
    ϵᵤ 
    n  
    m

    σ::StaticArrays.SVector{N, F}
    ϵ::StaticArrays.SVector{N, F}

    function Rasmussen2003(E, σ₀₂, σᵤ, n, σ::AbstractVector{T}) where {T <: Real}
        # Compute the number of stress-strain points:
        N = length(σ)

        # Promote type:
        F = float(T)

        # Compute the material model parameters:
        E₀₂ = E / (1 + 0.002 * n * (E / σ₀₂))
        ϵ₀₂ = σ₀₂ / E
        ϵᵤ  = 1 - σ₀₂ / σᵤ
        m   = 1 + 3.5 * σ₀₂ / σᵤ

        # Compute the strains:
        ϵ = (σ .- σ₀₂) ./ E₀₂ .+ ϵᵤ .* ((σ .- σ₀₂) ./ (σᵤ - σ₀₂)) .^ m .+ ϵ₀₂

        # Return the results:
        return new{N, F}(E, E₀₂, σ₀₂, ϵ₀₂, σᵤ, ϵᵤ, n, m, StaticArrays.SVector{N, F}(σ), StaticArrays.SVector{N, F}(ϵ))
    end
end

