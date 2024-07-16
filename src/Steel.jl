mutable struct YunGardner2017{N, F} <: SteelStessStrainCurveModel where {F <: AbstractFloat}
    E 
    Fᵧ
    Fᵤ  
    ϵₛₕ        
  
    σ::StaticArrays.SVector{N, F}
    ϵ::StaticArrays.SVector{N, F}

    function YunGardner2017(E, Fᵧ, Fᵤ, ϵₛₕ, ϵ::AbstractVector{T}) where {T <: Real}      
        
        # Compute the number of stress-strain points:
        N = length(ϵ)

        # Initialize stress vector:
        σ = Vector{Float64}(undef, N)

        # Compute the stresses:
        for i in eachindex(ϵ)

            if ϵ[i] <= ϵᵧ
                σ[i] = E * ϵ[i]
            elseif (ϵ[i] > ϵᵧ) & (ϵ[i] <= ϵₛₕ)
                σ[i] = Fᵧ
            elseif (ϵ[i] > ϵₛₕ) & (ϵ[i] <= ϵᵤ)
                σ[i] = Fᵧ + (Fᵤ - Fᵧ) * (0.4(ϵ[i] - ϵₛₕ)/(ϵᵤ - ϵₛₕ) + (2(ϵ[i] - ϵₛₕ)/(ϵᵤ - ϵₛₕ))/(1 + 400((ϵ[i] - ϵₛₕ)/(ϵᵤ - ϵₛₕ))^5)^(1/5))
            else
                error("The strain ϵ cannot be greater than ϵᵤ.")
            end
        
        # Promote type:
        F = float(T)

        # Return the results:
        return new{N, F}(E, Fᵧ, Fᵤ, ϵ₀₂, ϵₛₕ, StaticArrays.SVector{N, F}(σ), StaticArrays.SVector{N, F}(ϵ))
    end
end

