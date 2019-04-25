FittedSNMoE <- setRefClass(
  "FittedSNMoE",
  fields = list(
    modelSNMoE = "ModelSNMoE",
    paramSNMoE = "ParamSNMoE",
    statSNMoE = "StatSNMoE"
  ),
  methods = list(
    plot = function() {
      plot.default(modelSNMoE$X, modelSNMoE$Y, pch = "+", ylab = "y", xlab = "x")
      for (k in 1:modelSNMoE$K) {
        lines(modelSNMoE$X, statSNMoE$Ey_k[, k], lty = "dotted", col = "red")
      }
      lines(modelSNMoE$X, statSNMoE$Ey, lwd = 2, col = "red")


      couleur = rainbow(modelSNMoE$K)
      plot.default(modelSNMoE$X, statSNMoE$piik[, 1], type = "l", ylab = "Mixing probabilities", xlab = "x", col = couleur[1])
      for (k in 2:modelSNMoE$K) {
        lines(modelSNMoE$X, statSNMoE$piik[, k], col = couleur[k])
      }

    }
  )
)

FittedSNMoE <- function(modelSNMoE, paramSNMoE, statSNMoE) {
  new("FittedSNMoE", modelSNMoE = modelSNMoE, paramSNMoE = paramSNMoE, statSNMoE = statSNMoE)
}
