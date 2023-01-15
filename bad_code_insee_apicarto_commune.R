library(happign)
library(purrr)
library(beepr)

code_insee <- cog_2022$COM

try_get_com <- function(x){
   nb <- match(x, code_insee)
   message(nb, "/37601")
   try(get_apicarto_commune(x))
}

res <- map(.x = code_insee,
           .f = ~ try_get_com(.x)) |>
   set_names(code_insee)

bad_code_insee <- res |>
   keep(function(x) is.null(dim(x)))

bad_cog_2022 <- cog_2022 |>
   filter(COM %in% names(test))

write.csv2(bad_cog_2022, "bad_code_insee.csv", row.names = F, fileEncoding = "ISO-8859-1")
