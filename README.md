
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- badges: end -->
Overview
========

User-friendly and flexible algorithm for modeling, sampling, inference, and clustering heteregenous data with the Skew-Normal Mixture-of-Experts (SNMoE) model.

Installation
============

You can install the development version of SNMoE from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fchamroukhi/SNMoE")
```

To build *vignettes* for examples of usage, type the command below instead:

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

Usage
=====

``` r
library(SNMoE)
```

``` r
n <- 500 # Size of the sample
alphak <- matrix(c(0, 8), ncol = 1) # Parameters of the gating network
betak <- matrix(c(0, -2.5, 0, 2.5), ncol = 2) # Regression coefficients of the experts
lambdak <- c(3, 5) # Skewness parameters of the experts
sigmak <- c(1, 1) # Standard deviations of the experts
x <- seq.int(from = -1, to = 1, length.out = n) # Inputs (predictors)

# Generate sample of size n
sample <- sampleUnivSNMoE(alphak = alphak, betak = betak, sigmak = sigmak, 
                          lambdak = lambdak, x = x)
y <- sample$y

K <- 2 # Number of regressors/experts
p <- 1 # Order of the polynomial regression (regressors/experts)
q <- 1 # Order of the logistic regression (gating network)

n_tries <- 1
max_iter <- 1500
threshold <- 1e-6
verbose <- TRUE
verbose_IRLS <- FALSE

snmoe <- emSNMoE(X = x, Y = y, K, p, q, n_tries, max_iter, 
                 threshold, verbose, verbose_IRLS)
#> EM - SNMoE: Iteration: 1 | log-likelihood: -617.176984741056
#> EM - SNMoE: Iteration: 2 | log-likelihood: -545.010606316744
#> EM - SNMoE: Iteration: 3 | log-likelihood: -542.300382994659
#> EM - SNMoE: Iteration: 4 | log-likelihood: -541.52378465101
#> EM - SNMoE: Iteration: 5 | log-likelihood: -541.079708070694
#> EM - SNMoE: Iteration: 6 | log-likelihood: -540.681669740419
#> EM - SNMoE: Iteration: 7 | log-likelihood: -540.274240081736
#> EM - SNMoE: Iteration: 8 | log-likelihood: -539.84461140367
#> EM - SNMoE: Iteration: 9 | log-likelihood: -539.386945659006
#> EM - SNMoE: Iteration: 10 | log-likelihood: -538.896370588767
#> EM - SNMoE: Iteration: 11 | log-likelihood: -538.368338099429
#> EM - SNMoE: Iteration: 12 | log-likelihood: -537.79904110375
#> EM - SNMoE: Iteration: 13 | log-likelihood: -537.18565640038
#> EM - SNMoE: Iteration: 14 | log-likelihood: -536.526682504244
#> EM - SNMoE: Iteration: 15 | log-likelihood: -535.821978629618
#> EM - SNMoE: Iteration: 16 | log-likelihood: -535.073034024943
#> EM - SNMoE: Iteration: 17 | log-likelihood: -534.283097857261
#> EM - SNMoE: Iteration: 18 | log-likelihood: -533.456539747108
#> EM - SNMoE: Iteration: 19 | log-likelihood: -532.599542150189
#> EM - SNMoE: Iteration: 20 | log-likelihood: -531.719569593337
#> EM - SNMoE: Iteration: 21 | log-likelihood: -530.824700798245
#> EM - SNMoE: Iteration: 22 | log-likelihood: -529.923676178498
#> EM - SNMoE: Iteration: 23 | log-likelihood: -529.02533000927
#> EM - SNMoE: Iteration: 24 | log-likelihood: -528.138301263923
#> EM - SNMoE: Iteration: 25 | log-likelihood: -527.270334031851
#> EM - SNMoE: Iteration: 26 | log-likelihood: -526.42865444887
#> EM - SNMoE: Iteration: 27 | log-likelihood: -525.619025520712
#> EM - SNMoE: Iteration: 28 | log-likelihood: -524.846233848941
#> EM - SNMoE: Iteration: 29 | log-likelihood: -524.113418570202
#> EM - SNMoE: Iteration: 30 | log-likelihood: -523.42282429733
#> EM - SNMoE: Iteration: 31 | log-likelihood: -522.775606047204
#> EM - SNMoE: Iteration: 32 | log-likelihood: -522.172066350598
#> EM - SNMoE: Iteration: 33 | log-likelihood: -521.611700176245
#> EM - SNMoE: Iteration: 34 | log-likelihood: -521.093265376456
#> EM - SNMoE: Iteration: 35 | log-likelihood: -520.615352436912
#> EM - SNMoE: Iteration: 36 | log-likelihood: -520.176098928946
#> EM - SNMoE: Iteration: 37 | log-likelihood: -519.773416197998
#> EM - SNMoE: Iteration: 38 | log-likelihood: -519.405247037946
#> EM - SNMoE: Iteration: 39 | log-likelihood: -519.069349058168
#> EM - SNMoE: Iteration: 40 | log-likelihood: -518.763505267104
#> EM - SNMoE: Iteration: 41 | log-likelihood: -518.485553254024
#> EM - SNMoE: Iteration: 42 | log-likelihood: -518.233372079477
#> EM - SNMoE: Iteration: 43 | log-likelihood: -518.004921290279
#> EM - SNMoE: Iteration: 44 | log-likelihood: -517.79823736276
#> EM - SNMoE: Iteration: 45 | log-likelihood: -517.611478584926
#> EM - SNMoE: Iteration: 46 | log-likelihood: -517.442891653824
#> EM - SNMoE: Iteration: 47 | log-likelihood: -517.290849449284
#> EM - SNMoE: Iteration: 48 | log-likelihood: -517.153821351626
#> EM - SNMoE: Iteration: 49 | log-likelihood: -517.030377532269
#> EM - SNMoE: Iteration: 50 | log-likelihood: -516.919162516844
#> EM - SNMoE: Iteration: 51 | log-likelihood: -516.81893610727
#> EM - SNMoE: Iteration: 52 | log-likelihood: -516.728541823989
#> EM - SNMoE: Iteration: 53 | log-likelihood: -516.646886312831
#> EM - SNMoE: Iteration: 54 | log-likelihood: -516.572945360767
#> EM - SNMoE: Iteration: 55 | log-likelihood: -516.50585141426
#> EM - SNMoE: Iteration: 56 | log-likelihood: -516.44470978229
#> EM - SNMoE: Iteration: 57 | log-likelihood: -516.388844874088
#> EM - SNMoE: Iteration: 58 | log-likelihood: -516.337386635504
#> EM - SNMoE: Iteration: 59 | log-likelihood: -516.289633297504
#> EM - SNMoE: Iteration: 60 | log-likelihood: -516.244949393863
#> EM - SNMoE: Iteration: 61 | log-likelihood: -516.202774567538
#> EM - SNMoE: Iteration: 62 | log-likelihood: -516.162628895859
#> EM - SNMoE: Iteration: 63 | log-likelihood: -516.123911203871
#> EM - SNMoE: Iteration: 64 | log-likelihood: -516.086520639969
#> EM - SNMoE: Iteration: 65 | log-likelihood: -516.050562506529
#> EM - SNMoE: Iteration: 66 | log-likelihood: -516.01617510447
#> EM - SNMoE: Iteration: 67 | log-likelihood: -515.983541716063
#> EM - SNMoE: Iteration: 68 | log-likelihood: -515.952885470124
#> EM - SNMoE: Iteration: 69 | log-likelihood: -515.92430510596
#> EM - SNMoE: Iteration: 70 | log-likelihood: -515.89790768366
#> EM - SNMoE: Iteration: 71 | log-likelihood: -515.873590145861
#> EM - SNMoE: Iteration: 72 | log-likelihood: -515.851675747135
#> EM - SNMoE: Iteration: 73 | log-likelihood: -515.83209804926
#> EM - SNMoE: Iteration: 74 | log-likelihood: -515.814717579891
#> EM - SNMoE: Iteration: 75 | log-likelihood: -515.799319009725
#> EM - SNMoE: Iteration: 76 | log-likelihood: -515.785652953684
#> EM - SNMoE: Iteration: 77 | log-likelihood: -515.773446986333
#> EM - SNMoE: Iteration: 78 | log-likelihood: -515.762424135782
#> EM - SNMoE: Iteration: 79 | log-likelihood: -515.752314008352
#> EM - SNMoE: Iteration: 80 | log-likelihood: -515.742848408081
#> EM - SNMoE: Iteration: 81 | log-likelihood: -515.733796764114
#> EM - SNMoE: Iteration: 82 | log-likelihood: -515.724931728183
#> EM - SNMoE: Iteration: 83 | log-likelihood: -515.716048272284
#> EM - SNMoE: Iteration: 84 | log-likelihood: -515.70696522766
#> EM - SNMoE: Iteration: 85 | log-likelihood: -515.697523023751
#> EM - SNMoE: Iteration: 86 | log-likelihood: -515.68759832751
#> EM - SNMoE: Iteration: 87 | log-likelihood: -515.677111106592
#> EM - SNMoE: Iteration: 88 | log-likelihood: -515.666019498527
#> EM - SNMoE: Iteration: 89 | log-likelihood: -515.65413490818
#> EM - SNMoE: Iteration: 90 | log-likelihood: -515.641807812958
#> EM - SNMoE: Iteration: 91 | log-likelihood: -515.629081520476
#> EM - SNMoE: Iteration: 92 | log-likelihood: -515.616371646809
#> EM - SNMoE: Iteration: 93 | log-likelihood: -515.603921062018
#> EM - SNMoE: Iteration: 94 | log-likelihood: -515.591950790967
#> EM - SNMoE: Iteration: 95 | log-likelihood: -515.580655519967
#> EM - SNMoE: Iteration: 96 | log-likelihood: -515.570035191652
#> EM - SNMoE: Iteration: 97 | log-likelihood: -515.560141303248
#> EM - SNMoE: Iteration: 98 | log-likelihood: -515.551213462
#> EM - SNMoE: Iteration: 99 | log-likelihood: -515.543293169538
#> EM - SNMoE: Iteration: 100 | log-likelihood: -515.536368426565
#> EM - SNMoE: Iteration: 101 | log-likelihood: -515.530394476249
#> EM - SNMoE: Iteration: 102 | log-likelihood: -515.525301449862
#> EM - SNMoE: Iteration: 103 | log-likelihood: -515.521004554755
#> EM - SNMoE: Iteration: 104 | log-likelihood: -515.51741260236
#> EM - SNMoE: Iteration: 105 | log-likelihood: -515.514434453576
#> EM - SNMoE: Iteration: 106 | log-likelihood: -515.511982215605
#> EM - SNMoE: Iteration: 107 | log-likelihood: -515.509977935517
#> EM - SNMoE: Iteration: 108 | log-likelihood: -515.508350293957
#> EM - SNMoE: Iteration: 109 | log-likelihood: -515.507036668177
#> EM - SNMoE: Iteration: 110 | log-likelihood: -515.505982923163
#> EM - SNMoE: Iteration: 111 | log-likelihood: -515.505142736275
#> EM - SNMoE: Iteration: 112 | log-likelihood: -515.5044762153
#> EM - SNMoE: Iteration: 113 | log-likelihood: -515.503950040905
#> EM - SNMoE: Iteration: 114 | log-likelihood: -515.503537346712

snmoe$plot()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-2.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-3.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-4.png" style="display: block; margin: auto;" />
