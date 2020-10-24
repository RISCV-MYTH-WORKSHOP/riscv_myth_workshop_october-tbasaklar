\m4_TLV_version 1d: tl-x.org
\SV
   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template

   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @1
         $reset = *reset;
         $cnt = $reset ? 0 : (1 + >>1$cnt);
         $valid_or_reset = $reset || $cnt;
      ?$valid_or_reset
         @1
            $val1[31:0] = >>2$out;
            $val2[31:0] = $rand2[3:0];
            $op[2:0] = $rand1[2:0];

            $sum[31:0]  = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;

         @2   
            $out[31:0] = $op[2] ? >>2$mem : ($op[1] ? ($op[0] ? $quot : $prod) : ($op[0] ? $diff : $sum)) ;
            $out[31:0] = $reset ? 32'b0 : $out[31:0];
            $mem[31:0] = ($op[2] & !$op[1] & $op[0]) ? >>2$out : >>2$mem;
            $mem[31:0] = $reset ? 32'b0 : >>2$mem;
         
   //m4+calc_viz(@2)      
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
