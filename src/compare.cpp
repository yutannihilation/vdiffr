#include <string>
#include <vector>
#include <fstream>
#include <Rcpp.h>

// [[Rcpp::export]]
bool compare_files(std::string expected, std::string test) {
  std::ifstream file1(expected, std::ifstream::ate | std::ifstream::binary);
  std::ifstream file2(test, std::ifstream::ate | std::ifstream::binary);
  std::streamsize size1 = file1.tellg();
  std::streamsize size2 = file2.tellg();

  if (size1 != size2)
    return false;

  file1.seekg(0, std::ios::beg);
  file2.seekg(0, std::ios::beg);
  std::vector<char> buffer1(size1);
  std::vector<char> buffer2(size2);

  if (file1.read(buffer1.data(), size1) && file2.read(buffer2.data(), size2))
    return buffer1 == buffer2;
  else
    Rcpp::stop("vdiffr error: unable to read svg files");
}
