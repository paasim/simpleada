.onAttach <- function(...) {
  ver <- utils::packageVersion("simpleada")
  packageStartupMessage("This is simpleada version ", ver)
}

handle_error <- function(req) {
  if (http_error(req)) content(req, "text", "application/json", "UTF-8") %>% stop()
}
