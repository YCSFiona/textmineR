% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/topic_modeling_core.R
\name{FitLdaModel}
\alias{FitLdaModel}
\title{Fit a Latent Dirichlet Allocation topic model}
\usage{
FitLdaModel(dtm, k, iterations = NULL, burnin = -1, alpha = 0.1,
  beta = 0.05, optimize_alpha = FALSE, calc_likelihood = FALSE,
  calc_coherence = TRUE, calc_r2 = FALSE, ...)
}
\arguments{
\item{dtm}{A document term matrix or term co-occurrence matrix of class dgCMatrix}

\item{k}{Integer number of topics}

\item{iterations}{Integer number of iterations for the Gibbs sampler to run. A
future version may include automatic stopping criteria.}

\item{burnin}{Integer number of burnin iterations. If \code{burnin} is greater than -1,
the resulting "phi" and "theta" matrices are an average over all iterations
greater than \code{burnin}.}

\item{alpha}{Vector of length \code{k} for asymmetric or a number for symmetric.
This is the prior for topics over documents}

\item{beta}{Vector of length \code{ncol(dtm)} for asymmetric or a number for symmetric.
This is the prior for words over topics.}

\item{optimize_alpha}{Logical. Do you want to optimize alpha every 10 Gibbs iterations?
Defaults to \code{FALSE}.}

\item{calc_likelihood}{Do you want to calculate the likelihood every 10 Gibbs iterations?
Useful for assessing convergence. Defaults to \code{FALSE}.}

\item{calc_coherence}{Do you want to calculate probabilistic coherence of topics
after the model is trained? Defaults to \code{TRUE}.}

\item{calc_r2}{Do you want to calculate R-squared after the model is trained?
Defaults to \code{FALSE}.}

\item{...}{Other arguments to be passed to \code{\link[textmineR]{TmParallelApply}}}
}
\value{
Returns an S3 object of class c("LDA", "TopicModel"). DESCRIBE MORE
}
\description{
Fit a Latent Dirichlet Allocation topic model using collapsed Gibbs sampling.
}
\details{
EXPLAIN IMPLEMENTATION DETAILS
}
\examples{
# load some data
data(nih_sample_dtm)

# fit a model 
set.seed(12345)
m <- FitLdaModel(dtm = nih_sample_dtm[1:20,], k = 5,
                 iterations = 200, burnin = 175)

str(m)

# predict on held-out documents using gibbs sampling "fold in"
p1 <- predict(m, nih_sample_dtm[21:100,], method = "gibbs",
              iterations = 200, burnin = 175)

# predict on held-out documents using the dot product method
p2 <- predict(m, nih_sample_dtm[21:100,], method = "dot")

# compare the methods
barplot(rbind(p1[1,],p2[1,]), beside = TRUE, col = c("red", "blue")) 
}
