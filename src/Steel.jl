mutable struct YunGardner2017{N, F} <: SteelStressStrainCurveModel where {F <: AbstractFloat}
    E 
    σᵧ
    σᵤ
    ϵᵧ
    ϵₛₕ        
  
    σ::StaticArrays.SVector{N, F}
    ϵ::StaticArrays.SVector{N, F}

    function YunGardner2017(E, σᵧ, σᵤ, ϵₛₕ, ϵᵤ, ϵ::AbstractVector{T}) where {T <: Real}      
        # Compute the number of stress-strain points:
        N = length(ϵ)

        # Promote type:
        F = float(T)

        # Compute the material model parameters:
        ϵᵧ = σᵧ / E

        # Initialize stress vector:
        σ = Vector{T}(undef, N)

        # Compute the stresses:
        for i in eachindex(ϵ)
            if ϵ[i] <= ϵᵧ
                σ[i] = E * ϵ[i]
            elseif (ϵ[i] > ϵᵧ) & (ϵ[i] <= ϵₛₕ)
                σ[i] = σᵧ
            elseif (ϵ[i] > ϵₛₕ) & (ϵ[i] <= ϵᵤ)
                σ[i] = σᵧ + (σᵤ - σᵧ) * (0.4 * (ϵ[i] - ϵₛₕ) / (ϵᵤ - ϵₛₕ) + (2 * (ϵ[i] - ϵₛₕ) / (ϵᵤ - ϵₛₕ)) / (1 + 400 * ((ϵ[i] - ϵₛₕ)/(ϵᵤ - ϵₛₕ)) ^ 5) ^ (1 / 5))
            else
                throw(DomainError("ϵ cannot be greater than ϵᵤ!"))
            end
        end

        # Return the results:
        return new{N, F}(E, σᵧ, σᵤ, ϵᵧ, ϵₛₕ, StaticArrays.SVector{N, F}(σ), StaticArrays.SVector{N, F}(ϵ))
    end
end