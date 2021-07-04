/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* top =  1  *)
(* src = "arbitro.v:5" *)
module synth_arbitro(pop0_out_synt, pop1_out_synt, pop2_out_synt, pop3_out_synt, push0_out_synt, push1_out_synt, push2_out_synt, push3_out_synt, demux0_out_synt, dest, empty0, empty1, empty2, empty3, afull0, afull1, afull2, afull3, reset, clk);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  (* src = "arbitro.v:10" *)
  input afull0;
  (* src = "arbitro.v:10" *)
  input afull1;
  (* src = "arbitro.v:10" *)
  input afull2;
  (* src = "arbitro.v:10" *)
  input afull3;
  (* src = "arbitro.v:11" *)
  input clk;
  (* src = "arbitro.v:7" *)
  output [1:0] demux0_out_synt;
  (* src = "arbitro.v:8" *)
  input [1:0] dest;
  (* src = "arbitro.v:9" *)
  input empty0;
  (* src = "arbitro.v:9" *)
  input empty1;
  (* src = "arbitro.v:9" *)
  input empty2;
  (* src = "arbitro.v:9" *)
  input empty3;
  (* src = "arbitro.v:16" *)
  wire [3:0] emptys;
  (* src = "arbitro.v:5" *)
  output pop0_out_synt;
  (* src = "arbitro.v:5" *)
  output pop1_out_synt;
  (* src = "arbitro.v:5" *)
  output pop2_out_synt;
  (* src = "arbitro.v:5" *)
  output pop3_out_synt;
  (* src = "arbitro.v:13" *)
  wire [3:0] pops;
  (* src = "arbitro.v:6" *)
  output push0_out_synt;
  (* src = "arbitro.v:6" *)
  output push1_out_synt;
  (* src = "arbitro.v:6" *)
  output push2_out_synt;
  (* src = "arbitro.v:6" *)
  output push3_out_synt;
  (* src = "arbitro.v:14" *)
  wire [3:0] pushs;
  (* src = "arbitro.v:11" *)
  input reset;
  NOT _23_ (
    .A(empty3),
    .Y(_00_)
  );
  NOT _24_ (
    .A(dest[1]),
    .Y(_01_)
  );
  NOT _25_ (
    .A(dest[0]),
    .Y(_02_)
  );
  NOT _26_ (
    .A(reset),
    .Y(_03_)
  );
  NOR _27_ (
    .A(afull0),
    .B(afull1),
    .Y(_04_)
  );
  NOR _28_ (
    .A(afull2),
    .B(afull3),
    .Y(_05_)
  );
  NAND _29_ (
    .A(_04_),
    .B(_05_),
    .Y(_06_)
  );
  NOR _30_ (
    .A(_03_),
    .B(_06_),
    .Y(_07_)
  );
  NOT _31_ (
    .A(_07_),
    .Y(_08_)
  );
  NAND _32_ (
    .A(empty0),
    .B(_07_),
    .Y(_09_)
  );
  NOR _33_ (
    .A(empty1),
    .B(_09_),
    .Y(pop1_out_synt)
  );
  NOR _34_ (
    .A(empty0),
    .B(_08_),
    .Y(pop0_out_synt)
  );
  NAND _35_ (
    .A(empty1),
    .B(empty0),
    .Y(_10_)
  );
  NOT _36_ (
    .A(_10_),
    .Y(_11_)
  );
  NAND _37_ (
    .A(_07_),
    .B(_11_),
    .Y(_12_)
  );
  NOR _38_ (
    .A(empty2),
    .B(_12_),
    .Y(pop2_out_synt)
  );
  NAND _39_ (
    .A(_00_),
    .B(empty2),
    .Y(_13_)
  );
  NOR _40_ (
    .A(_12_),
    .B(_13_),
    .Y(pop3_out_synt)
  );
  NOR _41_ (
    .A(pop1_out_synt),
    .B(pop3_out_synt),
    .Y(_14_)
  );
  NOT _42_ (
    .A(_14_),
    .Y(demux0_out_synt[0])
  );
  NAND _43_ (
    .A(empty3),
    .B(empty2),
    .Y(_15_)
  );
  NOT _44_ (
    .A(_15_),
    .Y(_16_)
  );
  NOR _45_ (
    .A(_12_),
    .B(_16_),
    .Y(demux0_out_synt[1])
  );
  NAND _46_ (
    .A(_01_),
    .B(reset),
    .Y(_17_)
  );
  NOR _47_ (
    .A(_10_),
    .B(_15_),
    .Y(_18_)
  );
  NOR _48_ (
    .A(_06_),
    .B(_18_),
    .Y(_19_)
  );
  NAND _49_ (
    .A(_02_),
    .B(_19_),
    .Y(_20_)
  );
  NOR _50_ (
    .A(_17_),
    .B(_20_),
    .Y(push0_out_synt)
  );
  NAND _51_ (
    .A(dest[0]),
    .B(_19_),
    .Y(_21_)
  );
  NOR _52_ (
    .A(_17_),
    .B(_21_),
    .Y(push1_out_synt)
  );
  NAND _53_ (
    .A(dest[1]),
    .B(reset),
    .Y(_22_)
  );
  NOR _54_ (
    .A(_20_),
    .B(_22_),
    .Y(push2_out_synt)
  );
  NOR _55_ (
    .A(_21_),
    .B(_22_),
    .Y(push3_out_synt)
  );
  assign emptys = { empty3, empty2, empty1, empty0 };
  assign pops = { pop3_out_synt, pop2_out_synt, pop1_out_synt, pop0_out_synt };
  assign pushs = { push3_out_synt, push2_out_synt, push1_out_synt, push0_out_synt };
endmodule