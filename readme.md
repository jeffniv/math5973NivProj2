
# title: "A Simple Framework for Singular Spectrum Analysis"
# author: "Jeff Nivitanont"
# date: "April 10, 2020"


# Intro

Spectral decomposition of a 1-d time series, a Singular Spectrum Analysis (SSA), traces back to the 1940's in the works of Karhunen (1946) and Loeve (1945, 1978). This decompositon on a 1-d time series was widely used in signal processing and known as the Karhunen-Loeve decomposition. Broomhead and King (1986) and Fraedrich (1986) came up with the idea to use multichannel SSA for multivariate time series, and used this concept to study nonlinear dynamics of strange attractors. From the late 80's to the early 2000's, Ghil et al applied these methods to study oceanic and atmospheric dynamics. These methods used embedding theory and exploited the eigendecomposition of the resulting covariance matrix.

This package uses an equivalent paradigm, the Singular Value Decomposition, to reconstruct the embedded trajectory matrix.
 
# Theory

Golyandina et. al (2001) first exploited Singular Value Decomposition of the trajectory matrix and introduced the use of diagonal averaging post-reconstruction.


## 1. Embedding
    
## 2. Singular Value Decomposition
    
## 3. Grouping
    
## 4. Reconstruction
    
# Basic uses of SSA

## Trend extraction

## Denoising

## Extraction of periodic components

# Examples

# References
