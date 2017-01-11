#include <iostream>
#include "psf.h"
//#include "psfdata.h"


typedef std::map<std::string, const PSFScalar *> PropertyMap;

int main(int argc, char *argv[]) {
  std::string fname = argv[1];
  std::cout << "file: " << fname << std::endl;
  PSFDataSet *dataset = new PSFDataSet(fname);

  // print number of sweeps
  std::cout << "nsweeps = " << dataset->get_nsweeps() << std::endl;
  std::cout << std::endl;

  // print out all property values
  PropertyMap pmap = dataset->get_header_properties();
  std::cout << "header property values: " << std::endl;
  for ( auto & x: pmap ) {
    std::cout << x.first << " => " << x.second << std::endl;
  }
  std::cout << std::endl;
  
  // print out int value
  std::string key = "PSF sweep points";
  std::cout << key  << " int val => " << static_cast<int>(*(pmap.find(key)->second)) << std::endl;
  key = "simulator";
  std::cout << key  << " str val => " << pmap.find(key)->second->tostring() << std::endl;
  std::cout << std::endl;

  // get signal names
  std::vector<std::string> signals = dataset->get_signal_names();
  std::cout << "signals: " << std::endl;
  for( auto & x: signals ) {
    std::cout << x << std::endl;
  }
  std::cout << std::endl;

  // get sweep parameter names
  std::vector<std::string> swp_pars = dataset->get_sweep_param_names();
  std::cout << "sweep param names: " << std::endl;
  for( auto & x: swp_pars ) {
    std::cout << x << std::endl;
  }
  std::cout << std::endl;
  
}
