FittedSNMoE <- setRefClass(
  "FittedSNMoE",
  fields = list(
    modelSNMoE = "ModelSNMoE",
    paramSNMoE = "ParamSNMoE",
    statSNMoE = "StatSNMoE"
  ),
  methods = list(
    plot = function() {

      oldpar <- par()[c("mfrow", "mai", "mgp")]
      on.exit(par(oldpar), add = TRUE)

      plot.default(modelSNMoE$X, modelSNMoE$Y, ylab = "y", xlab = "x", cex = 0.7, pch = 3)
      title(main = "Estimated mean and experts")
      for (k in 1:modelSNMoE$K) {
        lines(modelSNMoE$X, statSNMoE$Ey_k[, k], col = "red", lty = "dotted", lwd = 1.5)
      }
      lines(modelSNMoE$X, statSNMoE$Ey, col = "red", lwd = 1.5)


      colorsvec = rainbow(modelSNMoE$K)
      plot.default(modelSNMoE$X, statSNMoE$piik[, 1], type = "l", xlab = "x", ylab = "Mixing probabilities", col = colorsvec[1])
      title(main = "Mixing probabilities")
      for (k in 2:modelSNMoE$K) {
        lines(modelSNMoE$X, statSNMoE$piik[, k], col = colorsvec[k])
      }

      # Data, Estimated mean functions and 2*sigma confidence regions
      plot.default(modelSNMoE$X, modelSNMoE$Y, ylab = "y", xlab = "x", cex = 0.7, pch = 3)
      title(main = "Estimated mean and confidence regions")
      lines(modelSNMoE$X, statSNMoE$Ey, col = "red", lwd = 1.5)
      lines(modelSNMoE$X, statSNMoE$Ey - 2 * sqrt(statSNMoE$Vary), col = "red", lty = "dotted", lwd = 1.5)
      lines(modelSNMoE$X, statSNMoE$Ey + 2 * sqrt(statSNMoE$Vary), col = "red", lty = "dotted", lwd = 1.5)

      # Obtained partition
      plot.default(modelSNMoE$X, modelSNMoE$Y, ylab = "y", xlab = "x", cex = 0.7, pch = 3)
      title(main = "Estimated experts and clusters")
      for (k in 1:modelSNMoE$K) {
        lines(modelSNMoE$X, statSNMoE$Ey_k[, k], col = colorsvec[k], lty = "dotted", lwd = 1.5)
      }
      for (k in 1:modelSNMoE$K) {
        index <- statSNMoE$klas == k
        points(modelSNMoE$X[, index], modelSNMoE$Y[index, ], col = colorsvec[k], cex = 0.7, pch = 3)
      }

      # Observed data log-likelihood
      plot.default(unlist(statSNMoE$stored_loglik), type = "l", col = "blue", xlab = "EM iteration number", ylab = "Observed data log-likelihood")
      title(main = "Log-Likelihood")

    }
  )
)

FittedSNMoE <- function(modelSNMoE, paramSNMoE, statSNMoE) {
  new("FittedSNMoE", modelSNMoE = modelSNMoE, paramSNMoE = paramSNMoE, statSNMoE = statSNMoE)
}
