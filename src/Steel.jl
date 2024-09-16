mutable struct YunGardner2017{N, F} <: SteelStessStrainModel where {F <: AbstractFloat}
    E 
    Fᵧ
    Fᵤ  
    ϵₛₕ        
    ϵᵤ
  
    σ::StaticArrays.SVector{N, F}
    ϵ::StaticArrays.SVector{N, F}

    function YunGardner2017(E, Fᵧ, Fᵤ, ϵₛₕ, ϵᵤ, ϵ::AbstractVector{T}) where {T <: Real}      
        
        # Compute the number of stress-strain points:
        N = length(ϵ)

        # Calculate yield strain:
        ϵᵧ = Fᵧ / E

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

        end
        
        # Promote type:
        F = float(T)

        # Return the results:
        return new{N, F}(E, Fᵧ, Fᵤ, ϵₛₕ, ϵᵤ, StaticArrays.SVector{N, F}(σ), StaticArrays.SVector{N, F}(ϵ))
    end
end

mutable struct Rasmussen2003StainlessSteel{N, F} <: SteelStessStrainModel where {F <: AbstractFloat}
    E0 
    σ02
    σu
    ϵu
    n
  
    σ::StaticArrays.SVector{N, F}
    ϵ::StaticArrays.SVector{N, F}

    function Rasmussen2003StainlessSteel(E0, σ02, σu, ϵu, n, σ::AbstractVector{T}) where {T <: Real}      
        
        # Compute the number of stress-strain points:
        N = length(σ)

        # Calculate m:
        m = 1 + 3.5 * σ02 / σu

        #Calculate e:
        e = σ02 / E0

        #Calculate E02:
        E02 = E0 / (1 + 0.002 * (n / e))

        #Calculate ϵ02:
        ϵ02 = σ02 / E0 + 0.002

        # Initialize stress vector:
        ϵ = Vector{Float64}(undef, N)

        # Compute the stresses:
        for i in eachindex(ϵ)

            if σ[i] <= σ02
                ϵ[i] = σ[i] / E0 + 0.002 * (σ[i] / σ02)^n
            else
                ϵ[i] = (σ[i] - σ02) / E02 + ϵu * ((σ[i] - σ02) / (σu - σ02))^m + ϵ02
            end

        end
        
        # Promote type:
        F = float(T)

        # Return the results:
        return new{N, F}(E0, σ02, σu, ϵu, n, StaticArrays.SVector{N, F}(σ), StaticArrays.SVector{N, F}(ϵ))
    end
end


