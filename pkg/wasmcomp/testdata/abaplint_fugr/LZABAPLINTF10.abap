FORM f1000 USING p0 TYPE f p1 TYPE f CHANGING rv TYPE f.
  DATA:  l2 TYPE f, l3 TYPE f, l4 TYPE f, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i,
       s17 TYPE i, s18 TYPE i, s19 TYPE i, s20 TYPE i, s21 TYPE i, s22 TYPE i, s23 TYPE i, lv_br TYPE i.
  s0 = '1.000000'. s1 = p0. s2 = p0. s1 = s1 * s2. l2 = s1. s2 = '0.500000'. s1 = s1 * s2. l3 = s1. s0 = s0 - s1. l4 = s0. s1 = '1.000000'. s2 = l4. s1 = s1 - s2. s2 = l3. s1 = s1 - s2. s2 = l2. s3 = l2. s4 = l2. s5 = l2. s6 = '0.000025'.
  s5 = s5 * s6. s6 = '-0.001389'. s5 = s5 + s6. s4 = s4 * s5. s5 = '0.041667'. s4 = s4 + s5. s3 = s3 * s4. s4 = l2. s5 = l2. s4 = s4 * s5. l3 = s4. s5 = l3. s4 = s4 * s5. s5 = l2. s6 = l2. s7 = '-0.000000'. s6 = s6 * s7. s7 = '0.000000'.
  s6 = s6 + s7. s5 = s5 * s6. s6 = '-0.000000'. s5 = s5 + s6. s4 = s4 * s5. s3 = s3 + s4. s2 = s2 * s3. s3 = p0. s4 = p1. s3 = s3 * s4. s2 = s2 - s3. s1 = s1 + s2. s0 = s0 + s1. rv = s0.
ENDFORM.

FORM f1001 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 8 ). l2 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 12 ). IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 16 ). IF s0 <> 0.
      s0 = p0. s1 = l2. s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 4 ). s1 = l2. s2 = 1. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s1 = 16. s0 = s0 + s1.
      s1 = p1. mem_st_i32_16( iv_addr = s0 iv_val = s1 ). s0 = 0. rv = s0. RETURN.
    ELSE. ENDIF. s0 = p1. s1 = 255. IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = l2. s2 = 1. s1 = s1 + s2.
    mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 4 ). s1 = l2. s0 = s0 + s1. s1 = 16. s0 = s0 + s1. s1 = p1. mem_st_i32_8( iv_addr = s0 iv_val = s1 ). s0 = 0. rv = s0. RETURN.
  ENDDO. s0 = p0. s1 = p1. PERFORM f844 USING s0 s1 CHANGING s0. rv = s0.
ENDFORM.

FORM f1002 USING p0 TYPE i p1 TYPE i p2 TYPE i p3 TYPE i p4 TYPE i p5 TYPE i CHANGING rv TYPE i.
  DATA:  l6 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 32. s0 = s0 - s1. l6 = s0. gv_g0 = s0. s0 = l6. s1 = 0. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 20 CHANGING cv_mem = mv_mem ). s0 = l6. s1 = -9223372036854775808.
  zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 12 CHANGING cv_mem = mv_mem ). s0 = l6. s1 = p0. s1 = mem_ld_i32( s1 ). mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = l6. s1 = 8. s0 = s0 + s1. s1 = p0. s2 = p1. s3 = p2.
  s4 = p3. s5 = p4. s6 = p5. PERFORM f88 USING s0 s1 s2 s3 s4 s5 s6 CHANGING s0. DO 1 TIMES. " block
    s1 = l6. s1 = mem_ld_i32( s1 + 8 ). p0 = s1. IF s1 = 0. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = l6. s1 = mem_ld_i32( s1 + 24 ). p2 = s1. IF s1 = 0. s1 = 1. ELSE. s1 = 0. ENDIF.
    IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p0. s1 = mem_ld_i32( s1 ). s2 = p2. s3 = 0. s4 = p0. s5 = 4. s4 = s4 + s5. s4 = mem_ld_i32( s4 ). DATA(lv_ci_func) = mt_tab0[ s4 + 1 ]. " call_indirect
    s1 = dispatch_t11( iv_idx = lv_ci_func p0 = s1 p1 = s2 p2 = s3 ).
  ENDDO. s1 = l6. s2 = 32. s1 = s1 + s2. gv_g0 = s1. rv = s0.
ENDFORM.

FORM f1003 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  l1 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i, s17 TYPE i,
       lv_br TYPE i.
  s0 = p0. s0 = zcl_wasm_rt=>reinterpret_f64_i64( s0 ). s1 = 52. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 2047. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). l1 = s0. s1 = 1023.
  IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = '-1.000000'. s0 = s0 + s1. p0 = s0. s1 = p0. s2 = p0. s1 = s1 * s2. s2 = p0. s3 = p0. s2 = s2 + s3. s1 = s1 + s2. s1 = sqrt( s1 ). s0 = s0 + s1. PERFORM f564 USING s0 CHANGING s0. rv = s0. RETURN.
  ELSE. ENDIF. s0 = l1. s1 = 1048. IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = p0. s0 = s0 + s1. s1 = '-1.000000'. s2 = p0. s3 = p0. s2 = s2 * s3. s3 = '-1.000000'. s2 = s2 + s3. s2 = sqrt( s2 ). s3 = p0. s2 = s2 + s3. s1 = s1 / s2. s0 = s0 + s1. PERFORM f424 USING s0 CHANGING s0. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. PERFORM f424 USING s0 CHANGING s0. s1 = '0.693147'. s0 = s0 + s1. rv = s0.
ENDFORM.

FORM f1004 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 300 ). l1 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 296 ). IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = l1. s1 = 1. s0 = s0 + s1. l2 = s0. s0 = -1. l1 = s0. s0 = p0. s0 = mem_ld_i32( s0 ). s1 = p0. s2 = 292. s1 = s1 + s2. s2 = 20. s3 = p0. s4 = 296. s3 = s3 + s4. s4 = l2. PERFORM f845 USING s0 s1 s2 s3 s4 CHANGING s0.
      IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 + 300 ). l1 = s0.
    ELSE. ENDIF. s0 = p0. s1 = l1. s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 300 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 292 ). s1 = l1. s2 = 20. s1 = s1 * s2. s0 = s0 + s1. p0 = s0. s1 = 0.
    mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = p0. s1 = -1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 8 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = -4294967296.
    zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ).
  ENDDO. s0 = l1. rv = s0.
ENDFORM.

FORM f1005 USING p0 TYPE i p1 TYPE i p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = p1. s0 = mem_ld_i32( s0 + 4 ). p1 = s0. s0 = p2. s1 = l3. s2 = 12. s1 = s1 + s2. s2 = p0. s2 = mem_ld_i32( s2 + 4 ). PERFORM f513 USING s0 s1 s2 CHANGING s0. s1 = 0. s2 = p2.
  s3 = l3. s4 = 8. s3 = s3 + s4. s4 = p1. PERFORM f513 USING s2 s3 s4 CHANGING s2. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = 1140312. s1 = 1148333. s2 = 7597. s3 = 1140940. PERFORM f1101 USING s0 s1 s2 s3. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
  ELSE. ENDIF. s0 = l3. s0 = mem_ld_i32( s0 + 8 ). p0 = s0. s0 = l3. s0 = mem_ld_i32( s0 + 12 ). p1 = s0. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = -1. s1 = p0. s2 = p1. IF s1 <> s2. s1 = 1. ELSE. s1 = 0. ENDIF. s2 = p0. s3 = p1.
  IF zcl_wasm_rt=>gt_u32( iv_a = s2 iv_b = s3 ) = abap_true. s2 = 1. ELSE. s2 = 0. ENDIF. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. rv = s0.
ENDFORM.

FORM f1006 USING p0 TYPE i p1 TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, lv_br TYPE i.
  s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). s0 = mem_ld_i32( s0 + 32 ). l2 = s0. IF s0 <> 0.
    s0 = l2. s0 = mem_ld_i32( s0 + 4 ). l3 = s0. IF s0 <> 0.
      s0 = l2. s0 = mem_ld_i32( s0 ). l4 = s0. s1 = l3. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l3. s1 = l4. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l2. s1 = 0. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l2. s1 = 0.
      mem_st_i32( iv_addr = s0 iv_val = s1 ).
    ELSE. ENDIF. s0 = l2. s0 = mem_ld_i32( s0 + 12 ). l3 = s0. s1 = l3. s1 = mem_ld_i32( s1 ). l4 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l4. s1 = 1. IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = l3. s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = -4294967296. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). PERFORM f453 USING s0 s1.
    ELSE. ENDIF. s0 = p0. s1 = 16. s0 = s0 + s1. s1 = l2. s2 = p0. s2 = mem_ld_i32( s2 + 4 ). DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
  ELSE. ENDIF.
ENDFORM.

FORM f1007 USING p0 TYPE f CHANGING rv TYPE f.
  DATA:  l1 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = abs( s0 ). p0 = s0. s0 = zcl_wasm_rt=>reinterpret_f64_i64( s0 ). s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). l1 = s0. s1 = 1072049729.
    IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = '1.000000'. s1 = l1. s2 = 1045430272. IF zcl_wasm_rt=>lt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. PERFORM f379 USING s0 CHANGING s0. p0 = s0.
      s1 = p0. s0 = s0 * s1. s1 = p0. s2 = '1.000000'. s1 = s1 + s2. p0 = s1. s2 = p0. s1 = s1 + s2. s0 = s0 / s1. s1 = '1.000000'. s0 = s0 + s1. rv = s0. RETURN.
    ELSE. ENDIF. s0 = l1. s1 = 1082535489. IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. PERFORM f532 USING s0 CHANGING s0. p0 = s0. s1 = '1.000000'. s2 = p0. s1 = s1 / s2. s0 = s0 + s1. s1 = '0.500000'. s0 = s0 * s1. rv = s0. RETURN.
    ELSE. ENDIF. s0 = p0. PERFORM f1290 USING s0 CHANGING s0.
  ENDDO. rv = s0.
ENDFORM.

FORM f1008 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i, s17 TYPE i,
       lv_br TYPE i.
  s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). l4 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l4. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = l4. PERFORM f581 USING s0 s1 CHANGING s0. s1 = 0. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. s0 = zcl_wasm_rt=>extend_u32( s0 ). s1 = 4294967296. s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). l4 = s0. s0 = p1.
  s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 12884901888. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l4. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s1 = p1. s2 = 6. PERFORM f508 USING s0 s1 s2 CHANGING s0. p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 25769803776. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = p1. s2 = l4. PERFORM f865 USING s0 s1 s2.
  ELSE. ENDIF. s0 = p1. rv = s0.
ENDFORM.

FORM f1009 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l2 = s0. s1 = l2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = -1. l2 = s0. DO 1 TIMES. " block
    s0 = p0. s1 = l3. s2 = 12. s1 = s1 + s2. s2 = p1. PERFORM f684 USING s0 s1 s2 CHANGING s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 + 12 ). l2 = s0. s1 = 37. s0 = s0 - s1. s1 = -36.
    IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 1151331. s2 = 0. PERFORM f975 USING s0 s1 s2. s0 = -1. l2 = s0.
  ENDDO. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l2. rv = s0.
ENDFORM.

FORM f1010 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i p4 TYPE i p5 TYPE i CHANGING rv TYPE int8.
  DATA:  l6 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = p5. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 16 ). p0 = s0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 128 ). l6 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
    IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l6. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). p2 = s1. s2 = 1.
    s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p2. s1 = 1. IF s0 > s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = l6. PERFORM f453 USING s0 s1.
  ENDDO. s0 = p0. s1 = p1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 128 CHANGING cv_mem = mv_mem ). s0 = 25769803776. rv = s0.
ENDFORM.

FORM f1011 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s1 = 11. s0 = s0 + s1. s1 = 17.
    IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
      s1 = 4. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ).
      s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p2. s1 = 11. s0 = s0 + s1. s1 = 17.
      IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ENDDO. s0 = p0. s1 = 1140650. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. p1 = s0.
  ENDDO. s0 = p1. rv = s0.
ENDFORM.

FORM f1012 USING p0 TYPE f p1 TYPE i CHANGING rv TYPE f.
  DATA:  l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = zcl_wasm_rt=>reinterpret_f64_i64( s0 ). l3 = s0. s1 = 52. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 2047. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). l2 = s0.
  s1 = 2047. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l2. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = '0.000000'. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = p1. s1 = 0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. rv = s0. RETURN.
      ELSE. ENDIF. s0 = p0. s1 = '18446744073709551616.000000'. s0 = s0 * s1. s1 = p1. PERFORM f1012 USING s0 s1 CHANGING s0. s1 = p1. s2 = p1. s2 = mem_ld_i32( s2 ). s3 = -64. s2 = s2 + s3. mem_st_i32( iv_addr = s1 iv_val = s2 ).
      rv = s0. RETURN.
    ELSE. ENDIF. s0 = p1. s1 = l2. s2 = 1022. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = -9218868437227405313. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 4602678819172646912.
    s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). s0 = zcl_wasm_rt=>reinterpret_i64_f64( s0 ).
  ELSE.
    s1 = p0.
  ENDIF. rv = s1.
ENDFORM.

FORM f1013 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. DO 1 TIMES. " block
    s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 <> 0.
      s0 = p0. s0 = mem_ld_i32( s0 + 16 ). p1 = s0. s0 = mem_ld_i32_8u( s0 + 136 ). IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p1. s1 = 1. mem_st_i32_8( iv_addr = s0 + 136 iv_val = s1 ). s0 = p0. s1 = 1134898. s2 = 0.
      PERFORM f969 USING s0 s1 s2 CHANGING s0. s0 = p1. s1 = 0. mem_st_i32_8( iv_addr = s0 + 136 iv_val = s1 ). lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = l2. s1 = 1141046. s2 = 1141467. s3 = 1135579. s4 = p1. s5 = 1. s4 = zcl_wasm_rt=>and32( iv_a = s4 iv_b = s5 ). IF s4 <> 0. s2 = s2. ELSE. s2 = s3. ENDIF. s3 = p1. s4 = 2. s3 = zcl_wasm_rt=>and32( iv_a = s3 iv_b = s4 ).
    IF s3 <> 0. s1 = s1. ELSE. s1 = s2. ENDIF. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = 1139235. s2 = l2. PERFORM f975 USING s0 s1 s2.
  ENDDO. s0 = l2. s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1014 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = 0. s1 = p0. s1 = mem_ld_i32( s1 + 8 ). l2 = s1. s2 = p1. IF zcl_wasm_rt=>ge_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = -1. s1 = p0. s1 = mem_ld_i32( s1 + 12 ).
    IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 20 ). s1 = p0. s1 = mem_ld_i32( s1 ). s2 = l2. s3 = 3. s2 = s2 * s3. s3 = 1. s2 = zcl_wasm_rt=>shr_u32( iv_val = s2 iv_shift = s3 ). l2 = s2. s3 = p1. s4 = p1. s5 = l2.
    IF zcl_wasm_rt=>lt_u32( iv_a = s4 iv_b = s5 ) = abap_true. s4 = 1. ELSE. s4 = 0. ENDIF. IF s4 <> 0. s2 = s2. ELSE. s2 = s3. ENDIF. p1 = s2. s3 = p0. s3 = mem_ld_i32( s3 + 16 ). DATA(lv_ci_func) = mt_tab0[ s3 + 1 ]. " call_indirect
    s0 = dispatch_t11( iv_idx = lv_ci_func p0 = s0 p1 = s1 p2 = s2 ). l2 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = 1. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). s0 = -1. rv = s0. RETURN.
    ELSE. ENDIF. s0 = p0. s1 = p1. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p0. s1 = l2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = 0.
  ENDDO. rv = s0.
ENDFORM.

FORM f1015 USING p0 TYPE i p1 TYPE i p2 TYPE int8 p3 TYPE i p4 TYPE i CHANGING rv TYPE i.
  DATA:  l5 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = p2. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p2. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l5 = s0. s1 = l5. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. DO 1 TIMES. " block
    s0 = p0. s1 = p1. s2 = p2. PERFORM f684 USING s0 s1 s2 CHANGING s0. l5 = s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
      s0 = p1. s0 = mem_ld_i32( s0 ). p0 = s0. s1 = 0. IF s0 < s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = p0. s1 = p4. s0 = s0 + s1. p0 = s0. s1 = 0. s2 = p0. s3 = 0. IF s2 > s3. s2 = 1. ELSE. s2 = 0. ENDIF. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. p3 = s0. lv_br = 1. EXIT. " br 1
      ELSE. ENDIF. s0 = p0. s1 = p3. IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ENDDO. s0 = p1. s1 = p3. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ENDDO. s0 = l5. rv = s0.
ENDFORM.

FORM f1016 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO. " loop
      s0 = 0. l2 = s0. s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0.
      s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 48. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = l3. s0 = mem_ld_i32( s0 + 32 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = l3. s0 = mem_ld_i32_8u( s0 + 17 ). IF s0 <> 0.
        s0 = p0. s1 = 1134591. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = -1. rv = s0. RETURN.
      ELSE. ENDIF. s0 = l3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). s0 = mem_ld_i32_16u( s0 + 6 ). l2 = s0. s1 = 48. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    ENDDO. s0 = l2. s1 = 2. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. l2 = s0.
  ENDDO. s0 = l2. rv = s0.
ENDFORM.

FORM f1017 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 8 ). l2 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 12 ). IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = -1. s1 = p0. s2 = l2. s3 = 1. s2 = s2 + s3. s3 = p1. PERFORM f628 USING s1 s2 s3 CHANGING s1. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ELSE. ENDIF. s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 8 ). l3 = s1. s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 4 ). s1 = 16. s0 = s0 + s1. l2 = s0. DO 1 TIMES. " block
      s0 = p0. s0 = mem_ld_i32( s0 + 16 ). IF s0 <> 0.
        s0 = l2. s1 = l3. s2 = 1. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s1 = p1. mem_st_i32_16( iv_addr = s0 iv_val = s1 ). lv_br = 1. EXIT. " br 1
      ELSE. ENDIF. s0 = l2. s1 = l3. s0 = s0 + s1. s1 = p1. mem_st_i32_8( iv_addr = s0 iv_val = s1 ).
    ENDDO. s0 = 0.
  ENDDO. rv = s0.
ENDFORM.

FORM f1018 USING p0 TYPE i p1 TYPE i p2 TYPE int8 p3 TYPE int8 p4 TYPE int8 CHANGING rv TYPE i.
  DATA:  l5 TYPE i, l6 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, lv_br TYPE i.
  s0 = p2. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p2. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l5 = s0. s1 = l5. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. DO 1 TIMES. " block
    s0 = p0. s1 = p1. s2 = p2. PERFORM f719 USING s0 s1 s2 CHANGING s0. p0 = s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p2 = s0. s1 = 0.
    IF s0 < s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p1. s1 = p2. s2 = p4. s1 = s1 + s2. p2 = s1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ).
    ELSE. ENDIF. s0 = p2. s1 = 0. IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p3. l6 = s0. s1 = p2. IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ELSE. ENDIF. s0 = p1. s1 = l6. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ).
  ENDDO. s0 = p0. rv = s0.
ENDFORM.

FORM f1019 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = p0. s0 = mem_ld_i32( s0 + 80 ). l2 = s0. s1 = 256. s0 = s0 + s1. l4 = s0. s0 = l2. s0 = mem_ld_i32( s0 + 284 ). s1 = p0. s1 = mem_ld_i32( s1 + 4 ).
  IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l4. s1 = 200. PERFORM f908 USING s0 s1. s0 = l3. s1 = p0. s1 = mem_ld_i32( s1 + 4 ). mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). s0 = l4. s1 = l3. s2 = 12. s1 = s1 + s2. s2 = 4. PERFORM f1097 USING s0 s1 s2. s0 = l2. s1 = p0.
    s1 = mem_ld_i32( s1 + 4 ). mem_st_i32( iv_addr = s0 + 284 iv_val = s1 ).
  ELSE. ENDIF. s0 = l2. s1 = l2. s2 = 260. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). mem_st_i32( iv_addr = s0 + 280 iv_val = s1 ). s0 = l4. s1 = p1. PERFORM f908 USING s0 s1. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1020 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i, s17 TYPE i,
       s18 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = p1. s2 = 57. s3 = p1. s4 = 0. PERFORM f192 USING s0 s1 s2 s3 s4 CHANGING s0. l4 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 25769803776. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l4. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s1 = l4. s2 = p1. s3 = 12884901888. s4 = 0. s5 = 0. s6 = 2. PERFORM f0 USING s0 s1 s2 s3 s4 s5 s6 CHANGING s0. DO 1 TIMES. " block
    s1 = l4. s2 = 32. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = -11. IF zcl_wasm_rt=>lt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF.
    IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = l4. s1 = zcl_wasm_rt=>wrap_i64( s1 ). p2 = s1. s2 = p2. s2 = mem_ld_i32( s2 ). p2 = s2. s3 = 1. s2 = s2 - s3. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = p2. s2 = 1.
    IF s1 > s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p0. s1 = mem_ld_i32( s1 + 16 ). s2 = l4. PERFORM f453 USING s1 s2.
  ENDDO. rv = s0.
ENDFORM.

FORM f1021 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l2 = s0. s1 = l2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = -1. l2 = s0. DO 1 TIMES. " block
    s0 = p0. s1 = l3. s2 = 12. s1 = s1 + s2. s2 = p1. PERFORM f684 USING s0 s1 s2 CHANGING s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 + 12 ). l2 = s0. s1 = 7.
    IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 1146078. s2 = 0. PERFORM f975 USING s0 s1 s2. s0 = -1. l2 = s0.
  ENDDO. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l2. rv = s0.
ENDFORM.

FORM f1022 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i p4 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -4294967297. IF zcl_wasm_rt=>le_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p4. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = 4294967296. rv = s0. RETURN.
    ELSE. ENDIF. s0 = p0. s1 = 1137529. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ELSE. ENDIF. DO 1 TIMES. " block
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 48. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p2. s0 = mem_ld_i32_8u( s0 + 5 ). s1 = 1. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). p3 = s0. lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = p0. s1 = p1. PERFORM f578 USING s0 s1 CHANGING s0. p3 = s0. s1 = 0. IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p3. s1 = 0. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. s0 = zcl_wasm_rt=>extend_u32( s0 ). s1 = 4294967296. s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). rv = s0.
ENDFORM.

FORM f1023 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 1. s0 = s0 + s1. CASE s0.
          WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 2. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
        ENDCASE.
      ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 6. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2.
      s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 4294967296. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ENDDO. s0 = p0. s1 = 1142171. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 25769803776. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 3. s2 = 2. s3 = p1. s3 = zcl_wasm_rt=>wrap_i64( s3 ). IF s3 <> 0. s1 = s1. ELSE. s1 = s2. ENDIF. s2 = 1. PERFORM f772 USING s0 s1 s2 CHANGING s0.
  ELSE.
    s1 = p1.
  ENDIF. rv = s1.
ENDFORM.

FORM f1024 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. s1 = 0. IF s0 > s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    DO 1 TIMES. " block
      s0 = p2. s0 = mem_ld_i32_8u( s0 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. s0 = s0 + s1. s1 = 1. s0 = s0 - s1. l4 = s0. s1 = p0.
      IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s1 = 1. s0 = s0 + s1. p1 = s0. DO. " loop
        s0 = p0. s1 = l3. mem_st_i32_8( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = 1. s0 = s0 + s1. p0 = s0. s0 = p1. s0 = mem_ld_i32_8u( s0 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
        s0 = p1. s1 = 1. s0 = s0 + s1. p1 = s0. s0 = p0. s1 = l4. IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
      ENDDO.
    ENDDO. s0 = p0. s1 = 0. mem_st_i32_8( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF.
ENDFORM.

FORM f1025 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = p2. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p1. s0 = mem_ld_i32( s0 ). p0 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p1. s0 = mem_ld_i32( s0 + 16 ). p1 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 ). s1 = p1. s2 = 0. s3 = p0. s4 = 4. s3 = s3 + s4. s3 = mem_ld_i32( s3 ). DATA(lv_ci_func) = mt_tab0[ s3 + 1 ]. " call_indirect
      s0 = dispatch_t11( iv_idx = lv_ci_func p0 = s0 p1 = s1 p2 = s2 ). RETURN.
    ELSE. ENDIF. s0 = p1. s1 = 4. s0 = s0 - s1. p1 = s0. s1 = p1. s1 = mem_ld_i32( s1 ). p2 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p2. s1 = 1. IF s0 > s1. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 16 ). s1 = p1. s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = -42949672960. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). PERFORM f453 USING s0 s1.
  ENDDO.
ENDFORM.

FORM f1026 USING p0 TYPE i p1 TYPE int8 p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, l5 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = -1. l4 = s0. DO 1 TIMES. " block
    s0 = p0. s1 = p1. s2 = 0. PERFORM f283 USING s0 s1 s2 CHANGING s0. l5 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 25769803776. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    s0 = p0. s1 = l3. s2 = 12. s1 = s1 + s2. s2 = l5. PERFORM f637 USING s0 s1 s2 CHANGING s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. s2 = 0. s3 = l3. s3 = mem_ld_i32( s3 + 12 ). s4 = p2. s3 = s3 + s4. p0 = s3.
    s3 = zcl_wasm_rt=>extend_u32( s3 ). s4 = 16384. PERFORM f175 USING s0 s1 s2 s3 s4 CHANGING s0. s1 = 0. IF s0 < s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. l4 = s0.
  ENDDO. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l4. rv = s0.
ENDFORM.

FORM f1027 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 32. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = 8. s0 = s0 + s1. l4 = s0. PERFORM f384 USING s0. s0 = 1215076. s0 = mem_ld_i32_8u( s0 ). s0 = 36. PERFORM f18 USING s0 CHANGING s0. l2 = s0.
  IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = 36. PERFORM f687 USING s0. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
  ELSE. ENDIF. s0 = l2. s1 = 1060484. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l2. s1 = p1. mem_st_i32( iv_addr = s0 + 32 iv_val = s1 ). s0 = l2. s1 = p0. mem_st_i32( iv_addr = s0 + 28 iv_val = s1 ). s0 = l2. s1 = l4.
  s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 0 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 4 CHANGING cv_mem = mv_mem ). s0 = l2. s1 = 12. s0 = s0 + s1. s1 = l4. s2 = 8. s1 = s1 + s2.
  RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported s2 = l3. s3 = 32. s2 = s2 + s3. gv_g0 = s2. s2 = l2. rv = s2.
ENDFORM.

FORM f1028 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 32. s0 = s0 - s1. l1 = s0. gv_g0 = s0. s0 = l1. s1 = 8. s0 = s0 + s1. l2 = s0. PERFORM f384 USING s0. s0 = 1215076. s0 = mem_ld_i32_8u( s0 ). s0 = p0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ).
  l3 = s0. s0 = 36. PERFORM f18 USING s0 CHANGING s0. p0 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = 36. PERFORM f687 USING s0. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
  ELSE. ENDIF. s0 = p0. s1 = 1060580. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = l3. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 28 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = l2.
  s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 0 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 4 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = 12. s0 = s0 + s1. s1 = l2. s2 = 8. s1 = s1 + s2.
  RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported s2 = l1. s3 = 32. s2 = s2 + s3. gv_g0 = s2. s2 = p0. rv = s2.
ENDFORM.

FORM f1029 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. IF s0 <> 0.
    DO. " loop
      s0 = p0. s1 = 8. s0 = s0 + s1. l3 = s0. DO 1 TIMES. " block
        s0 = p0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). l4 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
        IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 ). s1 = l4. s1 = zcl_wasm_rt=>wrap_i64( s1 ). l2 = s1. s2 = l2.
        s2 = mem_ld_i32( s2 ). s3 = 1. s2 = s2 - s3. l2 = s2. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = l2. s2 = 0. IF s1 > s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = l4. PERFORM f1384 USING s0 s1.
      ENDDO. s0 = l3. s0 = mem_ld_i32( s0 ). PERFORM f117 USING s0. s0 = p0. s1 = 16. s0 = s0 + s1. p0 = s0. s0 = p1. s1 = 1. s0 = s0 - s1. p1 = s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    ENDDO.
  ELSE. ENDIF.
ENDFORM.

FORM f1030 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE i, l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = 10000. mem_st_i32( iv_addr = s0 + 236 iv_val = s1 ). DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 16 ). l2 = s0. s0 = mem_ld_i32( s0 + 144 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. s1 = l2. s1 = mem_ld_i32( s1 + 148 ). s2 = l3.
    DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect s0 = dispatch_t7( iv_idx = lv_ci_func p0 = s0 p1 = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 1147381. s2 = 0.
    PERFORM f969 USING s0 s1 s2 CHANGING s0. s0 = -1. l1 = s0. s0 = p0. s0 = mem_ld_i32( s0 + 16 ). s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 128 ). l4 = s0. s1 = -4294967296.
    IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l4. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 3.
    IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p0. s1 = mem_ld_i32_8u( s1 + 5 ). s2 = 32. s1 = zcl_wasm_rt=>or32( iv_a = s1 iv_b = s2 ). mem_st_i32_8( iv_addr = s0 + 5 iv_val = s1 ).
  ENDDO. s0 = l1. rv = s0.
ENDFORM.

FORM f1031 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  l4 TYPE int8, l5 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = 25769803776. l4 = s0. s0 = p0. s1 = p1. s2 = p3. s2 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s2 + 0 ). PERFORM f638 USING s0 s1 s2 CHANGING s0. p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ).
  l5 = s0. s1 = 25769803776. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    DO 1 TIMES. " block
      s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). p2 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p2. s1 = 1.
      IF s0 > s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 16 ). s1 = p1. PERFORM f453 USING s0 s1.
    ENDDO. s0 = l5. s1 = 8589934592. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. s0 = zcl_wasm_rt=>extend_u32( s0 ). s1 = 4294967296. s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ).
  ELSE.
    s1 = 25769803776.
  ENDIF. rv = s1.
ENDFORM.

FORM f1032 USING p0 TYPE i p1 TYPE int8 p2 TYPE int8 p3 TYPE i.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p3. s1 = 64. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p3. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p2. s1 = 0. s2 = p3. s1 = s1 - s2. s2 = 63. s1 = zcl_wasm_rt=>and32( iv_a = s1 iv_b = s2 ). s1 = zcl_wasm_rt=>extend_u32( s1 ).
      s0 = zcl_wasm_rt=>shl64( iv_val = s0 iv_shift = s1 ). s1 = p1. s2 = p3. s3 = 63. s2 = zcl_wasm_rt=>and32( iv_a = s2 iv_b = s3 ). s2 = zcl_wasm_rt=>extend_u32( s2 ). l4 = s2. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ).
      s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). p1 = s0. s0 = p2. s1 = l4. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). p2 = s0. lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = p2. s1 = p3. s2 = 63. s1 = zcl_wasm_rt=>and32( iv_a = s1 iv_b = s2 ). s1 = zcl_wasm_rt=>extend_u32( s1 ). s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). p1 = s0. s0 = 0. p2 = s0.
  ENDDO. s0 = p0. s1 = p1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = p2. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 8 CHANGING cv_mem = mv_mem ).
ENDFORM.

FORM f1033 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -42949672960. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
      s1 = 33. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296.
      s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -42949672960. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 lv_br = 1. EXIT. " br 1
    ENDDO. s0 = p0. s1 = 1137006. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. rv = s0.
ENDFORM.

FORM f1034 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -38654705664. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
      s1 = 34. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296.
      s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -38654705664. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 lv_br = 1. EXIT. " br 1
    ENDDO. s0 = p0. s1 = 1137647. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. rv = s0.
ENDFORM.

FORM f1035 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -47244640256. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
      s1 = 36. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296.
      s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -47244640256. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 lv_br = 1. EXIT. " br 1
    ENDDO. s0 = p0. s1 = 1143007. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. rv = s0.
ENDFORM.

FORM f1036 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. s0 = mem_ld_i32_8u( s0 ). l2 = s0. DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32_8u( s0 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. s1 = l3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 1.
    s0 = s0 + s1. p0 = s0. s0 = p1. s1 = 1. s0 = s0 + s1. p1 = s0. DO. " loop
      s0 = p1. s0 = mem_ld_i32_8u( s0 ). l2 = s0. s0 = p0. s0 = mem_ld_i32_8u( s0 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s1 = 1. s0 = s0 + s1. p0 = s0. s0 = p1. s1 = 1.
      s0 = s0 + s1. p1 = s0. s0 = l2. s1 = l3. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    ENDDO.
  ENDDO. s0 = l3. s1 = l2. s0 = s0 - s1. rv = s0.
ENDFORM.

FORM f1037 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. s0 = p0. s0 = mem_ld_i32( s0 + 12 ). l1 = s0. DO 1 TIMES. " block
    DO 1 TIMES. " block
      DO 1 TIMES. " block
        DO 1 TIMES. " block
          DO 1 TIMES. " block
            s0 = p0. s0 = mem_ld_i32( s0 + 4 ). CASE s0.
              WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN OTHERS. lv_br = 2. EXIT.
            ENDCASE.
          ENDDO. s0 = l1. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = 1. s1 = 0. PERFORM f1027 USING s0 s1 CHANGING s0. lv_br = 3. EXIT. " br 3
        ENDDO. s1 = l1. IF s1 = 0. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
      ENDDO. s1 = l2. s2 = 4. s1 = s1 + s2. l1 = s1. s2 = p0. PERFORM f280 USING s1 s2. s1 = l1. PERFORM f989 USING s1 CHANGING s1. lv_br = 1. EXIT. " br 1
    ENDDO. s2 = p0. s2 = mem_ld_i32( s2 ). p0 = s2. s2 = mem_ld_i32( s2 ). s3 = p0. s3 = mem_ld_i32( s3 + 4 ). PERFORM f1027 USING s2 s3 CHANGING s2.
  ENDDO. s3 = l2. s4 = 16. s3 = s3 + s4. gv_g0 = s3. rv = s2.
ENDFORM.

FORM f1038 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 48. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = p1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l3. s1 = p0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = 2. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ).
  s0 = l3. s1 = 1050184. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = l3. s1 = 2. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 20 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s1 = zcl_wasm_rt=>extend_u32( s1 ).
  s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 40 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 4. s1 = s1 + s2. s1 = zcl_wasm_rt=>extend_u32( s1 ).
  s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 32 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 32. s1 = s1 + s2.
  mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = l3. s1 = 8. s0 = s0 + s1. s1 = p2. PERFORM f696 USING s0 s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1039 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. DO 1 TIMES. " block
    s0 = p1. s0 = mem_ld_i32( s0 ). l4 = s0. s0 = mem_ld_i32( s0 ). s1 = 1. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l4. s0 = mem_ld_i32_8u( s0 + 4 ). s1 = 3.
    IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. s1 = 8. s0 = s0 + s1. s1 = l4. s1 = mem_ld_i32( s1 + 8 ). p1 = s1. s1 = mem_ld_i32( s1 ). s2 = p1. s2 = mem_ld_i32( s2 + 4 ).
    s2 = mem_ld_i32( s2 + 24 ). DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ). s0 = l2. s0 = mem_ld_i32( s0 + 12 ). p1 = s0. s0 = l2. s0 = mem_ld_i32( s0 + 8 ). l3 = s0.
  ENDDO. s0 = p0. s1 = p1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = p0. s1 = l3. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l2. s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1040 USING p0 TYPE i p1 TYPE int8 p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 16. s0 = s0 + s1. s0 = mem_ld_i32( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 24 ). s2 = p2. s1 = zcl_wasm_rt=>and32( iv_a = s1 iv_b = s2 ). s2 = -1.
    s1 = zcl_wasm_rt=>xor32( iv_a = s1 iv_b = s2 ). s2 = 2. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s0 = mem_ld_i32( s0 ). l3 = s0. IF s0 <> 0.
      s0 = p0. s1 = 48. s0 = s0 + s1. p0 = s0. DO. " loop
        s0 = 1. s1 = p0. s2 = l3. s3 = 1. s2 = s2 - s3. s3 = 3. s2 = zcl_wasm_rt=>shl32( iv_val = s2 iv_shift = s3 ). s1 = s1 + s2. l3 = s1. s1 = mem_ld_i32( s1 + 4 ). s2 = p2. IF s1 = s2. s1 = 1. ELSE. s1 = 0. ENDIF.
        IF s1 <> 0. lv_br = 2. EXIT. ENDIF. " br_if 2 s0 = l3. s0 = mem_ld_i32( s0 ). s1 = 67108863. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). l3 = s0. IF s0 <> 0. EXIT. ENDIF. " br_if 0
      ENDDO.
    ELSE. ENDIF. s0 = 0.
  ENDDO. rv = s0.
ENDFORM.

FORM f1041 USING p0 TYPE i p1 TYPE i p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, l5 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 + 204 ). s1 = p2. s2 = 3. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s0 = mem_ld_i32( s0 + 4 ). l3 = s0. s1 = -1. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = -1. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s0 = mem_ld_i32( s0 + 116 ). l5 = s0. DO. " loop
    s0 = p2. s1 = l5. s2 = l3. s3 = 4. s2 = zcl_wasm_rt=>shl32( iv_val = s2 iv_shift = s3 ). s1 = s1 + s2. l4 = s1. s1 = mem_ld_i32( s1 + 4 ). IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = -1. rv = s0. RETURN.
    ELSE. ENDIF. s0 = l3. p0 = s0. s0 = p1. s1 = l4. s1 = mem_ld_i32( s1 ). IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = -1. p0 = s0. s0 = l4. s0 = mem_ld_i32( s0 + 8 ). l3 = s0. s1 = -1. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ELSE. ENDIF.
  ENDDO. s0 = p0. rv = s0.
ENDFORM.

FORM f1042 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 8 ). p1 = s0. s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). l4 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ).
  s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l4. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = l4. s2 = p1. s3 = 1. PERFORM f199 USING s0 s1 s2 s3 CHANGING s0. s1 = 0. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. s0 = zcl_wasm_rt=>extend_u32( s0 ). s1 = 4294967296.
  s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). rv = s0.
ENDFORM.

FORM f1043 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 344 ). l4 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 352 ). l3 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 348 ).
    IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 360 ). s1 = p1. IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 356 ). s1 = p2. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. mem_st_i32( iv_addr = s0 + 360 iv_val = s1 ). s0 = p0.
    s1 = p2. mem_st_i32( iv_addr = s0 + 356 iv_val = s1 ). s0 = p0. s1 = l3. s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 352 iv_val = s1 ). s0 = l4. s1 = l3. s2 = 3. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1.
    p0 = s0. s1 = p2. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = p0. s1 = p1. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ENDDO.
ENDFORM.

FORM f1044 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 48. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = p1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l3. s1 = p0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = 2. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ).
  s0 = l3. s1 = 1050580. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = l3. s1 = 2. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 20 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 4. s1 = s1 + s2.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 40 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 32 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 32. s1 = s1 + s2.
  mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = l3. s1 = 8. s0 = s0 + s1. s1 = p2. PERFORM f696 USING s0 s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1045 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 48. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = p1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l3. s1 = p0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = 2. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ).
  s0 = l3. s1 = 1050612. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = l3. s1 = 2. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 20 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 4. s1 = s1 + s2.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 40 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 32 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 32. s1 = s1 + s2.
  mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = l3. s1 = 8. s0 = s0 + s1. s1 = p2. PERFORM f696 USING s0 s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1046 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 48. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = p1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l3. s1 = p0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = 2. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ).
  s0 = l3. s1 = 1050664. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = l3. s1 = 2. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 20 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 4. s1 = s1 + s2.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 40 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3.
  s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 55834574848. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 32 CHANGING cv_mem = mv_mem ). s0 = l3. s1 = l3. s2 = 32. s1 = s1 + s2.
  mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = l3. s1 = 8. s0 = s0 + s1. s1 = p2. PERFORM f696 USING s0 s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1047 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. p0 = s0. gv_g0 = s0. s0 = p0. PERFORM f1068 USING s0. DO 1 TIMES. " block
    s0 = p0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). s1 = 1000. s0 = s0 * s1. s1 = p0. s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 8 ). s2 = 1000. s1 = s1 / s2. s0 = s0 + s1. p1 = s0.
    s1 = 2147483648. s0 = s0 + s1. s1 = 4294967295. IF zcl_wasm_rt=>le_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p1. s1 = 4294967295. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s1 = -51539607552. s2 = p1. s2 = s2. " convert to f64 s2 = zcl_wasm_rt=>reinterpret_f64_i64( s2 ). p1 = s2. s3 = 9221120288580698112. s2 = s2 - s3. s3 = p1. s4 = 9223372036854775807.
    s3 = zcl_wasm_rt=>and64( iv_a = s3 iv_b = s4 ). s4 = 9218868437227405312. IF zcl_wasm_rt=>gt_u64( iv_a = s3 iv_b = s4 ) = abap_true. s3 = 1. ELSE. s3 = 0. ENDIF. IF s3 <> 0. s1 = s1. ELSE. s1 = s2. ENDIF.
  ENDDO. s2 = p0. s3 = 16. s2 = s2 + s3. gv_g0 = s2. rv = s1.
ENDFORM.

FORM f1048 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = 4. s0 = s0 + s1. s0 = mem_ld_i32( s0 ). l2 = s0. s0 = p0. s0 = mem_ld_i32( s0 ). l1 = s0. s0 = mem_ld_i32( s0 ). p0 = s0. s0 = l1. s1 = 0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 ). l1 = s0.
  s0 = p0. s1 = -2147483648. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 4 ). l3 = s0. s0 = l2. s0 = mem_ld_i32( s0 ). p0 = s0. s0 = mem_ld_i32( s0 ). s1 = -2147483648.
  s0 = zcl_wasm_rt=>or32( iv_a = s0 iv_b = s1 ). s1 = -2147483648. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s0 = mem_ld_i32( s0 + 4 ). PERFORM f125 USING s0. s0 = l2. s0 = mem_ld_i32( s0 ). p0 = s0.
  ELSE. ENDIF. s0 = p0. s1 = l3. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 4 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = l1. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = 1. rv = s0.
ENDFORM.

FORM f1049 USING p0 TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      DO 1 TIMES. " block
        DO 1 TIMES. " block
          s0 = p0. s0 = mem_ld_i32( s0 ). p0 = s0. s0 = mem_ld_i32( s0 ). CASE s0.
            WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN OTHERS. lv_br = 3. EXIT.
          ENDCASE.
        ENDDO. s0 = p0. s0 = mem_ld_i32( s0 + 8 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 2. EXIT. ENDIF. " br_if 2 s0 = p0. s0 = mem_ld_i32( s0 + 4 ). l1 = s0. lv_br = 1. EXIT. " br 1
      ENDDO. s0 = p0. s0 = mem_ld_i32_8u( s0 + 4 ). s1 = 3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 + 8 ). l1 = s0. s0 = mem_ld_i32( s0 ). l2 = s0. s1 = l1.
      s2 = 4. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). l3 = s1. s1 = mem_ld_i32( s1 ). DATA(lv_ci_func) = mt_tab0[ s1 + 1 ]. " call_indirect dispatch_t2( iv_idx = lv_ci_func p0 = s0 ). s0 = l3. s0 = mem_ld_i32( s0 + 4 ).
      IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. PERFORM f125 USING s0.
    ENDDO. s0 = l1. PERFORM f125 USING s0.
  ENDDO. s0 = p0. PERFORM f125 USING s0.
ENDFORM.

FORM f1050 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
        DO 1 TIMES. " block
          s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). p3 = s0. s1 = 13. s0 = s0 - s1. CASE s0.
            WHEN 0. lv_br = 1. EXIT. WHEN 1. lv_br = 2. EXIT. WHEN 2. lv_br = 2. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN OTHERS. EXIT.
          ENDCASE.
        ENDDO. s0 = p3. s1 = 52. s0 = s0 - s1. CASE s0.
          WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
        ENDCASE.
      ENDDO. s0 = p2. s0 = mem_ld_i32( s0 + 32 ). p2 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = mem_ld_i32_8u( s0 + 16 ). s1 = 1. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ).
      IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = 12884901888. s1 = p2. s1 = mem_ld_i32_8u( s1 + 17 ). s2 = 1. s1 = zcl_wasm_rt=>and32( iv_a = s1 iv_b = s2 ). IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ENDDO. s0 = p0. s1 = 1138092. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776.
  ENDDO. rv = s0.
ENDFORM.

FORM f1051 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 7. s0 = s0 + s1. CASE s0.
          WHEN 0. lv_br = 2. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. lv_br = 1. EXIT. WHEN 5. lv_br = 1. EXIT. WHEN 6. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
        ENDCASE.
      ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 5. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2.
      s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -30064771072. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. EXIT. ENDIF. " br_if 0 lv_br = 1. EXIT. " br 1
    ENDDO. s0 = p0. s1 = 1143649. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. rv = s0.
ENDFORM.

FORM f1052 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = 8. s0 = s0 + s1. CASE s0.
          WHEN 0. lv_br = 2. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. lv_br = 1. EXIT. WHEN 5. lv_br = 1. EXIT. WHEN 6. lv_br = 1. EXIT. WHEN 7. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
        ENDCASE.
      ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 7. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2.
      s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 32 ). p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -34359738368. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF.
      IF s0 <> 0. EXIT. ENDIF. " br_if 0 lv_br = 1. EXIT. " br 1
    ENDDO. s0 = p0. s1 = 1142341. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ENDDO. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. rv = s0.
ENDFORM.

FORM f1053 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. s0 = p1. s1 = 228. IF s0 >= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s0 = mem_ld_i32( s0 ). s0 = mem_ld_i32( s0 + 16 ). s0 = mem_ld_i32( s0 + 56 ). s1 = p1. s2 = 2. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s0 = mem_ld_i32( s0 ). l3 = s0. s1 = l3. s1 = mem_ld_i32( s1 ).
    s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = 80. s0 = s0 + s1. s0 = mem_ld_i32( s0 ). s1 = l2. s2 = p1. mem_st_i32( iv_addr = s1 + 12 iv_val = s2 ). s1 = 256. s0 = s0 + s1. s1 = l2. s2 = 12. s1 = s1 + s2. s2 = 4. PERFORM f1097 USING s0 s1 s2. s0 = l2.
  s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1054 USING p0 TYPE int8 CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = 0. s1 = p0. s2 = 52. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = 2047. s1 = zcl_wasm_rt=>and32( iv_a = s1 iv_b = s2 ). l1 = s1. s2 = 1023.
    IF zcl_wasm_rt=>lt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = 2. s1 = l1. s2 = 1075.
    IF zcl_wasm_rt=>gt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = 0. s1 = 1. s2 = 1075. s3 = l1. s2 = s2 - s3. s2 = zcl_wasm_rt=>extend_u32( s2 ).
    s1 = zcl_wasm_rt=>shl64( iv_val = s1 iv_shift = s2 ). l2 = s1. s2 = 1. s1 = s1 - s2. s2 = p0. s1 = zcl_wasm_rt=>and64( iv_a = s1 iv_b = s2 ). s2 = 0. IF s1 <> s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = 2.
    s1 = 1. s2 = p0. s3 = l2. s2 = zcl_wasm_rt=>and64( iv_a = s2 iv_b = s3 ). IF s2 = 0. s2 = 1. ELSE. s2 = 0. ENDIF. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF.
  ENDDO. rv = s0.
ENDFORM.

FORM f1055 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. p2 = s0. gv_g0 = s0. s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ).
  s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p3 = s0. s1 = p3. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = p2. s2 = 12. s1 = s1 + s2. s2 = p1. PERFORM f637 USING s0 s1 s2 CHANGING s0. p0 = s0. s0 = p2. s0 = mem_ld_i32( s0 + 12 ). p3 = s0. s0 = p2. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = 25769803776. s1 = p3.
  s1 = zcl_wasm_rt=>clz32( s1 ). s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = p0. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. rv = s0.
ENDFORM.

FORM f1056 USING p0 TYPE i p1 TYPE i p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 16 ). l3 = s0. s1 = 16. s0 = s0 + s1. s1 = p2. s2 = 1. s1 = s1 + s2. s2 = l3. s2 = mem_ld_i32( s2 ). DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect
    s0 = dispatch_t7( iv_idx = lv_ci_func p0 = s0 p1 = s1 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s0 = mem_ld_i32( s0 + 16 ). p1 = s0. s0 = mem_ld_i32_8u( s0 + 136 ). IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p1. s1 = 1. mem_st_i32_8( iv_addr = s0 + 136 iv_val = s1 ). s0 = p0. s1 = 1134898. s2 = 0.
      PERFORM f969 USING s0 s1 s2 CHANGING s0. s0 = p1. s1 = 0. mem_st_i32_8( iv_addr = s0 + 136 iv_val = s1 ). s0 = l3. rv = s0. RETURN.
    ELSE. ENDIF. s0 = l3. s1 = p1. s2 = p2. PERFORM f216 USING s0 s1 s2 CHANGING s0. s1 = p2. s0 = s0 + s1. s1 = 0. mem_st_i32_8( iv_addr = s0 iv_val = s1 ).
  ENDDO. s0 = l3. rv = s0.
ENDFORM.

FORM f1057 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 8589934592. l3 = s0. DO 1 TIMES. " block
    s0 = 18. s1 = p1. s2 = 32. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s1 = zcl_wasm_rt=>wrap_i64( s1 ). l2 = s1. s2 = 11. s1 = s1 + s2. s2 = l2. s3 = 7. s2 = s2 - s3. s3 = -18.
    IF zcl_wasm_rt=>lt_u32( iv_a = s2 iv_b = s3 ) = abap_true. s2 = 1. ELSE. s2 = 0. ENDIF. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. l2 = s0. s1 = 18. IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = 268319. s1 = l2. s0 = zcl_wasm_rt=>shr_u32( iv_val = s0 iv_shift = s1 ). s1 = 1. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 40 ). s1 = l2. s2 = 2. s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s2 = 1195176. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). s2 = 3.
    s1 = zcl_wasm_rt=>shl32( iv_val = s1 iv_shift = s2 ). s0 = s0 + s1. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). l3 = s0.
  ENDDO. s0 = l3. rv = s0.
ENDFORM.

FORM f1058 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = l3. s1 = p1. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). s0 = l3. s1 = p0. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = gv_g0. s1 = 32. s0 = s0 - s1. p0 = s0. gv_g0 = s0.
  s0 = p0. s1 = 1. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = p0. s1 = 1115224. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = 1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 12 CHANGING cv_mem = mv_mem ).
  s0 = p0. s1 = l3. s2 = 8. s1 = s1 + s2. s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = 30064771072. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 24 CHANGING cv_mem = mv_mem ).
  s0 = p0. s1 = p0. s2 = 24. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p0. s1 = p2. PERFORM f696 USING s0 s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1059 USING p0 TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 + 4 ). l1 = s0. s1 = 3. IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. s1 = l1. s2 = 2. IF s1 <> s2. s1 = 1. ELSE. s1 = 0. ENDIF.
  s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 8. s0 = s0 + s1. PERFORM f935 USING s0.
  ELSE. ENDIF. s0 = p0. s0 = mem_ld_i32_8u( s0 + 28 ). s1 = 3. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s0 = mem_ld_i32( s0 + 32 ). l1 = s0. s0 = mem_ld_i32( s0 ). l2 = s0. s1 = l1. s2 = 4. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). l3 = s1. s1 = mem_ld_i32( s1 ). DATA(lv_ci_func) = mt_tab0[ s1 + 1 ]. " call_indirect
    dispatch_t2( iv_idx = lv_ci_func p0 = s0 ). s0 = l3. s0 = mem_ld_i32( s0 + 4 ). IF s0 <> 0.
      s0 = l2. PERFORM f125 USING s0.
    ELSE. ENDIF. s0 = l1. PERFORM f125 USING s0.
  ELSE. ENDIF. s0 = p0. PERFORM f125 USING s0.
ENDFORM.

FORM f1060 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l1 = s0. gv_g0 = s0. DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 32 ). l3 = s0. s1 = -84. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s1 = 59. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = l3. s1 = 125. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 + 64 ). IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = l1. s1 = 59.
      mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = 1153671. s2 = l1. PERFORM f881 USING s0 s1 s2. s0 = -1. l2 = s0. lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = p0. PERFORM f41 USING s0 CHANGING s0. l2 = s0.
  ENDDO. s0 = l1. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l2. rv = s0.
ENDFORM.

FORM f1061 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 ). l2 = s0. s0 = mem_ld_i32( s0 ). l1 = s0. s0 = l2. s1 = 0. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l1. s0 = mem_ld_i32( s0 ). l2 = s0. s0 = l1. s1 = -2147483648. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  s0 = l1. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 4 ). l3 = s0. s0 = p0. s0 = mem_ld_i32( s0 + 4 ). l1 = s0. s0 = mem_ld_i32( s0 ). p0 = s0. s0 = mem_ld_i32( s0 ). s1 = -2147483648.
  s0 = zcl_wasm_rt=>or32( iv_a = s0 iv_b = s1 ). s1 = -2147483648. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s0 = mem_ld_i32( s0 + 4 ). PERFORM f125 USING s0. s0 = l1. s0 = mem_ld_i32( s0 ). p0 = s0.
  ELSE. ENDIF. s0 = p0. s1 = l3. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 4 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = l2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = 1. rv = s0.
ENDFORM.

FORM f1062 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i p4 TYPE i p5 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p5. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1.
    s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 48. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s0 = mem_ld_i32( s0 + 32 ). p3 = s0.
    IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p3. s1 = 1. mem_st_i32_8( iv_addr = s0 + 17 iv_val = s1 ). s0 = p2. s1 = p2. s1 = mem_ld_i32( s1 ). p2 = s1. s2 = 1. s1 = s1 - s2.
    mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p2. s1 = 1. IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s0 = mem_ld_i32( s0 + 16 ). s1 = p1. PERFORM f453 USING s0 s1.
    ELSE. ENDIF. s0 = p5. s1 = 8589934592. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ).
  ENDDO. s0 = 12884901888. rv = s0.
ENDFORM.

FORM f1063 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 12884901888. l4 = s0. DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l2 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). l3 = s0. s1 = 13. s0 = s0 - s1. CASE s0.
          WHEN 0. lv_br = 1. EXIT. WHEN 1. lv_br = 2. EXIT. WHEN 2. lv_br = 2. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN OTHERS. EXIT.
        ENDCASE.
      ENDDO. s0 = l3. s1 = 52. s0 = s0 - s1. CASE s0.
        WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
      ENDCASE.
    ENDDO. s0 = l2. s0 = mem_ld_i32( s0 + 32 ). l2 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. s1 = 18. s0 = s0 + s1. s0 = mem_ld_i32_8u( s0 ). s1 = 4.
    s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = l2. s1 = mem_ld_i32( s1 + 64 ). s2 = 1. PERFORM f772 USING s0 s1 s2 CHANGING s0. l4 = s0.
  ENDDO. s0 = l4. rv = s0.
ENDFORM.

FORM f1064 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = p0. s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 208 ). p1 = s1. s2 = 12. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s2 = p1. s1 = zcl_wasm_rt=>xor64( iv_a = s1 iv_b = s2 ). p1 = s1. s2 = 25.
  s1 = zcl_wasm_rt=>shl64( iv_val = s1 iv_shift = s2 ). s2 = p1. s1 = zcl_wasm_rt=>xor64( iv_a = s1 iv_b = s2 ). p1 = s1. s2 = 27. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s2 = p1.
  s1 = zcl_wasm_rt=>xor64( iv_a = s1 iv_b = s2 ). p1 = s1. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 208 CHANGING cv_mem = mv_mem ). s0 = -51539607552. s1 = p1. s2 = 2685821657736338717. s1 = s1 * s2. s2 = 12.
  s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s2 = 4607182418800017408. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). s1 = zcl_wasm_rt=>reinterpret_i64_f64( s1 ). s2 = '-1.000000'. s1 = s1 + s2.
  s1 = zcl_wasm_rt=>reinterpret_f64_i64( s1 ). p1 = s1. s2 = 9221120288580698112. s1 = s1 - s2. s2 = p1. s3 = 9223372036854775807. s2 = zcl_wasm_rt=>and64( iv_a = s2 iv_b = s3 ). s3 = 9218868437227405312.
  IF zcl_wasm_rt=>gt_u64( iv_a = s2 iv_b = s3 ) = abap_true. s2 = 1. ELSE. s2 = 0. ENDIF. IF s2 <> 0. s0 = s0. ELSE. s0 = s1. ENDIF. rv = s0.
ENDFORM.

FORM f1065 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE int8 p4 TYPE i.
  DATA:  l5 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = -64. s0 = s0 + s1. l5 = s0. gv_g0 = s0. s0 = p2. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p4. PERFORM f117 USING s0. s0 = l5. s1 = p2.
  mem_st_i32( iv_addr = s0 + 56 iv_val = s1 ). s0 = l5. s1 = p3. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 48 CHANGING cv_mem = mv_mem ). s0 = l5. s1 = 12884901888.
  zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 40 CHANGING cv_mem = mv_mem ). s0 = l5. RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported RAISE EXCEPTION TYPE cx_sy_program_error. " SIMD not supported s1 = l5.
  s2 = 12884901888. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s2 iv_addr = s1 + 16 CHANGING cv_mem = mv_mem ). s1 = l5. s2 = 0. mem_st_i32_16( iv_addr = s1 + 8 iv_val = s2 ). s1 = p0. s2 = l5. s3 = 8. s2 = s2 + s3. s3 = p1.
  PERFORM f788 USING s1 s2 s3. s1 = l5. s2 = -64. s1 = s1 - s2. gv_g0 = s1.
ENDFORM.

FORM f1066 USING p0 TYPE i p1 TYPE i p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = p2. IF s0 <> 0.
    DO 1 TIMES. " block
      s0 = p1. IF s0 <> 0.
        s0 = p0. s0 = mem_ld_i32( s0 + 12 ). s1 = p0. s1 = mem_ld_i32( s1 + 8 ). l3 = s1. s0 = s0 - s1. s1 = p2. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
        IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
      ELSE. ENDIF. s0 = p0. s0 = mem_ld_i32( s0 + 28 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = p0. s0 = mem_ld_i32( s0 ). s1 = 1140414. s2 = 0. PERFORM f974 USING s0 s1 s2.
      ELSE. ENDIF. s0 = p0. s1 = -1. mem_st_i32( iv_addr = s0 + 28 iv_val = s1 ). s0 = -1. rv = s0. RETURN.
    ENDDO. s0 = p1. s1 = l3. s2 = p2. PERFORM f216 USING s0 s1 s2 CHANGING s0. s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 8 ). s2 = p2. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ).
  ELSE. ENDIF. s0 = 0. rv = s0.
ENDFORM.

FORM f1067 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. DO 1 TIMES. " block
    DO 1 TIMES. " block
      s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>ge_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). s1 = 21. s0 = s0 - s1. s1 = 65535. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). s1 = 11.
        IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
      ELSE. ENDIF. s0 = l2. s1 = 1135229. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p0. s1 = 1139205. s2 = l2. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. lv_br = 1. EXIT. " br 1
    ENDDO. s1 = l3. s2 = 40. s1 = s1 + s2. s1 = zcl_wasm_rt=>mem_ld_i64_ext( iv_mem = mv_mem iv_addr = s1 + 0 iv_op = 53 ).
  ENDDO. s2 = l2. s3 = 16. s2 = s2 + s3. gv_g0 = s2. rv = s1.
ENDFORM.

FORM f1068 USING p0 TYPE i.
  DATA:  l1 TYPE i, l2 TYPE int8, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l1 = s0. gv_g0 = s0. s0 = p0. IF s0 <> 0.
    s0 = l1. s1 = 0. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 8 CHANGING cv_mem = mv_mem ). s0 = 0. s1 = 1000. s2 = l1. s3 = 8. s2 = s2 + s3. " WASI clock_time_get: return current time in nanoseconds
    GET TIME STAMP FIELD DATA(lv_wasi_ts). DATA(lv_wasi_ns) = CONV int8( lv_wasi_ts * 1000000000 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = lv_wasi_ns iv_addr = s2 CHANGING cv_mem = gv_mem ). s0 = 0. s0 = p0. s1 = l1.
    s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 8 ). l2 = s1. s2 = 1000000000. s1 = zcl_wasm_rt=>div_u64( iv_a = s1 iv_b = s2 ). l3 = s1.
    zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = l2. s2 = l3. s3 = 1000000000. s2 = s2 * s3. s1 = s1 - s2. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = 1000.
    s1 = zcl_wasm_rt=>div_u32( iv_a = s1 iv_b = s2 ). s1 = zcl_wasm_rt=>extend_u32( s1 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 8 CHANGING cv_mem = mv_mem ).
  ELSE. ENDIF. s0 = l1. s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1069 USING p0 TYPE i p1 TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s0 = mem_ld_i32( s0 + 36 ). l2 = s0. s1 = l2. s1 = mem_ld_i32( s1 ). l4 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l4. s1 = 1.
  IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = l2. s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = -30064771072. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). PERFORM f453 USING s0 s1.
  ELSE. ENDIF. s0 = l3. s0 = mem_ld_i32( s0 + 32 ). l2 = s0. s1 = l2. s1 = mem_ld_i32( s1 ). l3 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l3. s1 = 1. IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = l2. s1 = zcl_wasm_rt=>extend_u32( s1 ). s2 = -30064771072. s1 = zcl_wasm_rt=>or64( iv_a = s1 iv_b = s2 ). PERFORM f453 USING s0 s1.
  ELSE. ENDIF.
ENDFORM.

FORM f1070 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i p4 TYPE i p5 TYPE i CHANGING rv TYPE int8.
  DATA:  l6 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p5. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). l6 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
  IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = l6. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p2 = s0. s1 = p2. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = p1. s2 = p0. s3 = l6. PERFORM f581 USING s2 s3 CHANGING s2. PERFORM f505 USING s0 s1 s2 CHANGING s0. rv = s0.
ENDFORM.

FORM f1071 USING p0 TYPE i CHANGING rv TYPE i.
  DATA:  l1 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 60 ). l1 = s1. s2 = 1. s1 = s1 - s2. s2 = l1. s1 = zcl_wasm_rt=>or32( iv_a = s1 iv_b = s2 ). mem_st_i32( iv_addr = s0 + 60 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 ). l1 = s0. s1 = 8.
  s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 <> 0.
    s0 = p0. s1 = l1. s2 = 32. s1 = zcl_wasm_rt=>or32( iv_a = s1 iv_b = s2 ). mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = -1. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s1 = 0. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 4 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 40 ). l1 = s1. mem_st_i32( iv_addr = s0 + 24 iv_val = s1 ). s0 = p0.
  s1 = l1. mem_st_i32( iv_addr = s0 + 20 iv_val = s1 ). s0 = p0. s1 = l1. s2 = p0. s2 = mem_ld_i32( s2 + 44 ). s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = 0. rv = s0.
ENDFORM.

FORM f1072 USING p0 TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    DO 1 TIMES. " block
      s0 = p0. s0 = mem_ld_i32( s0 ). l1 = s0. s1 = -2147483648. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = l1. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 2. EXIT. ENDIF. " br_if 2 s0 = p0. s0 = mem_ld_i32( s0 + 4 ). p0 = s0. lv_br = 1. EXIT. " br 1
      ELSE. ENDIF. s0 = p0. s0 = mem_ld_i32_8u( s0 + 4 ). s1 = 3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 + 8 ). p0 = s0. s0 = mem_ld_i32( s0 ). l1 = s0. s1 = p0.
      s2 = 4. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). l2 = s1. s1 = mem_ld_i32( s1 ). DATA(lv_ci_func) = mt_tab0[ s1 + 1 ]. " call_indirect dispatch_t2( iv_idx = lv_ci_func p0 = s0 ). s0 = l2. s0 = mem_ld_i32( s0 + 4 ).
      IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l1. PERFORM f125 USING s0.
    ENDDO. s0 = p0. PERFORM f125 USING s0.
  ENDDO.
ENDFORM.

FORM f1073 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 12884901888. l3 = s0. DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). l2 = s0. s1 = 13. s0 = s0 - s1. CASE s0.
          WHEN 0. lv_br = 1. EXIT. WHEN 1. lv_br = 2. EXIT. WHEN 2. lv_br = 2. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN OTHERS. EXIT.
        ENDCASE.
      ENDDO. s0 = l2. s1 = 52. s0 = s0 - s1. CASE s0.
        WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
      ENDCASE.
    ENDDO. s0 = p0. s0 = mem_ld_i32( s0 + 32 ). p0 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 18. s0 = s0 + s1. s0 = mem_ld_i32_8u( s0 ). s1 = 4.
    s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 68. s0 = s0 + s1. s0 = zcl_wasm_rt=>mem_ld_i64_ext( iv_mem = mv_mem iv_addr = s0 + 0 iv_op = 53 ).
    l3 = s0.
  ENDDO. s0 = l3. rv = s0.
ENDFORM.

FORM f1074 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 12884901888. l3 = s0. DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO 1 TIMES. " block
      DO 1 TIMES. " block
        s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s0 = mem_ld_i32_16u( s0 + 6 ). l2 = s0. s1 = 13. s0 = s0 - s1. CASE s0.
          WHEN 0. lv_br = 1. EXIT. WHEN 1. lv_br = 2. EXIT. WHEN 2. lv_br = 2. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN OTHERS. EXIT.
        ENDCASE.
      ENDDO. s0 = l2. s1 = 52. s0 = s0 - s1. CASE s0.
        WHEN 0. EXIT. WHEN 1. lv_br = 1. EXIT. WHEN 2. lv_br = 1. EXIT. WHEN 3. lv_br = 1. EXIT. WHEN 4. EXIT. WHEN OTHERS. lv_br = 1. EXIT.
      ENDCASE.
    ENDDO. s0 = p0. s0 = mem_ld_i32( s0 + 32 ). p0 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 18. s0 = s0 + s1. s0 = mem_ld_i32_8u( s0 ). s1 = 4.
    s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = 72. s0 = s0 + s1. s0 = zcl_wasm_rt=>mem_ld_i64_ext( iv_mem = mv_mem iv_addr = s0 + 0 iv_op = 53 ).
    l3 = s0.
  ENDDO. s0 = l3. rv = s0.
ENDFORM.

FORM f1075 USING p0 TYPE i p1 TYPE i p2 TYPE i p3 TYPE i.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, lv_br TYPE i.
  s0 = p0. DO 1 TIMES. " block
    DO 1 TIMES. " block
      s1 = p1. s2 = p2. s3 = p3. PERFORM f126 USING s1 s2 s3 CHANGING s1. l4 = s1. s2 = -4294967296. s1 = zcl_wasm_rt=>and64( iv_a = s1 iv_b = s2 ). s2 = 25769803776. IF s1 = s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0.
        s1 = p1. s1 = mem_ld_i32( s1 + 16 ). s1 = mem_ld_i32( s1 + 376 ). p2 = s1. s1 = mem_ld_i32( s1 ). s2 = p2. s3 = 0. mem_st_i32( iv_addr = s2 iv_val = s3 ). IF s1 = 0. s1 = 1. ELSE. s1 = 0. ENDIF.
        IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s1 = p2. s1 = mem_ld_i32( s1 + 4 ). PERFORM f1168 USING s1. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
      ELSE. ENDIF. s1 = p0. s2 = p1. mem_st_i32( iv_addr = s1 + 16 iv_val = s2 ). s1 = 18. lv_br = 1. EXIT. " br 1
    ENDDO. s2 = p1. PERFORM f117 USING s2. s2 = 9.
  ENDDO. mem_st_i32_8( iv_addr = s1 iv_val = s2 ). s1 = p0. s2 = l4. zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s2 iv_addr = s1 + 8 CHANGING cv_mem = mv_mem ).
ENDFORM.

FORM f1076 USING p0 TYPE i.
  DATA:  l1 TYPE i, l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 + 4 ). l1 = s0. s1 = 3. IF zcl_wasm_rt=>le_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. s1 = l1. s2 = 2. IF s1 <> s2. s1 = 1. ELSE. s1 = 0. ENDIF.
  s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 8. s0 = s0 + s1. PERFORM f935 USING s0.
  ELSE. ENDIF. s0 = p0. s0 = mem_ld_i32_8u( s0 + 28 ). s1 = 3. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s0 = mem_ld_i32( s0 + 32 ). p0 = s0. s0 = mem_ld_i32( s0 ). l1 = s0. s1 = p0. s2 = 4. s1 = s1 + s2. s1 = mem_ld_i32( s1 ). l2 = s1. s1 = mem_ld_i32( s1 ). DATA(lv_ci_func) = mt_tab0[ s1 + 1 ]. " call_indirect
    dispatch_t2( iv_idx = lv_ci_func p0 = s0 ). s0 = l2. s0 = mem_ld_i32( s0 + 4 ). IF s0 <> 0.
      s0 = l1. PERFORM f125 USING s0.
    ELSE. ENDIF. s0 = p0. PERFORM f125 USING s0.
  ELSE. ENDIF.
ENDFORM.

FORM f1077 USING p0 TYPE i p1 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = p1. PERFORM f151 USING s0 s1 CHANGING s0. p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 25769803776. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s1 = p1. PERFORM f820 USING s0 s1 CHANGING s0. DO 1 TIMES. " block
    s1 = p1. s2 = 32. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = -11. IF zcl_wasm_rt=>lt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF.
    IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). l2 = s1. s2 = l2. s2 = mem_ld_i32( s2 ). l2 = s2. s3 = 1. s2 = s2 - s3. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = l2. s2 = 1.
    IF s1 > s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p0. s1 = mem_ld_i32( s1 + 16 ). s2 = p1. PERFORM f453 USING s1 s2.
  ENDDO. rv = s0.
ENDFORM.

FORM f1078 USING p0 TYPE i p1 TYPE i p2 TYPE i CHANGING rv TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l3 = s0. gv_g0 = s0. s0 = -1. l4 = s0. DO 1 TIMES. " block
    s0 = p2. s1 = 0. IF s0 < s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = 1215576. s1 = 28. mem_st_i32( iv_addr = s0 iv_val = s1 ). lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = p0. s1 = p1. s2 = p2. s3 = l3. s4 = 12. s3 = s3 + s4. " WASI fd_write: fd=s0 iovs=s1 iovs_len=s2 nwritten=s3 DATA lv_wasi_written TYPE i. DATA lv_wasi_iov_ptr TYPE i. DATA lv_wasi_iov_len TYPE i.
    DATA lv_wasi_str_ptr TYPE i. DATA lv_wasi_str_len TYPE i. lv_wasi_written = 0. DO s2 TIMES.
      lv_wasi_iov_ptr = s1 + ( sy-index - 1 ) * 8. PERFORM mem_ld_i32 USING lv_wasi_iov_ptr CHANGING lv_wasi_str_ptr. PERFORM mem_ld_i32 USING lv_wasi_iov_ptr + 4 CHANGING lv_wasi_str_len. IF lv_wasi_str_len > 0.
        DATA(lv_wasi_bytes) = gv_mem+lv_wasi_str_ptr(lv_wasi_str_len). " Output bytes (could be WRITE or collect in buffer)
      ENDIF. lv_wasi_written = lv_wasi_written + lv_wasi_str_len.
    ENDDO. PERFORM mem_st_i32 USING s3 lv_wasi_written. s0 = 0. " errno = success s1 = 65535. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). p0 = s0. IF s0 <> 0.
      s0 = 1215576. s1 = p0. mem_st_i32( iv_addr = s0 iv_val = s1 ). lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = l3. s0 = mem_ld_i32( s0 + 12 ). l4 = s0.
  ENDDO. s0 = l3. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l4. rv = s0.
ENDFORM.

FORM f1079 USING p0 TYPE i p1 TYPE int8 p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
    s1 = 48. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 + 32 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3.
    s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -8589934592. IF zcl_wasm_rt=>ge_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = p2. DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
    ELSE. ENDIF. s0 = l3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 8 ). p1 = s0. s1 = -8589934592. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = p2. DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
  ENDDO.
ENDFORM.

FORM f1080 USING p0 TYPE i p1 TYPE int8 p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
    s1 = 55. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 + 32 ). l3 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3.
    s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -8589934592. IF zcl_wasm_rt=>ge_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = p2. DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
    ELSE. ENDIF. s0 = l3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 8 ). p1 = s0. s1 = -8589934592. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF.
    IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = p2. DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
  ENDDO.
ENDFORM.

FORM f1081 USING p0 TYPE i p1 TYPE int8 p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. p0 = s0. gv_g0 = s0. s0 = 1214956. s0 = mem_ld_i32_8u( s0 ). s1 = 3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 1214952. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). s0 = p0. s1 = 12. s0 = s0 + s1. PERFORM f812 USING s0.
  ELSE. ENDIF. s0 = 1214952. s0 = mem_ld_i32( s0 ). p2 = s0. DO 1 TIMES. " block
    s0 = p1. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p2. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). l3 = s1.
    s1 = mem_ld_i32_16u( s1 + 6 ). IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l3. s0 = mem_ld_i32( s0 + 32 ).
  ENDDO. s0 = p0. s1 = 16. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1082 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. s0 = p1. s0 = mem_ld_i32_8u( s0 ). s1 = 3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = 0.
  ELSE.
    s1 = l2. s2 = 8. s1 = s1 + s2. s2 = p1. s2 = mem_ld_i32( s2 + 4 ). p1 = s2. s2 = mem_ld_i32( s2 ). s3 = p1. s3 = mem_ld_i32( s3 + 4 ). s3 = mem_ld_i32( s3 + 36 ). DATA(lv_ci_func) = mt_tab0[ s3 + 1 ]. " call_indirect
    dispatch_t6( iv_idx = lv_ci_func p0 = s1 p1 = s2 ). s1 = l2. s1 = mem_ld_i32( s1 + 12 ). l3 = s1. s1 = l2. s1 = mem_ld_i32( s1 + 8 ).
  ENDIF. p1 = s1. s1 = p0. s2 = l3. mem_st_i32( iv_addr = s1 + 4 iv_val = s2 ). s1 = p0. s2 = p1. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = l2. s2 = 16. s1 = s1 + s2. gv_g0 = s1.
ENDFORM.

FORM f1083 USING p0 TYPE i p1 TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. s0 = p1. s0 = mem_ld_i32_8u( s0 ). s1 = 3. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = 0.
  ELSE.
    s1 = l2. s2 = 8. s1 = s1 + s2. s2 = p1. s2 = mem_ld_i32( s2 + 4 ). p1 = s2. s2 = mem_ld_i32( s2 ). s3 = p1. s3 = mem_ld_i32( s3 + 4 ). s3 = mem_ld_i32( s3 + 24 ). DATA(lv_ci_func) = mt_tab0[ s3 + 1 ]. " call_indirect
    dispatch_t6( iv_idx = lv_ci_func p0 = s1 p1 = s2 ). s1 = l2. s1 = mem_ld_i32( s1 + 12 ). l3 = s1. s1 = l2. s1 = mem_ld_i32( s1 + 8 ).
  ENDIF. p1 = s1. s1 = p0. s2 = l3. mem_st_i32( iv_addr = s1 + 4 iv_val = s2 ). s1 = p0. s2 = p1. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = l2. s2 = 16. s1 = s1 + s2. gv_g0 = s1.
ENDFORM.

FORM f1084 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. IF s0 <> 0.
    DO 1 TIMES. " block
      s0 = p0. s0 = mem_ld_i32( s0 + 8 ). s1 = p0. s1 = mem_ld_i32( s1 + 4 ). l2 = s1. s2 = p1. s1 = s1 + s2. IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
      s0 = p1. PERFORM f18 USING s0 CHANGING s0. p1 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = l2. s2 = 8. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = p0. s1 = p0.
      s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. l3 = s0.
    ENDDO. s0 = l3. rv = s0. RETURN.
  ELSE. ENDIF. s0 = 1152242. s1 = 1148333. s2 = 1728. s3 = 1148235. PERFORM f1101 USING s0 s1 s2 s3. RAISE EXCEPTION TYPE cx_sy_program_error. " unreachable
ENDFORM.

FORM f1085 USING p0 TYPE i p1 TYPE int8 p2 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l3 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, s14 TYPE i, s15 TYPE i, s16 TYPE i, s17 TYPE i,
       s18 TYPE i, lv_br TYPE i.
  s0 = 12884901888. l3 = s0. s0 = p1. s1 = 4294967296. s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ). s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 12884901888. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 1137529. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p2. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = 8589934592. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. s1 = p2. s2 = -4294967297.
  IF zcl_wasm_rt=>le_u64( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). IF s0 <> 0.
    s0 = 12884901888.
  ELSE.
    s1 = 25769803776. s2 = 12884901888. s3 = p0. s4 = p1. s5 = p2. s6 = 1. PERFORM f259 USING s3 s4 s5 s6 CHANGING s3. s4 = 0. IF s3 < s4. s3 = 1. ELSE. s3 = 0. ENDIF. IF s3 <> 0. s1 = s1. ELSE. s1 = s2. ENDIF.
  ENDIF. rv = s1.
ENDFORM.

FORM f1086 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 4 ). l3 = s0. s1 = p2. s0 = s0 + s1. l4 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 8 ). IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = -1. s1 = p0. s2 = l4. PERFORM f1014 USING s1 s2 CHANGING s1. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = p0. s0 = mem_ld_i32( s0 + 4 ).
    ELSE.
      s1 = l3.
    ENDIF. s2 = p0. s2 = mem_ld_i32( s2 ). l3 = s2. s1 = s1 + s2. s2 = p1. s3 = l3. s2 = s2 + s3. s3 = p2. PERFORM f216 USING s1 s2 s3 CHANGING s1. s1 = p0. s2 = p0. s2 = mem_ld_i32( s2 + 4 ). s3 = p2. s2 = s2 + s3.
    mem_st_i32( iv_addr = s1 + 4 iv_val = s2 ). s1 = 0.
  ENDDO.
ENDFORM.

FORM f1087 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE i CHANGING rv TYPE int8.
  DATA:  l4 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, s12 TYPE i, s13 TYPE i, lv_br TYPE i.
  s0 = p3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -4294967296. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -34359738368. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = 1142341. s2 = 0. PERFORM f970 USING s0 s1 s2 CHANGING s0. s0 = 25769803776. rv = s0. RETURN.
  ELSE. ENDIF. s0 = 12884901888. l4 = s0. s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). p0 = s0. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 4 ). s1 = -4611686018427387904. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ).
  s1 = -9223372036854775808. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = p1. s1 = 4294967295. s0 = zcl_wasm_rt=>and64( iv_a = s0 iv_b = s1 ). s1 = -30064771072.
    s0 = zcl_wasm_rt=>or64( iv_a = s0 iv_b = s1 ).
  ELSE.
    s1 = 12884901888.
  ENDIF. rv = s1.
ENDFORM.

FORM f1088 USING p0 TYPE i p1 TYPE int8.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). s0 = mem_ld_i32( s0 + 32 ). l3 = s0. IF s0 <> 0.
    DO 1 TIMES. " block
      s0 = l3. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
      IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l2 = s0. s1 = l2. s1 = mem_ld_i32( s1 ). l2 = s1. s2 = 1.
      s1 = s1 - s2. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = l2. s1 = 1. IF s0 > s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p1. PERFORM f453 USING s0 s1.
    ENDDO. s0 = p0. s1 = 16. s0 = s0 + s1. s1 = l3. s2 = p0. s2 = mem_ld_i32( s2 + 4 ). DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ).
  ELSE. ENDIF.
ENDFORM.

FORM f1089 USING p0 TYPE i p1 TYPE int8 p2 TYPE i CHANGING rv TYPE int8.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 + 56 ). l3 = s0. s0 = gv_g0. s1 = 16. s0 = s0 - s1. p0 = s0. gv_g0 = s0. DO 1 TIMES. " block
    s0 = l3. s1 = p1. s2 = p2. s3 = 255. s2 = zcl_wasm_rt=>and32( iv_a = s2 iv_b = s3 ). s3 = p0. s4 = 8. s3 = s3 + s4. s0 = 8. " WASI fd_seek: EBADF s1 = 65535. s0 = zcl_wasm_rt=>and32( iv_a = s0 iv_b = s1 ). p2 = s0. IF s0 <> 0.
      s0 = 1215576. s1 = 70. s2 = p2. s3 = p2. s4 = 76. IF s3 = s4. s3 = 1. ELSE. s3 = 0. ENDIF. IF s3 <> 0. s1 = s1. ELSE. s1 = s2. ENDIF. mem_st_i32( iv_addr = s0 iv_val = s1 ). s0 = -1. lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s1 = p0. s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 8 ).
  ENDDO. s2 = p0. s3 = 16. s2 = s2 + s3. gv_g0 = s2. rv = s1.
ENDFORM.

FORM f1090 USING p0 TYPE i p1 TYPE int8 p2 TYPE i.
  DATA:  l3 TYPE i, l4 TYPE i, l5 TYPE i, l6 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l5 = s0. s1 = 40. s0 = s0 + s1. s0 = mem_ld_i32( s0 ). l3 = s0. IF s0 <> 0.
    DO. " loop
      s0 = l5. s0 = mem_ld_i32( s0 + 36 ). s1 = l4. s0 = s0 + s1. s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 0 ). p1 = s0. s1 = -8589934592.
      IF zcl_wasm_rt=>ge_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
        s0 = p0. s1 = p1. s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = p2. DATA(lv_ci_func) = mt_tab0[ s2 + 1 ]. " call_indirect dispatch_t6( iv_idx = lv_ci_func p0 = s0 p1 = s1 ). s0 = l5. s0 = mem_ld_i32( s0 + 40 ). l3 = s0.
      ELSE. ENDIF. s0 = l4. s1 = 8. s0 = s0 + s1. l4 = s0. s0 = l6. s1 = 1. s0 = s0 + s1. l6 = s0. s1 = l3. IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    ENDDO.
  ELSE. ENDIF.
ENDFORM.

FORM f1091 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 16. s0 = s0 - s1. l2 = s0. gv_g0 = s0. s0 = l2. s1 = p0. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). DO 1 TIMES. " block
    s0 = p0. s1 = p1. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 DO. " loop
      s0 = p0. s1 = 6. s2 = l2. s3 = 12. s2 = s2 + s3. PERFORM f787 USING s0 s1 s2 CHANGING s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1 s0 = l3. s1 = 1. s0 = s0 + s1. l3 = s0. s0 = l2.
      s0 = mem_ld_i32( s0 + 12 ). p0 = s0. s1 = p1. IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0
    ENDDO.
  ENDDO. s0 = l2. s1 = 16. s0 = s0 + s1. gv_g0 = s0. s0 = l3. rv = s0.
ENDFORM.

FORM f1092 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = 0. s1 = p0. s1 = mem_ld_i32( s1 + 12 ). s2 = p1. IF s1 = s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 ). l2 = s0. s0 = mem_ld_i32( s0 ). s1 = p0. s1 = mem_ld_i32( s1 + 16 ).
    s2 = p1. s3 = 2. s2 = zcl_wasm_rt=>shl32( iv_val = s2 iv_shift = s3 ). s3 = l2. s4 = 4. s3 = s3 + s4. s3 = mem_ld_i32( s3 ). DATA(lv_ci_func) = mt_tab0[ s3 + 1 ]. " call_indirect
    s0 = dispatch_t11( iv_idx = lv_ci_func p0 = s0 p1 = s1 p2 = s2 ). l2 = s0. s0 = p1. IF s0 <> 0.
      s0 = -1. s1 = l2. IF s1 = 0. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ELSE. ENDIF. s0 = p0. s1 = p1. mem_st_i32( iv_addr = s0 + 12 iv_val = s1 ). s0 = p0. s1 = l2. mem_st_i32( iv_addr = s0 + 16 iv_val = s1 ). s0 = 0.
  ENDDO. rv = s0.
ENDFORM.

FORM f1093 USING p0 TYPE i p1 TYPE i p2 TYPE int8 p3 TYPE i.
  DATA:  l4 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, s11 TYPE i, lv_br TYPE i.
  s0 = gv_g0. s1 = 32. s0 = s0 - s1. l4 = s0. gv_g0 = s0. s0 = l4. s1 = p2. s2 = p3. PERFORM f776 USING s0 s1 s2. DO 1 TIMES. " block
    s0 = l4. s0 = mem_ld_i32_8u( s0 ). s1 = 18. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s1 = l4. s1 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s1 + 4 ). zcl_wasm_rt=>mem_st_i64( EXPORTING iv_val = s1 iv_addr = s0 + 0 CHANGING cv_mem = mv_mem ). s0 = p0. s1 = 8. s0 = s0 + s1. s1 = l4. s2 = 12.
      s1 = s1 + s2. s1 = mem_ld_i32( s1 ). mem_st_i32( iv_addr = s0 iv_val = s1 ). lv_br = 1. EXIT. " br 1
    ELSE. ENDIF. s0 = p0. s1 = p1. s2 = p2. s3 = l4. PERFORM f363 USING s0 s1 s2 s3.
  ENDDO. s0 = l4. s1 = 32. s0 = s0 + s1. gv_g0 = s0.
ENDFORM.

FORM f1094 USING p0 TYPE i.
  DATA:  l1 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 ). p0 = s0. s0 = mem_ld_i32( s0 + 16 ). s1 = 1. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = mem_ld_i32( s0 + 20 ). l1 = s0. s1 = 0.
    mem_st_i32_8( iv_addr = s0 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 24 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l1. PERFORM f125 USING s0.
  ENDDO. DO 1 TIMES. " block
    s0 = p0. s1 = -1. IF s0 = s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 4 ). l1 = s1. s2 = 1. s1 = s1 - s2. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = l1. s1 = 1.
    IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. PERFORM f125 USING s0.
  ENDDO.
ENDFORM.

FORM f1095 USING p0 TYPE int8 CHANGING rv TYPE int8.
  DATA:  l1 TYPE i, l2 TYPE int8, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  s0 = 12884901888. l2 = s0. DO 1 TIMES. " block
    s0 = p0. s1 = -4294967296. IF zcl_wasm_rt=>lt_u64( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = p0. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l1 = s0. s0 = mem_ld_i32_16u( s0 + 6 ).
    s1 = 49. IF s0 <> s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l1. s0 = mem_ld_i32( s0 + 32 ). l1 = s0. IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l1.
    s0 = zcl_wasm_rt=>mem_ld_i64( iv_mem = mv_mem iv_addr = s0 + 24 ). l2 = s0. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11.
    IF zcl_wasm_rt=>lt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0. EXIT. ENDIF. " br_if 0 s0 = l2. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l1 = s0. s1 = l1. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2.
    mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ENDDO. s0 = l2. rv = s0.
ENDFORM.

FORM f1096 USING p0 TYPE i p1 TYPE i CHANGING rv TYPE i.
  DATA:  l2 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = p0. s0 = mem_ld_i32( s0 + 12 ). s1 = p0. s1 = mem_ld_i32( s1 + 8 ). l2 = s1. s0 = s0 - s1. s1 = 0. IF s0 <= s1. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s1 = 0. mem_st_i32_8( iv_addr = s0 iv_val = s1 ). s0 = p0. s0 = mem_ld_i32( s0 + 28 ). IF s0 = 0. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = p0. s0 = mem_ld_i32( s0 ). s1 = 1140414. s2 = 0. PERFORM f974 USING s0 s1 s2.
    ELSE. ENDIF. s0 = p0. s1 = -1. mem_st_i32( iv_addr = s0 + 28 iv_val = s1 ). s0 = -1. rv = s0. RETURN.
  ELSE. ENDIF. s0 = p0. s1 = l2. s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 8 iv_val = s1 ). s0 = p1. s1 = l2. s1 = mem_ld_i32_8u( s1 ). mem_st_i32_8( iv_addr = s0 iv_val = s1 ). s0 = 0. rv = s0.
ENDFORM.

FORM f1097 USING p0 TYPE i p1 TYPE i p2 TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, lv_br TYPE i.
  DO 1 TIMES. " block
    s0 = p0. s0 = mem_ld_i32( s0 + 4 ). s1 = p2. s0 = s0 + s1. l3 = s0. s1 = p0. s1 = mem_ld_i32( s1 + 8 ). IF zcl_wasm_rt=>gt_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
      s0 = -1. s1 = p0. s2 = l3. PERFORM f1014 USING s1 s2 CHANGING s1. IF s1 <> 0. lv_br = 1. EXIT. ENDIF. " br_if 1
    ELSE. ENDIF. s0 = p2. IF s0 <> 0.
      s0 = p0. s0 = mem_ld_i32( s0 ). s1 = p0. s1 = mem_ld_i32( s1 + 4 ). s0 = s0 + s1. s1 = p1. s2 = p2. PERFORM f216 USING s0 s1 s2 CHANGING s0.
    ELSE. ENDIF. s0 = p0. s1 = p0. s1 = mem_ld_i32( s1 + 4 ). s2 = p2. s1 = s1 + s2. mem_st_i32( iv_addr = s0 + 4 iv_val = s1 ). s0 = 0.
  ENDDO.
ENDFORM.

FORM f1098 USING p0 TYPE i p1 TYPE int8 p2 TYPE int8 CHANGING rv TYPE i.
  DATA:  l3 TYPE i, s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, lv_br TYPE i.
  s0 = p1. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p1. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s1 = l3. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p2. s1 = 32. s0 = zcl_wasm_rt=>shr_u64( iv_val = s0 iv_shift = s1 ). s0 = zcl_wasm_rt=>wrap_i64( s0 ). s1 = -11. IF zcl_wasm_rt=>ge_u32( iv_a = s0 iv_b = s1 ) = abap_true. s0 = 1. ELSE. s0 = 0. ENDIF. IF s0 <> 0.
    s0 = p2. s0 = zcl_wasm_rt=>wrap_i64( s0 ). l3 = s0. s1 = l3. s1 = mem_ld_i32( s1 ). s2 = 1. s1 = s1 + s2. mem_st_i32( iv_addr = s0 iv_val = s1 ).
  ELSE. ENDIF. s0 = p0. s1 = p1. s2 = p2. s3 = 1. PERFORM f199 USING s0 s1 s2 s3 CHANGING s0. rv = s0.
ENDFORM.

FORM f1099 USING p0 TYPE i p1 TYPE int8 p2 TYPE i p3 TYPE int8 p4 TYPE i CHANGING rv TYPE i.
  DATA:  s0 TYPE i, s1 TYPE i, s2 TYPE i, s3 TYPE i, s4 TYPE i, s5 TYPE i, s6 TYPE i, s7 TYPE i, s8 TYPE i, s9 TYPE i, s10 TYPE i, lv_br TYPE i.
  s0 = p0. s1 = p1. s2 = p2. s3 = p3. s4 = 12884901888. s5 = 12884901888. s6 = p4. s7 = 9984. s6 = zcl_wasm_rt=>or32( iv_a = s6 iv_b = s7 ). PERFORM f37 USING s0 s1 s2 s3 s4 s5 s6 CHANGING s0. DO 1 TIMES. " block
    s1 = p3. s2 = 32. s1 = zcl_wasm_rt=>shr_u64( iv_val = s1 iv_shift = s2 ). s1 = zcl_wasm_rt=>wrap_i64( s1 ). s2 = -11. IF zcl_wasm_rt=>lt_u32( iv_a = s1 iv_b = s2 ) = abap_true. s1 = 1. ELSE. s1 = 0. ENDIF.
    IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p3. s1 = zcl_wasm_rt=>wrap_i64( s1 ). p4 = s1. s2 = p4. s2 = mem_ld_i32( s2 ). p4 = s2. s3 = 1. s2 = s2 - s3. mem_st_i32( iv_addr = s1 iv_val = s2 ). s1 = p4. s2 = 1.
    IF s1 > s2. s1 = 1. ELSE. s1 = 0. ENDIF. IF s1 <> 0. EXIT. ENDIF. " br_if 0 s1 = p0. s1 = mem_ld_i32( s1 + 16 ). s2 = p3. PERFORM f453 USING s1 s2.
  ENDDO. rv = s0.
ENDFORM.

