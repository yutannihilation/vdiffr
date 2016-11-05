#include <string>
#include <vector>
#include <fstream>
#include <algorithm>
#include <Rcpp.h>

int compare_throw() {
  Rcpp::stop("vdiffr error: unable to read svg files");
  return 0;
}

// [[Rcpp::export]]
bool compare_files(std::string expected, std::string test) {
  std::ifstream file1(expected.c_str(), std::ifstream::ate | std::ifstream::binary);
  std::ifstream file2(test.c_str(), std::ifstream::ate | std::ifstream::binary);
  if (!file1 || !file2)
    compare_throw();

  std::streamsize size1 = file1.tellg();
  std::streamsize size2 = file2.tellg();
  file1.seekg(0, std::ios::beg);
  file2.seekg(0, std::ios::beg);

  std::vector<char> buffer1(size1);
  std::vector<char> buffer2(size2);
  if (!file1.read(buffer1.data(), size1) ||
      !file2.read(buffer2.data(), size2))
    compare_throw();

  // Remove carriage returns from SVGs generated on Windows
  buffer1.erase(std::remove(buffer1.begin(), buffer1.end(), 0x0D), buffer1.end());
  buffer2.erase(std::remove(buffer2.begin(), buffer2.end(), 0x0D), buffer2.end());

  return buffer1 == buffer2;
}
