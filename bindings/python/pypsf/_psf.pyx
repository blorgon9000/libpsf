#!python
#cython: language_level=3

from libcpp.string cimport string
from libcpp.complex cimport complex
from libcpp.vector cimport vector
from libcpp.map cimport map
from libcpp.cast cimport dynamic_cast
from libc.stdint cimport int8_t, int32_t

import os
import sys


cdef extern from 'psfdata.h':
    cdef cppclass cpp_PSFScalar 'PSFScalar':
        string tostring()
    cdef cppclass cpp_PSFStringScalar 'PSFStringScalar':
        string value
    cdef cppclass cpp_PSFInt8Scalar 'PSFInt8Scalar':
        int8_t value
    cdef cppclass cpp_PSFInt32Scalar 'PSFInt32Scalar':
        int32_t value
    cdef cppclass cpp_PSFDoubleScalar 'PSFDoubleScalar':
        double value
    cdef cppclass cpp_PSFComplexDoubleScalar 'PSFComplexDoubleScalar':
        complex[double] value


cdef extern from 'psf.h':
    cdef cppclass cpp_PSFDataSet 'PSFDataSet':
        cpp_PSFDataSet(string) except +
        void close()
        const map[string, const cpp_PSFScalar*] get_header_properties() except +
        const map[string, const cpp_PSFScalar*] get_signal_properties(string) except +
        const vector[string] get_signal_names()
        bint is_swept()
        int get_nsweeps()
        const vector[string] get_sweep_param_names()
        int get_sweep_npoints()
        void set_invertstruct(bint)
        bint get_invertstruct()


ctypedef const cpp_PSFStringScalar * string_scalar_ptr
ctypedef const cpp_PSFInt8Scalar * int8_scalar_ptr
ctypedef const cpp_PSFInt32Scalar * int32_scalar_ptr
ctypedef const cpp_PSFDoubleScalar * double_scalar_ptr
ctypedef const cpp_PSFComplexDoubleScalar * complex_scalar_ptr

        
cdef scalar_to_python(const cpp_PSFScalar * scalar):
    cdef string_scalar_ptr p1 = dynamic_cast[string_scalar_ptr](scalar)
    if p1:
        return p1.value
    cdef int32_scalar_ptr p2 = dynamic_cast[int32_scalar_ptr](scalar)
    if p2:
        return p2.value
    cdef int8_scalar_ptr p3 = dynamic_cast[int8_scalar_ptr](scalar)
    if p3:
        return p3.value
    cdef double_scalar_ptr p4 = dynamic_cast[double_scalar_ptr](scalar)
    if p4:
        return p4.value
    cdef complex_scalar_ptr p5 = dynamic_cast[complex_scalar_ptr](scalar)
    if p5:
        return p5.value
    return -1


cdef class PSFDataSet:
    cdef cpp_PSFDataSet* c_dset
    def __cinit__(self, fname):
        if not os.path.isfile(fname):
            raise ValueError('Cannot find file %s' % fname)
        cdef string cpp_fname = self._to_bytes(fname, sys.getfilesystemencoding())
        self.c_dset = new cpp_PSFDataSet(cpp_fname)
    
    @staticmethod
    def _to_bytes(mystr, encoding):
        if isinstance(mystr, str):
            mystr = mystr.encode(encoding)
        return mystr
        
    def __dealloc__(self):
        del self.c_dset
        
    def close(self):
        self.c_dset.close()

    def __enter__(self):
        return self

    def __exit__(self):
        self.close()
        
    def get_header_properties(self):
        cdef map[string, const cpp_PSFScalar*] prop_map = self.c_dset.get_header_properties()
        pymap = {}
        for entry in prop_map:
            pymap[entry.first] = scalar_to_python(entry.second)

        return pymap

    def get_signal_properties(self, sig_name, encoding='utf-8'):
        cdef string cpp_sig_name = self._to_bytes(sig_name, encoding)

        cdef map[string, const cpp_PSFScalar*] prop_map = self.c_dset.get_signal_properties(cpp_sig_name)
        pymap = {}
        for entry in prop_map:
            pymap[entry.first] = scalar_to_python(entry.second)

        return pymap
    
    def get_signal_names(self):
        return self.c_dset.get_signal_names()

    def is_swept(self):
        return self.c_dset.is_swept()

    def get_nsweeps(self):
        return self.c_dset.get_nsweeps()

    def get_sweep_param_names(self):
        return self.c_dset.get_sweep_param_names()

    def get_sweep_npoints(self):
        return self.c_dset.get_sweep_npoints()

    @property
    def invertstruct(self):
        return self.c_dset.get_invertstruct()

    @invertstruct.setter
    def invertstruct(self, bint value):
        self.c_dset.set_invertstruct(value)
