#include <iostream>
#include "psf.h"
//#include "psfdata.h"

typedef std::vector<std::string>::iterator str_it;
typedef std::map<std::string, const PSFScalar *>::iterator pmap_it;
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
  for ( pmap_it it = pmap.begin(); it != pmap.end(); it++) {
    std::cout << it->first << " => " << it->second << std::endl;
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
  for( str_it it = signals.begin(); it != signals.end(); it++) {
    std::cout << *it << std::endl;
  }
  std::cout << std::endl;

  // get signal properties
  std::string sig_name = signals[0];
  pmap = dataset->get_signal_properties(sig_name);
  std::cout << "signal " << sig_name << " property values: " << std::endl;
  for ( pmap_it it = pmap.begin(); it != pmap.end(); it++) {
    std::cout << it->first << " => " << it->second << std::endl;
  }
  std::cout << std::endl;
  
  // get sweep parameter names
  std::vector<std::string> swp_pars = dataset->get_sweep_param_names();
  std::cout << "sweep param names: " << std::endl;
  for( str_it it = signals.begin(); it != signals.end(); it++) {
    std::cout << *it << std::endl;
  }
  std::cout << std::endl;
  
}
