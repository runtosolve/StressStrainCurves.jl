import MakieCore

MakieCore.@recipe(StressStrainPlot, StressStrainCurve) do scene
    MakieCore.Attributes(
        color       = :black,
        marker      = :circle,
        markersize  = 6,
        strokecolor = :black,
        strokewidth = 0)
end

function MakieCore.plot!(P::StressStrainPlot)
    # Extract the stress-strain curve model:
    SSCM = P[:StressStrainCurve]
    σ = Vector(SSCM[].σ)
    ϵ = Vector(SSCM[].ϵ)

    # Create the plot:
    MakieCore.lines!(P, ϵ, σ, 
        color = P[:color])

    MakieCore.scatter!(P, ϵ, σ, 
        color       = P[:color],
        marker      = P[:marker],
        markersize  = P[:markersize],
        strokecolor = P[:strokecolor],
        strokewidth = P[:strokewidth])

    # Return the plot:
    return P
end