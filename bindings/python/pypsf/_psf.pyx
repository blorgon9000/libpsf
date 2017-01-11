#cython: language_level=3

from libcpp.string cimport string

cdef extern from 'psf.h':
    cdef cppclass cpp_PSFDataSet 'PSFDataSet':
        cpp_PSFDataSet(string) except +
        int get_nsweeps()
        void close()

cdef class PSFDataSet:
    cdef cpp_PSFDataSet* c_dset
        
    def __cinit__(self, bytes fname):
        cdef string cpp_fname = fname
        self.c_dset = new cpp_PSFDataSet(cpp_fname)

    def __dealloc__(self):
        del self.c_dset
        
    def get_nsweeps(self):
        return self.c_dset.get_nsweeps()
