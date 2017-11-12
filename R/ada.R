#' Get the IDs
#'
#' Download the IDs of the available data.
#'
#' @return A tibble with one column 'id' containing the IDs of the data.
#'
#' @export
#'
get_dataset_ids <- function() {
  req <- GET("https://www.avoindata.fi/data/api/3/action/package_list")
  handle_error(req)

  req$content %>%
    rawToChar() %>%
    fromJSON() %>%
    pluck("result") %>%
    tibble() %>%
    set_names("id")
}

#' Get dataset info with ID
#'
#' Download information related to the data.
#'
#' @param id The ID of the data.
#'
#' @return A list with the following fields:
#' \describe{
#'   \item{\code{organization}}{The name of the organization
#'    that has released the data.}
#'   \item{\code{license}}{The license of the data.}
#'   \item{\code{datasets}}{If available, a list of the datasets.
#'    Contains fields name, format and url, the last of which points to the
#'    url of the dataset. Otherwise \code{NULL}.'}
#'   \item{\code{notes}}{Notes related to the data. Most likely in finnish.}
#' }
#'
#' @export
#'
get_dataset_info <- function(id) {
  req <- "https://www.avoindata.fi/data/api/3/action/package_show?id=" %>%
    str_c(id) %>%
    GET()
  handle_error(req)

  res <- req$content %>%
    rawToChar() %>%
    fromJSON() %>%
    pluck("result")

  datasets <- if(length(res$resources) > 0) {
    res$resources[c("name", "format", "url")] %>%
      as_tibble() %>%
      mutate_all(as.character)
  } else {
    NULL
  }

  list(organization = res$organization$title,
       license = res$license_title,
       datasets = datasets,
       notes = res$notes)
}