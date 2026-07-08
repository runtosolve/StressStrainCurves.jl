import Makie

Makie.@recipe(StressStrainPlot, StressStrainCurve) do scene
    Makie.Attributes(
        color       = :black,
        marker      = :circle,
        markersize  = 6,
        strokecolor = :black,
        strokewidth = 0)
end

function Makie.plot!(P::StressStrainPlot)
    # Extract the stress-strain curve model:
    SSCM = P[:StressStrainCurve]
    σ = Vector(SSCM[].σ)
    ϵ = Vector(SSCM[].ϵ)

    # Create the plot:
    Makie.lines!(P, ϵ, σ,
        color = P[:color])

    Makie.scatter!(P, ϵ, σ,
        color       = P[:color],
        marker      = P[:marker],
        markersize  = P[:markersize],
        strokecolor = P[:strokecolor],
        strokewidth = P[:strokewidth])

    # Return the plot:
    return P
end