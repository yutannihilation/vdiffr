#include <Rcpp.h>
#include <freetypeharfbuzz.c>


// [[Rcpp::export]]
SEXP library_load() {
  fthb_init();
  return R_NilValue;
}
