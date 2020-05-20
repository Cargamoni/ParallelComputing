#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import random

# Input olarak matris boyutlarının 
try:
    dim_x, dim_y = int(sys.argv[1]), int(sys.argv[2])
except Exception, e:
    sys.stderr.write("Matris bölümleri alınırken hata oluştu...\n")
    raise

# Verilen boyutlara göre rastgele noktalı sayı üretilmektedir.
for row in xrange(0, dim_x):
    print "\t".join([ unicode(random.uniform(0, 9999)) for x in xrange(0, dim_y) ])
