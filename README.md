
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

<!-- badges: end -->

# Overview

User-friendly and flexible algorithm for modeling, sampling, inference,
and clustering heteregenous data with the Skew-Normal Mixture-of-Experts
(SNMoE) model.

# Installation

You can install the development version of SNMoE from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fchamroukhi/SNMoE")
```

To build *vignettes* for examples of usage, type the command below
instead:

``` r
# install.packages("devtools")
devtools::install_github("fchamroukhi/SNMoE", 
                         build_opts = c("--no-resave-data", "--no-manual"), 
                         build_vignettes = TRUE)
```

Use the following command to display vignettes:

``` r
browseVignettes("SNMoE")
```

# Usage

``` r
library(SNMoE)
```

``` r
n <- 500 # Size of the sample
K <- 2 # Number of regressors/experts
p <- 1 # Order of the polynomial regression (regressors/experts)
q <- 1 # Order of the logistic regression (gating network)

alphak <- matrix(c(0, 8), ncol = K - 1) # Parameters of the gating network
betak <- matrix(c(0, -2.5, 0, 2.5), ncol = K) # Regression coefficients of the experts
lambdak <- c(3, 5) # Skewness parameters of the experts
sigmak <- c(1, 1) # Standard deviations of the experts
x <- seq.int(from = -1, to = 1, length.out = n) # Inputs (predictors)

# Generate sample of size n
sample <- sampleUnivSNMoE(alphak = alphak, betak = betak, sigmak = sigmak, 
                          lambdak = lambdak, x = x)

n_tries <- 1
max_iter = 1500
threshold <- 1e-6
verbose <- TRUE
verbose_IRLS <- FALSE

snmoe <- emSNMoE(x, matrix(sample$y), K, p, q, n_tries, max_iter, 
                 threshold, verbose, verbose_IRLS)
#> EM - SNMoE: Iteration: 1 | log-likelihood: -756.406704414594
#> EM - SNMoE: Iteration: 2 | log-likelihood: -539.912549465592
#> EM - SNMoE: Iteration: 3 | log-likelihood: -533.058241209105
#> EM - SNMoE: Iteration: 4 | log-likelihood: -530.559437749328
#> EM - SNMoE: Iteration: 5 | log-likelihood: -529.735071665298
#> EM - SNMoE: Iteration: 6 | log-likelihood: -529.461074531174
#> EM - SNMoE: Iteration: 7 | log-likelihood: -529.362769791508
#> EM - SNMoE: Iteration: 8 | log-likelihood: -529.323559028377
#> EM - SNMoE: Iteration: 9 | log-likelihood: -529.305802030714
#> EM - SNMoE: Iteration: 10 | log-likelihood: -529.29639511888
#> EM - SNMoE: Iteration: 11 | log-likelihood: -529.290423451422
#> EM - SNMoE: Iteration: 12 | log-likelihood: -529.285938346495
#> EM - SNMoE: Iteration: 13 | log-likelihood: -529.282140905117
#> EM - SNMoE: Iteration: 14 | log-likelihood: -529.278698389666
#> EM - SNMoE: Iteration: 15 | log-likelihood: -529.275471417484
#> EM - SNMoE: Iteration: 16 | log-likelihood: -529.272394308284
#> EM - SNMoE: Iteration: 17 | log-likelihood: -529.269445683551
#> EM - SNMoE: Iteration: 18 | log-likelihood: -529.266623130042
#> EM - SNMoE: Iteration: 19 | log-likelihood: -529.263914620081
#> EM - SNMoE: Iteration: 20 | log-likelihood: -529.261318145458
#> EM - SNMoE: Iteration: 21 | log-likelihood: -529.258820318083
#> EM - SNMoE: Iteration: 22 | log-likelihood: -529.256420451802
#> EM - SNMoE: Iteration: 23 | log-likelihood: -529.254114236446
#> EM - SNMoE: Iteration: 24 | log-likelihood: -529.251897488365
#> EM - SNMoE: Iteration: 25 | log-likelihood: -529.249766171016
#> EM - SNMoE: Iteration: 26 | log-likelihood: -529.247716421153
#> EM - SNMoE: Iteration: 27 | log-likelihood: -529.245744563614
#> EM - SNMoE: Iteration: 28 | log-likelihood: -529.243847115781
#> EM - SNMoE: Iteration: 29 | log-likelihood: -529.242020784524
#> EM - SNMoE: Iteration: 30 | log-likelihood: -529.24026245836
#> EM - SNMoE: Iteration: 31 | log-likelihood: -529.238569196959
#> EM - SNMoE: Iteration: 32 | log-likelihood: -529.236938219475
#> EM - SNMoE: Iteration: 33 | log-likelihood: -529.235371179224
#> EM - SNMoE: Iteration: 34 | log-likelihood: -529.233863908763
#> EM - SNMoE: Iteration: 35 | log-likelihood: -529.232404697978
#> EM - SNMoE: Iteration: 36 | log-likelihood: -529.230997970859
#> EM - SNMoE: Iteration: 37 | log-likelihood: -529.229641743828
#> EM - SNMoE: Iteration: 38 | log-likelihood: -529.228334131841
#> EM - SNMoE: Iteration: 39 | log-likelihood: -529.227073320331
#> EM - SNMoE: Iteration: 40 | log-likelihood: -529.225857563319
#> EM - SNMoE: Iteration: 41 | log-likelihood: -529.224685179219
#> EM - SNMoE: Iteration: 42 | log-likelihood: -529.223545747912
#> EM - SNMoE: Iteration: 43 | log-likelihood: -529.222432325722
#> EM - SNMoE: Iteration: 44 | log-likelihood: -529.221357750066
#> EM - SNMoE: Iteration: 45 | log-likelihood: -529.220320908153
#> EM - SNMoE: Iteration: 46 | log-likelihood: -529.219320604181
#> EM - SNMoE: Iteration: 47 | log-likelihood: -529.218354867989
#> EM - SNMoE: Iteration: 48 | log-likelihood: -529.217420971796
#> EM - SNMoE: Iteration: 49 | log-likelihood: -529.216517168716
#> EM - SNMoE: Iteration: 50 | log-likelihood: -529.215642237615
#> EM - SNMoE: Iteration: 51 | log-likelihood: -529.214795029579
#> EM - SNMoE: Iteration: 52 | log-likelihood: -529.213974458604
#> EM - SNMoE: Iteration: 53 | log-likelihood: -529.213179494145
#> EM - SNMoE: Iteration: 54 | log-likelihood: -529.212409155757
#> EM - SNMoE: Iteration: 55 | log-likelihood: -529.21166250902
#> EM - SNMoE: Iteration: 56 | log-likelihood: -529.210938662295
#> EM - SNMoE: Iteration: 57 | log-likelihood: -529.210236764016
#> EM - SNMoE: Iteration: 58 | log-likelihood: -529.209556000345
#> EM - SNMoE: Iteration: 59 | log-likelihood: -529.208895593093
#> EM - SNMoE: Iteration: 60 | log-likelihood: -529.208254797832
#> EM - SNMoE: Iteration: 61 | log-likelihood: -529.207632902158
#> EM - SNMoE: Iteration: 62 | log-likelihood: -529.207029190693
#> EM - SNMoE: Iteration: 63 | log-likelihood: -529.206442793831
#> EM - SNMoE: Iteration: 64 | log-likelihood: -529.205872830058
#> EM - SNMoE: Iteration: 65 | log-likelihood: -529.205318741571
#> EM - SNMoE: Iteration: 66 | log-likelihood: -529.204779994712
#> EM - SNMoE: Iteration: 67 | log-likelihood: -529.204256079008

snmoe$plot()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-2.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-3.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-4.png" style="display: block; margin: auto;" />
