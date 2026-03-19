FORM f1400 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = abs( s0 ). rv = s0.
ENDFORM.

FORM f1401 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = sqrt( s0 ). rv = s0.
ENDFORM.

FORM f1402 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = ceil( s0 ). rv = s0.
ENDFORM.

FORM f1403 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = floor( s0 ). rv = s0.
ENDFORM.

FORM f1404 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = trunc( s0 ). rv = s0.
ENDFORM.

FORM f1405 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 0. rv = s0.
ENDFORM.

FORM f1406 USING p0 TYPE i p1 TYPE i p2 TYPE i p3 TYPE i p4 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = -51539607552. rv = s0.
ENDFORM.

FORM f1407 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 12884901888. rv = s0.
ENDFORM.

FORM f1408 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
ENDFORM.

FORM f1409 USING p0 TYPE i.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
ENDFORM.

