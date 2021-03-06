% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Olink_normalization.R
\name{olink_normalization}
\alias{olink_normalization}
\title{Normalization of all proteins (by OlinkID).}
\usage{
olink_normalization(
  df1,
  df2 = NULL,
  overlapping_samples_df1,
  overlapping_samples_df2 = NULL,
  df1_project_nr = "P1",
  df2_project_nr = "P2",
  reference_project = "P1",
  reference_medians = NULL
)
}
\arguments{
\item{df1}{First dataframe to be used in normalization (required).}

\item{df2}{Second dataframe to be used in normalization}

\item{overlapping_samples_df1}{Samples to be used for adjustment factor calculation in df1 (required).}

\item{overlapping_samples_df2}{Samples to be used for adjustment factor calculation in df1.}

\item{df1_project_nr}{Project name of first dataset.}

\item{df2_project_nr}{Project name of second dataset.}

\item{reference_project}{Project name of reference_project. Needs to be the same as either df1_project_nr or df2_project_nr. The project to which the second project is adjusted to.}

\item{reference_medians}{Dataframe which needs to contain columns "OlinkID", and "Reference_NPX". Used for reference median normalization.}
}
\value{
A tibble of NPX data in long format containing normalized NPX values, including adjustment factors.
}
\description{
Normalizes NPX data frames to another data frame or to reference medians. If two dataframes are normalized to one another, the Olink default is using the older dataframe as reference. 
The function handles four different types of normalization: \cr\cr
Bridging normalization: One of the dataframes is adjusted to another using overlapping samples (bridge samples). 
The overlapping samples need to be named the same between the dataframes and adjustment is made using the median of the paired differences between the bridge samples in the two data frames. 
The two dataframes are inputs df1 and df2, the one being adjusted to is specified in the input reference_project and the overlapping samples are specified in overlapping_samples_df1. 
Only overlapping_samples_df1 should be input, no matter which dataframe is used as reference_project.  \cr\cr
Subset normalization: One of the dataframes is adjusted to the dataframe set as reference_project using a sample subset. 
Adjustment is made using the differences in median between the subsets from the two data frames. 
Both overlapping_samples_df1 and overlapping_samples_df2 need to be input. 
The samples do not need to be named the same. \cr\cr
Intensity normalization: A version of subset normalization where all samples (except control samples) from the dataframes are input as overlapping_samples_df1 and overlapping_samples_df2, respectively. \cr\cr 
Reference median normalization: Working only on one dataframe. This is effectively subset normalization, but using difference of medians to pre-recorded median values.
df1, overlapping_samples_df1 and reference_medians need to be specified. Adjustment of df1 is made using the differences in median between the overlapping samples and the reference medians.
}
\examples{
\donttest{
data_1 <- read_NPX("~/NPX data1.xlsx")
data_2 <- read_NPX("~/NPX data2.xlsx")

#Bridging normalization:
overlap_samples<-intersect(data_1,data_2)
olink_normalization(df1 = data_1, 
df2 = data_2, 
overlapping_samples_df1 = overlap_samples)

#Subset normalization:
olink_normalization(df1 = data_1, 
df2 = data_2, 
overlapping_samples_df1 = some_samples_from_df1, 
overlapping_samples_df2 = some_samples_from_df2)

#Reference median normalization:
olink_normalization(df1 = data_1, 
overlapping_samples_df1 = some_samples_from_df1,
reference_medians = reference_median_df_per_olinkid)
}
}
\keyword{Normalization}
