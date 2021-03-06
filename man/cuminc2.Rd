% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cuminc2.R
\name{cuminc2}
\alias{cuminc2}
\title{Cumulative incidence analysis}
\usage{
cuminc2(formula, data, rho = 0, cencode = NULL, subset = NULL,
  na.action = getOption("na.action"))
}
\arguments{
\item{formula}{a \code{\link[=Surv]{survival object}} formula,
\code{Surv(time, status(censor)) ~ response}, where \code{censor} is a
unique value of the \code{status} variable indicating the censoring code;
note all other unique values of \code{status} will be treated as competing
risks}

\item{data}{a data frame in which to interpret the variables named in
\code{formula}}

\item{rho, cencode, subset, na.action}{passed to \code{\link[cmprsk]{cuminc}};
the censoring indicator will be guessed from \code{formula} but may be
overridden by \code{cencode}}
}
\description{
Estimate cumulative incidence functions from competing risks data and test
equality across groups.
}
\examples{
tp <- within(transplant, {
  event_ind <- as.integer(event) - 1L
})

## no group, no strata
form <- Surv(futime, event_ind(0)) ~ 1
identical(
  cuminc2(form, tp)$cuminc,
  with(tp, cuminc(futime, event_ind))
)

## group-only
form <- Surv(futime, event_ind(0)) ~ sex
identical(
  cuminc2(form, tp)$cuminc,
  with(tp, cuminc(futime, event_ind, sex))
)

## strata-only
form <- Surv(futime, event_ind(0) == 1) ~ strata(abo)
identical(
  cuminc2(form, tp)$cuminc,
  with(tp, cuminc(futime, event_ind, strata = sex))
)

## group and strata
form <- Surv(futime, event_ind(0) == 1) ~ sex + strata(abo)
identical(
  cuminc2(form, tp)$cuminc,
  with(tp, cuminc(futime, event_ind, sex, abo))
)


}
