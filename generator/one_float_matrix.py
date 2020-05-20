#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import random

# Input olarak matris boyutlarının alınması.
try:
    dim_x, dim_y = int(sys.argv[1]), int(sys.argv[2])
except Exception, e:
    sys.stderr.write("Matris bölümleri alınırken hata oluştu...\n")
    raise

# Verilen boyutlara göre 1 ile doldurmak için kullanılmaktadır..
for row in xrange(0, dim_x):
    print "\t".join([ unicode(random.uniform(1, 1)) for x in xrange(0, dim_y) ])