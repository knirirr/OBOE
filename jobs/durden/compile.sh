#!/bin/bash
g++ `/usr/bin/Magick++-config --cxxflags --cppflags` -o durden durden.cpp `/usr/bin/Magick++-config --ldflags --libs` 
