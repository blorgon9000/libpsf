#!/usr/bin/env python
 
from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize
from Cython.Distutils import build_ext

import numpy as np

extensions = [Extension('pypsf._psf',
                        ['pypsf/_psf.pyx'],
                        include_dirs=[np.get_include(), '../../include'],
                        libraries=['psf'],
                        language='c++',
                        # extra_link_args=["-L/home/erichang/Applications/core/lib"],
                       ),
]

setup(name='pypsf',
      version='1.0',
      description='Python extension to libpsf',
      author=['Henrik Johansson', 'Eric Chang'],
      packages=['pypsf'],
      ext_modules=cythonize(extensions),
      cmdclass={'build_ext': build_ext},
      # package_dir = {'': '.'},
      # packages=["tests"],
      # tests_require=["mock"],
      # test_suite="tests",
)

