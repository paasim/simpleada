# simpleada

[![Build Status](https://travis-ci.org/paasim/simpleada.svg?branch=master)](https://travis-ci.org/paasim/simpleada)
[![codecov](https://codecov.io/gh/paasim/simpleada/branch/master/graphs/badge.svg)](https://codecov.io/gh/paasim/simpleada)

An R package for accessing the [avoindata.fi](https://www.avoindata.fi/en) API for personal use. Currently contains only a very limited set of functionality and may contain bugs.

Installation
------------

    devtools::install_github("paasim/simpleada")


Usage
-----
    
    library(simpleada)
    get_dataset_info("kunnat")
