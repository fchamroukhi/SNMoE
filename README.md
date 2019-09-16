
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- badges: end -->
Overview
========

**SNMoE** (Skew-Normal Mixtures-of-Experts) provides a flexible modelling framework for heterogenous data with possibly skewed distributions to generalize the standard Normal mixture of expert model. **SNMoE** consists of a mixture of *K* skew-Normal expert regressors network (of degree *p*) gated by a softmax gating network (of degree *q*) and is represented by:

-   The gating network parameters `alpha`'s of the softmax net.
-   The experts network parameters: The location parameters (regression coefficients) `beta`'s, scale parameters `sigma`'s, and the skewness parameters `lambda`'s. **SNMoE** thus generalises mixtures of (normal, skew-normal) distributions and mixtures of regressions with these distributions. For example, when *q* = 0, we retrieve mixtures of (skew-normal, or normal) regressions, and when both *p* = 0 and *q* = 0, it is a mixture of (skew-normal, or normal) distributions. It also reduces to the standard (normal, skew-normal) distribution when we only use a single expert (*K* = 1).

Model estimation/learning is performed by a dedicated expectation conditional maximization (ECM) algorithm by maximizing the observed data log-likelihood. We provide simulated examples to illustrate the use of the model in model-based clustering of heterogeneous regression data and in fitting non-linear regression functions.

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
# Application to a simulated data set

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
#> EM - SNMoE: Iteration: 1 | log-likelihood: -594.076706546417
#> EM - SNMoE: Iteration: 2 | log-likelihood: -546.825802433793
#> EM - SNMoE: Iteration: 3 | log-likelihood: -545.216012104673
#> EM - SNMoE: Iteration: 4 | log-likelihood: -544.875978684602
#> EM - SNMoE: Iteration: 5 | log-likelihood: -544.741259596426
#> EM - SNMoE: Iteration: 6 | log-likelihood: -544.638413273677
#> EM - SNMoE: Iteration: 7 | log-likelihood: -544.542767055472
#> EM - SNMoE: Iteration: 8 | log-likelihood: -544.453476005707
#> EM - SNMoE: Iteration: 9 | log-likelihood: -544.371810238334
#> EM - SNMoE: Iteration: 10 | log-likelihood: -544.29816804981
#> EM - SNMoE: Iteration: 11 | log-likelihood: -544.23225980214
#> EM - SNMoE: Iteration: 12 | log-likelihood: -544.173480964375
#> EM - SNMoE: Iteration: 13 | log-likelihood: -544.121101830955
#> EM - SNMoE: Iteration: 14 | log-likelihood: -544.074417623652
#> EM - SNMoE: Iteration: 15 | log-likelihood: -544.032702559887
#> EM - SNMoE: Iteration: 16 | log-likelihood: -543.995381652499
#> EM - SNMoE: Iteration: 17 | log-likelihood: -543.961937679208
#> EM - SNMoE: Iteration: 18 | log-likelihood: -543.931907863896
#> EM - SNMoE: Iteration: 19 | log-likelihood: -543.904904496396
#> EM - SNMoE: Iteration: 20 | log-likelihood: -543.880615235378
#> EM - SNMoE: Iteration: 21 | log-likelihood: -543.858679526452
#> EM - SNMoE: Iteration: 22 | log-likelihood: -543.838822041579
#> EM - SNMoE: Iteration: 23 | log-likelihood: -543.82083385064
#> EM - SNMoE: Iteration: 24 | log-likelihood: -543.804503402163
#> EM - SNMoE: Iteration: 25 | log-likelihood: -543.789656488741
#> EM - SNMoE: Iteration: 26 | log-likelihood: -543.776114613858
#> EM - SNMoE: Iteration: 27 | log-likelihood: -543.763742684141
#> EM - SNMoE: Iteration: 28 | log-likelihood: -543.752446136619
#> EM - SNMoE: Iteration: 29 | log-likelihood: -543.742095858086
#> EM - SNMoE: Iteration: 30 | log-likelihood: -543.732603152276
#> EM - SNMoE: Iteration: 31 | log-likelihood: -543.723872431908
#> EM - SNMoE: Iteration: 32 | log-likelihood: -543.715833394083
#> EM - SNMoE: Iteration: 33 | log-likelihood: -543.708411701498
#> EM - SNMoE: Iteration: 34 | log-likelihood: -543.70156441784
#> EM - SNMoE: Iteration: 35 | log-likelihood: -543.695235259338
#> EM - SNMoE: Iteration: 36 | log-likelihood: -543.689363429059
#> EM - SNMoE: Iteration: 37 | log-likelihood: -543.683902038086
#> EM - SNMoE: Iteration: 38 | log-likelihood: -543.678823171174
#> EM - SNMoE: Iteration: 39 | log-likelihood: -543.674100044355
#> EM - SNMoE: Iteration: 40 | log-likelihood: -543.669707947098
#> EM - SNMoE: Iteration: 41 | log-likelihood: -543.665618792815
#> EM - SNMoE: Iteration: 42 | log-likelihood: -543.661776190109
#> EM - SNMoE: Iteration: 43 | log-likelihood: -543.658190802471
#> EM - SNMoE: Iteration: 44 | log-likelihood: -543.654838959518
#> EM - SNMoE: Iteration: 45 | log-likelihood: -543.651682822869
#> EM - SNMoE: Iteration: 46 | log-likelihood: -543.648730362265
#> EM - SNMoE: Iteration: 47 | log-likelihood: -543.645958878637
#> EM - SNMoE: Iteration: 48 | log-likelihood: -543.64335120825
#> EM - SNMoE: Iteration: 49 | log-likelihood: -543.640883719209
#> EM - SNMoE: Iteration: 50 | log-likelihood: -543.638561599272
#> EM - SNMoE: Iteration: 51 | log-likelihood: -543.636373824312
#> EM - SNMoE: Iteration: 52 | log-likelihood: -543.6342965152
#> EM - SNMoE: Iteration: 53 | log-likelihood: -543.632323861401
#> EM - SNMoE: Iteration: 54 | log-likelihood: -543.630450041025
#> EM - SNMoE: Iteration: 55 | log-likelihood: -543.628679581868
#> EM - SNMoE: Iteration: 56 | log-likelihood: -543.62699772375
#> EM - SNMoE: Iteration: 57 | log-likelihood: -543.625400869743
#> EM - SNMoE: Iteration: 58 | log-likelihood: -543.623881433093
#> EM - SNMoE: Iteration: 59 | log-likelihood: -543.622434023539
#> EM - SNMoE: Iteration: 60 | log-likelihood: -543.62105322484
#> EM - SNMoE: Iteration: 61 | log-likelihood: -543.619733506212
#> EM - SNMoE: Iteration: 62 | log-likelihood: -543.618471819887
#> EM - SNMoE: Iteration: 63 | log-likelihood: -543.617270871324
#> EM - SNMoE: Iteration: 64 | log-likelihood: -543.616126115573
#> EM - SNMoE: Iteration: 65 | log-likelihood: -543.61502491197
#> EM - SNMoE: Iteration: 66 | log-likelihood: -543.613963137793
#> EM - SNMoE: Iteration: 67 | log-likelihood: -543.61294086903
#> EM - SNMoE: Iteration: 68 | log-likelihood: -543.611956558033
#> EM - SNMoE: Iteration: 69 | log-likelihood: -543.611007653194
#> EM - SNMoE: Iteration: 70 | log-likelihood: -543.610096467216
#> EM - SNMoE: Iteration: 71 | log-likelihood: -543.609221928654
#> EM - SNMoE: Iteration: 72 | log-likelihood: -543.608375884122
#> EM - SNMoE: Iteration: 73 | log-likelihood: -543.607555667856
#> EM - SNMoE: Iteration: 74 | log-likelihood: -543.60676616803
#> EM - SNMoE: Iteration: 75 | log-likelihood: -543.606000780008
#> EM - SNMoE: Iteration: 76 | log-likelihood: -543.605260504592
#> EM - SNMoE: Iteration: 77 | log-likelihood: -543.604538024895
#> EM - SNMoE: Iteration: 78 | log-likelihood: -543.60383540905
#> EM - SNMoE: Iteration: 79 | log-likelihood: -543.60315176703
#> EM - SNMoE: Iteration: 80 | log-likelihood: -543.602486448182
#> EM - SNMoE: Iteration: 81 | log-likelihood: -543.601838474529
#> EM - SNMoE: Iteration: 82 | log-likelihood: -543.601206428071
#> EM - SNMoE: Iteration: 83 | log-likelihood: -543.600589396243
#> EM - SNMoE: Iteration: 84 | log-likelihood: -543.59998710756
#> EM - SNMoE: Iteration: 85 | log-likelihood: -543.599397669474
#> EM - SNMoE: Iteration: 86 | log-likelihood: -543.59881939844
#> EM - SNMoE: Iteration: 87 | log-likelihood: -543.598249576808
#> EM - SNMoE: Iteration: 88 | log-likelihood: -543.597688571459
#> EM - SNMoE: Iteration: 89 | log-likelihood: -543.597141360885
#> EM - SNMoE: Iteration: 90 | log-likelihood: -543.596602408265

snmoe$plot()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-2.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-3.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-6-4.png" style="display: block; margin: auto;" />

``` r
# Application to a real data set

data("tempanomalies")
x <- tempanomalies$Year
y <- tempanomalies$AnnualAnomaly

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
#> EM - SNMoE: Iteration: 1 | log-likelihood: 79.3795084919271
#> EM - SNMoE: Iteration: 2 | log-likelihood: 88.6077487154674
#> EM - SNMoE: Iteration: 3 | log-likelihood: 89.0995777901543
#> EM - SNMoE: Iteration: 4 | log-likelihood: 89.3019864664197
#> EM - SNMoE: Iteration: 5 | log-likelihood: 89.5116268116396
#> EM - SNMoE: Iteration: 6 | log-likelihood: 89.7122271620437
#> EM - SNMoE: Iteration: 7 | log-likelihood: 89.8388430478893
#> EM - SNMoE: Iteration: 8 | log-likelihood: 89.9099150508807
#> EM - SNMoE: Iteration: 9 | log-likelihood: 89.9494433437618
#> EM - SNMoE: Iteration: 10 | log-likelihood: 89.9737959319188
#> EM - SNMoE: Iteration: 11 | log-likelihood: 89.9919675992365
#> EM - SNMoE: Iteration: 12 | log-likelihood: 90.0074545460241
#> EM - SNMoE: Iteration: 13 | log-likelihood: 90.0211913947432
#> EM - SNMoE: Iteration: 14 | log-likelihood: 90.033767860403
#> EM - SNMoE: Iteration: 15 | log-likelihood: 90.0456002778834
#> EM - SNMoE: Iteration: 16 | log-likelihood: 90.0568666364754
#> EM - SNMoE: Iteration: 17 | log-likelihood: 90.0676305643999
#> EM - SNMoE: Iteration: 18 | log-likelihood: 90.0779238899722
#> EM - SNMoE: Iteration: 19 | log-likelihood: 90.087764524831
#> EM - SNMoE: Iteration: 20 | log-likelihood: 90.0971543728586
#> EM - SNMoE: Iteration: 21 | log-likelihood: 90.1061099696688
#> EM - SNMoE: Iteration: 22 | log-likelihood: 90.1146563788967
#> EM - SNMoE: Iteration: 23 | log-likelihood: 90.1229291072915
#> EM - SNMoE: Iteration: 24 | log-likelihood: 90.1308471803325
#> EM - SNMoE: Iteration: 25 | log-likelihood: 90.1384035277473
#> EM - SNMoE: Iteration: 26 | log-likelihood: 90.1456302793801
#> EM - SNMoE: Iteration: 27 | log-likelihood: 90.1525520933844
#> EM - SNMoE: Iteration: 28 | log-likelihood: 90.1589657835663
#> EM - SNMoE: Iteration: 29 | log-likelihood: 90.1658117482096
#> EM - SNMoE: Iteration: 30 | log-likelihood: 90.1715907416443
#> EM - SNMoE: Iteration: 31 | log-likelihood: 90.1777058790535
#> EM - SNMoE: Iteration: 32 | log-likelihood: 90.183709003269
#> EM - SNMoE: Iteration: 33 | log-likelihood: 90.1897587017741
#> EM - SNMoE: Iteration: 34 | log-likelihood: 90.1960513028558
#> EM - SNMoE: Iteration: 35 | log-likelihood: 90.2021321388514
#> EM - SNMoE: Iteration: 36 | log-likelihood: 90.2081924662832
#> EM - SNMoE: Iteration: 37 | log-likelihood: 90.2144593850521
#> EM - SNMoE: Iteration: 38 | log-likelihood: 90.2206680209101
#> EM - SNMoE: Iteration: 39 | log-likelihood: 90.2269936274096
#> EM - SNMoE: Iteration: 40 | log-likelihood: 90.2333913061597
#> EM - SNMoE: Iteration: 41 | log-likelihood: 90.2398239762305
#> EM - SNMoE: Iteration: 42 | log-likelihood: 90.2463396634013
#> EM - SNMoE: Iteration: 43 | log-likelihood: 90.2529187712454
#> EM - SNMoE: Iteration: 44 | log-likelihood: 90.2595711662752
#> EM - SNMoE: Iteration: 45 | log-likelihood: 90.2662946336275
#> EM - SNMoE: Iteration: 46 | log-likelihood: 90.2730876308705
#> EM - SNMoE: Iteration: 47 | log-likelihood: 90.2799471994688
#> EM - SNMoE: Iteration: 48 | log-likelihood: 90.2868704917827
#> EM - SNMoE: Iteration: 49 | log-likelihood: 90.2938544756896
#> EM - SNMoE: Iteration: 50 | log-likelihood: 90.3008955108519
#> EM - SNMoE: Iteration: 51 | log-likelihood: 90.307987396706
#> EM - SNMoE: Iteration: 52 | log-likelihood: 90.3151228940034
#> EM - SNMoE: Iteration: 53 | log-likelihood: 90.3222957458199
#> EM - SNMoE: Iteration: 54 | log-likelihood: 90.3295046288873
#> EM - SNMoE: Iteration: 55 | log-likelihood: 90.3367450052947
#> EM - SNMoE: Iteration: 56 | log-likelihood: 90.3440110525276
#> EM - SNMoE: Iteration: 57 | log-likelihood: 90.3512960523025
#> EM - SNMoE: Iteration: 58 | log-likelihood: 90.3585956330031
#> EM - SNMoE: Iteration: 59 | log-likelihood: 90.3659055233489
#> EM - SNMoE: Iteration: 60 | log-likelihood: 90.3732210840745
#> EM - SNMoE: Iteration: 61 | log-likelihood: 90.3805380189856
#> EM - SNMoE: Iteration: 62 | log-likelihood: 90.3878506636781
#> EM - SNMoE: Iteration: 63 | log-likelihood: 90.3951546154787
#> EM - SNMoE: Iteration: 64 | log-likelihood: 90.402445535223
#> EM - SNMoE: Iteration: 65 | log-likelihood: 90.4097172355713
#> EM - SNMoE: Iteration: 66 | log-likelihood: 90.4169650118793
#> EM - SNMoE: Iteration: 67 | log-likelihood: 90.4241512570043
#> EM - SNMoE: Iteration: 68 | log-likelihood: 90.4313819172989
#> EM - SNMoE: Iteration: 69 | log-likelihood: 90.438520898034
#> EM - SNMoE: Iteration: 70 | log-likelihood: 90.4456200106541
#> EM - SNMoE: Iteration: 71 | log-likelihood: 90.4527110294215
#> EM - SNMoE: Iteration: 72 | log-likelihood: 90.459692085963
#> EM - SNMoE: Iteration: 73 | log-likelihood: 90.4666271280649
#> EM - SNMoE: Iteration: 74 | log-likelihood: 90.4735692618949
#> EM - SNMoE: Iteration: 75 | log-likelihood: 90.4804504854705
#> EM - SNMoE: Iteration: 76 | log-likelihood: 90.4873064324853
#> EM - SNMoE: Iteration: 77 | log-likelihood: 90.4941148510231
#> EM - SNMoE: Iteration: 78 | log-likelihood: 90.5008820589632
#> EM - SNMoE: Iteration: 79 | log-likelihood: 90.5076059336544
#> EM - SNMoE: Iteration: 80 | log-likelihood: 90.514283844616
#> EM - SNMoE: Iteration: 81 | log-likelihood: 90.5209174632568
#> EM - SNMoE: Iteration: 82 | log-likelihood: 90.5274975014861
#> EM - SNMoE: Iteration: 83 | log-likelihood: 90.5340254722801
#> EM - SNMoE: Iteration: 84 | log-likelihood: 90.5404999179244
#> EM - SNMoE: Iteration: 85 | log-likelihood: 90.5469226589462
#> EM - SNMoE: Iteration: 86 | log-likelihood: 90.5532875432125
#> EM - SNMoE: Iteration: 87 | log-likelihood: 90.5595939509351
#> EM - SNMoE: Iteration: 88 | log-likelihood: 90.5658410851777
#> EM - SNMoE: Iteration: 89 | log-likelihood: 90.5720296534643
#> EM - SNMoE: Iteration: 90 | log-likelihood: 90.5781603068242
#> EM - SNMoE: Iteration: 91 | log-likelihood: 90.5842284782608
#> EM - SNMoE: Iteration: 92 | log-likelihood: 90.5902323268045
#> EM - SNMoE: Iteration: 93 | log-likelihood: 90.5961726256392
#> EM - SNMoE: Iteration: 94 | log-likelihood: 90.602049070954
#> EM - SNMoE: Iteration: 95 | log-likelihood: 90.6078611676836
#> EM - SNMoE: Iteration: 96 | log-likelihood: 90.6136083786642
#> EM - SNMoE: Iteration: 97 | log-likelihood: 90.6192901818342
#> EM - SNMoE: Iteration: 98 | log-likelihood: 90.6249075785064
#> EM - SNMoE: Iteration: 99 | log-likelihood: 90.630459281253
#> EM - SNMoE: Iteration: 100 | log-likelihood: 90.6359443505873
#> EM - SNMoE: Iteration: 101 | log-likelihood: 90.6413619851309
#> EM - SNMoE: Iteration: 102 | log-likelihood: 90.646711436366
#> EM - SNMoE: Iteration: 103 | log-likelihood: 90.6519919607193
#> EM - SNMoE: Iteration: 104 | log-likelihood: 90.6572029446261
#> EM - SNMoE: Iteration: 105 | log-likelihood: 90.6623455819147
#> EM - SNMoE: Iteration: 106 | log-likelihood: 90.6674129337845
#> EM - SNMoE: Iteration: 107 | log-likelihood: 90.6724087658568
#> EM - SNMoE: Iteration: 108 | log-likelihood: 90.6773321697742
#> EM - SNMoE: Iteration: 109 | log-likelihood: 90.6821815646712
#> EM - SNMoE: Iteration: 110 | log-likelihood: 90.6869553220219
#> EM - SNMoE: Iteration: 111 | log-likelihood: 90.6916517962838
#> EM - SNMoE: Iteration: 112 | log-likelihood: 90.6962660325512
#> EM - SNMoE: Iteration: 113 | log-likelihood: 90.7008040452593
#> EM - SNMoE: Iteration: 114 | log-likelihood: 90.7052592053256
#> EM - SNMoE: Iteration: 115 | log-likelihood: 90.7096291971284
#> EM - SNMoE: Iteration: 116 | log-likelihood: 90.713912140193
#> EM - SNMoE: Iteration: 117 | log-likelihood: 90.7181061219904
#> EM - SNMoE: Iteration: 118 | log-likelihood: 90.7222148355886
#> EM - SNMoE: Iteration: 119 | log-likelihood: 90.7262431230913
#> EM - SNMoE: Iteration: 120 | log-likelihood: 90.7301756193653
#> EM - SNMoE: Iteration: 121 | log-likelihood: 90.7340109098415
#> EM - SNMoE: Iteration: 122 | log-likelihood: 90.7377432851395
#> EM - SNMoE: Iteration: 123 | log-likelihood: 90.7413777092841
#> EM - SNMoE: Iteration: 124 | log-likelihood: 90.7449735784621
#> EM - SNMoE: Iteration: 125 | log-likelihood: 90.7482304146564
#> EM - SNMoE: Iteration: 126 | log-likelihood: 90.7516793276098
#> EM - SNMoE: Iteration: 127 | log-likelihood: 90.7547588582116
#> EM - SNMoE: Iteration: 128 | log-likelihood: 90.7577889561541
#> EM - SNMoE: Iteration: 129 | log-likelihood: 90.7607289499742
#> EM - SNMoE: Iteration: 130 | log-likelihood: 90.7636153679845
#> EM - SNMoE: Iteration: 131 | log-likelihood: 90.766356321143
#> EM - SNMoE: Iteration: 132 | log-likelihood: 90.7690284369486
#> EM - SNMoE: Iteration: 133 | log-likelihood: 90.7715866539637
#> EM - SNMoE: Iteration: 134 | log-likelihood: 90.7740781052661
#> EM - SNMoE: Iteration: 135 | log-likelihood: 90.7764579988975
#> EM - SNMoE: Iteration: 136 | log-likelihood: 90.7787539646283
#> EM - SNMoE: Iteration: 137 | log-likelihood: 90.7809672126279
#> EM - SNMoE: Iteration: 138 | log-likelihood: 90.7832486494017
#> EM - SNMoE: Iteration: 139 | log-likelihood: 90.7852816112582
#> EM - SNMoE: Iteration: 140 | log-likelihood: 90.7872801176213
#> EM - SNMoE: Iteration: 141 | log-likelihood: 90.7891555220391
#> EM - SNMoE: Iteration: 142 | log-likelihood: 90.7909802012046
#> EM - SNMoE: Iteration: 143 | log-likelihood: 90.7927089905789
#> EM - SNMoE: Iteration: 144 | log-likelihood: 90.7943801836696
#> EM - SNMoE: Iteration: 145 | log-likelihood: 90.7959828685535
#> EM - SNMoE: Iteration: 146 | log-likelihood: 90.7975074323618
#> EM - SNMoE: Iteration: 147 | log-likelihood: 90.7989688434011
#> EM - SNMoE: Iteration: 148 | log-likelihood: 90.8003689504886
#> EM - SNMoE: Iteration: 149 | log-likelihood: 90.8017096185192
#> EM - SNMoE: Iteration: 150 | log-likelihood: 90.802992704314
#> EM - SNMoE: Iteration: 151 | log-likelihood: 90.8042200490168
#> EM - SNMoE: Iteration: 152 | log-likelihood: 90.8055068120007
#> EM - SNMoE: Iteration: 153 | log-likelihood: 90.8066222081013
#> EM - SNMoE: Iteration: 154 | log-likelihood: 90.8076878056269
#> EM - SNMoE: Iteration: 155 | log-likelihood: 90.8087053857003
#> EM - SNMoE: Iteration: 156 | log-likelihood: 90.8096926558442
#> EM - SNMoE: Iteration: 157 | log-likelihood: 90.8106183965406
#> EM - SNMoE: Iteration: 158 | log-likelihood: 90.811501414128
#> EM - SNMoE: Iteration: 159 | log-likelihood: 90.812343382469
#> EM - SNMoE: Iteration: 160 | log-likelihood: 90.8131583263779
#> EM - SNMoE: Iteration: 161 | log-likelihood: 90.8139243570699
#> EM - SNMoE: Iteration: 162 | log-likelihood: 90.8146540688632
#> EM - SNMoE: Iteration: 163 | log-likelihood: 90.8153468592334
#> EM - SNMoE: Iteration: 164 | log-likelihood: 90.8160064216135
#> EM - SNMoE: Iteration: 165 | log-likelihood: 90.8166341646697
#> EM - SNMoE: Iteration: 166 | log-likelihood: 90.8172314491599
#> EM - SNMoE: Iteration: 167 | log-likelihood: 90.8177999730068
#> EM - SNMoE: Iteration: 168 | log-likelihood: 90.8183410239228
#> EM - SNMoE: Iteration: 169 | log-likelihood: 90.8189192308156
#> EM - SNMoE: Iteration: 170 | log-likelihood: 90.8194071958945
#> EM - SNMoE: Iteration: 171 | log-likelihood: 90.8198712041541
#> EM - SNMoE: Iteration: 172 | log-likelihood: 90.8203094575555
#> EM - SNMoE: Iteration: 173 | log-likelihood: 90.8207252354411
#> EM - SNMoE: Iteration: 174 | log-likelihood: 90.8211198123816
#> EM - SNMoE: Iteration: 175 | log-likelihood: 90.8214943185334
#> EM - SNMoE: Iteration: 176 | log-likelihood: 90.8218497799791
#> EM - SNMoE: Iteration: 177 | log-likelihood: 90.8221970661254
#> EM - SNMoE: Iteration: 178 | log-likelihood: 90.8225168816142
#> EM - SNMoE: Iteration: 179 | log-likelihood: 90.822830342872
#> EM - SNMoE: Iteration: 180 | log-likelihood: 90.8231179034151
#> EM - SNMoE: Iteration: 181 | log-likelihood: 90.8233906598556
#> EM - SNMoE: Iteration: 182 | log-likelihood: 90.8236493246073
#> EM - SNMoE: Iteration: 183 | log-likelihood: 90.8238945815677
#> EM - SNMoE: Iteration: 184 | log-likelihood: 90.8241270839267
#> EM - SNMoE: Iteration: 185 | log-likelihood: 90.824347455163
#> EM - SNMoE: Iteration: 186 | log-likelihood: 90.8245562901448
#> EM - SNMoE: Iteration: 187 | log-likelihood: 90.8247541561584
#> EM - SNMoE: Iteration: 188 | log-likelihood: 90.8249415939096
#> EM - SNMoE: Iteration: 189 | log-likelihood: 90.8251191185043
#> EM - SNMoE: Iteration: 190 | log-likelihood: 90.8253319248004
#> EM - SNMoE: Iteration: 191 | log-likelihood: 90.8254904885227
#> EM - SNMoE: Iteration: 192 | log-likelihood: 90.8255956340608
#> EM - SNMoE: Iteration: 193 | log-likelihood: 90.8257834079666
#> EM - SNMoE: Iteration: 194 | log-likelihood: 90.8259178520032
#> EM - SNMoE: Iteration: 195 | log-likelihood: 90.8260450676504
#> EM - SNMoE: Iteration: 196 | log-likelihood: 90.8261200778231

snmoe$plot()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-7-2.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-7-3.png" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-7-4.png" style="display: block; margin: auto;" />
