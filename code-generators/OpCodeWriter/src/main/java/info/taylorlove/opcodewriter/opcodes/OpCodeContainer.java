package info.taylorlove.opcodewriter.opcodes;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.TreeMap;
import java.util.TreeSet;

/**
 *
 * @author Taylor
 */
public final class OpCodeContainer {

  //<editor-fold defaultstate="collapsed" desc="Globals">
  /**
   * first 4 --> opcode bucket *
   */
  TreeMap<String, ArrayList<OpCode>> codeBuckets = new TreeMap<>();
  /**
   * format --> opcode *
   */
  TreeMap<String, OpCode> allOpCodes = new TreeMap<>();

  //<editor-fold defaultstate="collapsed" desc="Add the op codes">
  public OpCodeContainer() {
    // ss = size code (light purple)
    // s = size code (mid purple)
    // SS = size code (dark purple)
    // mmm =  Addressing mode
    // nnn = register (Xn)
    // ddd = register (Dn)
    
    // M = Mode. 0 = Dn, 1 = -(An)
    
    
    // n = Xn
    // a = An
    // d = Dn
    // D = direction 1/0, 1 = Reg to Mem. 0 = Mem to Reg. 
    // r = direction 1/0, 0 = Reg to Mem. 1 = Mem to Reg. 
    // R = Rotation. (binary 1-8)
    // v = vector?
    // # = Data
    // C = Condition
    // > = Displacement
    // < = Direction. 0: <ea> --> Dn, 1: Dn --> <ea>
    this
        .add(new OpCode("bbbb bbbb bbbb bbbb", "INVALID", "Invalid Opcode", "ea_pattern_data")) // Invalid
        .add(new OpCode("0000 000 0 00 111 100", "ORI", "ORI_TO_CCR", "ea_pattern_ori_to_ccr")) // ORI to CCR (B)
        .add(new OpCode("0000 000 0 01 111 100", "ORI", "ORI_TO_SR", "ea_pattern_ori_to_sr")) // ORI to SR (W)
        .add(new OpCode("0000 000 0 ss mmm nnn", "ORI", "ORI", "ea_pattern_ori")) // ORI (B/W/L)
        
        .add(new OpCode("0000 001 0 00 111 100", "ANDI", "ANDI_TO_CCR", "ea_pattern_ori_to_ccr")) // ANDI to CCR (B)
        .add(new OpCode("0000 001 0 01 111 100", "ANDI", "ANDI_TO_SR", "ea_pattern_ori_to_sr")) // ANDI to SR (W)
        .add(new OpCode("0000 001 0 ss mmm nnn", "ANDI", "ANDI", "ea_pattern_ori")) // ANDI (B/W/L)
        
        .add(new OpCode("0000 010 0 ss mmm nnn", "SUBI", "SUBI", "ea_pattern_ori")) // SUBI (B/W/L)
        .add(new OpCode("0000 011 0 ss mmm nnn", "ADDI", "ADDI", "ea_pattern_ori")) // ADDI (B/W/L)
        .add(new OpCode("0000 101 0 00 111 100", "EORI", "EORI_TO_CCR", "ea_pattern_ori_to_ccr")) // EORI to CCR (B)
        .add(new OpCode("0000 101 0 01 111 100", "EORI", "EORI_TO_SR", "ea_pattern_ori_to_sr")) // EORI to SR (W)
        .add(new OpCode("0000 101 0 ss mmm nnn", "EORI", "EORI", "ea_pattern_ori")) // EORI (B/W/L)
        .add(new OpCode("0000 110 0 ss mmm nnn", "CMPI", "CMPI", "ea_pattern_ori")) // CMPI (B/W/L)
        
        .add(new OpCode("0000 100 0 00 mmm nnn", "BTST", "BTST", "ea_pattern_jsr")) // BTST (B/L)
        .add(new OpCode("0000 100 0 01 mmm nnn", "BCHG", "BCHG", "ea_pattern_jsr")) // BCHG (B/L)
        .add(new OpCode("0000 100 0 10 mmm nnn", "BCLR", "BCLR", "ea_pattern_jsr")) // BCLR (B/L)
        .add(new OpCode("0000 100 0 11 mmm nnn", "BSET", "BSET", "ea_pattern_jsr")) // BSET (B/L)
        
        .add(new OpCode("0000 ddd 1 00 mmm nnn", "BTST", "BTST", "ea_pattern_f_xxxx_ddd_x_xx_mmm_nnn")) // BTST (B/L)
        .add(new OpCode("0000 ddd 1 01 mmm nnn", "BCHG", "BCHG", "ea_pattern_f_xxxx_ddd_x_xx_mmm_nnn")) // BCHG (B/L)
        .add(new OpCode("0000 ddd 1 10 mmm nnn", "BCLR", "BCLR", "ea_pattern_f_xxxx_ddd_x_xx_mmm_nnn")) // BCLR (B/L)
        .add(new OpCode("0000 ddd 1 11 mmm nnn", "BSET", "BSET", "ea_pattern_f_xxxx_ddd_x_xx_mmm_nnn")) // BSET (B/L)
        
        .add(new OpCode("0100 0000 ss mmm nnn", "NEGX", "NEGX", "ea_pattern_clr")) // NEGX  (B/W/L)
        .add(new OpCode("0100 0010 ss mmm nnn", "CLR", "CLR", "ea_pattern_clr")) // CLR   (B/W/L)
        .add(new OpCode("0100 0100 ss mmm nnn", "NEG", "NEG", "ea_pattern_clr")) // NEG   (B/W/L)
        .add(new OpCode("0100 0110 ss mmm nnn", "NOT", "NOT", "ea_pattern_clr")) // NOT   (B/W/L)
        .add(new OpCode("00ss aaa 001 mmm nnn", "MOVEA", "MOVEA", "ea_pattern_move")) // MOVEA (W/L)
        .add(new OpCode("00ss nnn mmm mmm nnn", "MOVE", "MOVE", "ea_pattern_move")) // MOVE  (B/W/L)
        .add(new OpCode("0100 0000 11 mmm nnn", "MOVE", "MOVE_FROM_SR", "ea_pattern_move_from_sr")) // MOVE from SR  (W)
        .add(new OpCode("0100 0100 11 mmm nnn", "MOVE", "MOVE_TO_CCR", "ea_pattern_move_to_ccr")) // MOVE from CCR  (B)
        .add(new OpCode("0100 0110 11 mmm nnn", "MOVE", "MOVE_TO_SR", "ea_pattern_move_to_sr")) // MOVE to SR  (W)
        .add(new OpCode("0100 1010 ss mmm nnn", "TST", "TST", "ea_pattern_clr")) // TST (B/W/L)
        .add(new OpCode("1110 000 0 11 mmm nnn", "ASR", "ASR", "ea_pattern_jsr")) // ASR (B/W/L)
        .add(new OpCode("1110 000 1 11 mmm nnn", "ASL", "ASL", "ea_pattern_jsr")) // ASL (B/W/L)
        .add(new OpCode("1110 001 0 11 mmm nnn", "LSR", "LSR", "ea_pattern_jsr")) // LSR (B/W/L)
        .add(new OpCode("1110 001 1 11 mmm nnn", "LSL", "LSL", "ea_pattern_jsr")) // LSL (B/W/L)
        .add(new OpCode("1110 010 0 11 mmm nnn", "ROXR", "ROXR", "ea_pattern_jsr")) // ROXR (B/W/L)
        .add(new OpCode("1110 010 1 11 mmm nnn", "ROXL", "ROXL", "ea_pattern_jsr")) // ROXL (B/W/L)
        .add(new OpCode("1110 011 0 11 mmm nnn", "ROR", "ROR", "ea_pattern_jsr")) // ROR (B/W/L)
        .add(new OpCode("1110 011 1 11 mmm nnn", "ROL", "ROL", "ea_pattern_jsr")) // ROL (B/W/L)
        .add(new OpCode("1110 RRR 0 ss m00 ddd", "ASR", "ASR", "ea_pattern_rotation")) // ASR (B/W/L)
        .add(new OpCode("1110 RRR 1 ss m00 ddd", "ASL", "ASL", "ea_pattern_rotation")) // ASL (B/W/L)
        .add(new OpCode("1110 RRR 0 ss m01 ddd", "LSR", "LSR", "ea_pattern_rotation")) // LSR (B/W/L)
        .add(new OpCode("1110 RRR 1 ss m01 ddd", "LSL", "LSL", "ea_pattern_rotation")) // LSL (B/W/L)
        .add(new OpCode("1110 RRR 0 ss m10 ddd", "ROXR", "ROXR", "ea_pattern_rotation")) // ROXR (B/W/L)
        .add(new OpCode("1110 RRR 1 ss m10 ddd", "ROXL", "ROXL", "ea_pattern_rotation")) // ROXL (B/W/L)
        .add(new OpCode("1110 RRR 0 ss m11 ddd", "ROR", "ROR", "ea_pattern_rotation")) // ROR (B/W/L)
        .add(new OpCode("1110 RRR 1 ss m11 ddd", "ROL", "ROL", "ea_pattern_rotation")) // ROL (B/W/L)
        .add(new OpCode("0110 CCCC >>>> >>>>", "B", "Bcc", "ea_ea_displacement")) // Bcc (B/W/?) + BRA + BSR
        .add(new OpCode("1011 ddd 1 ss mmm nnn", "EOR", "EOR", "ea_pattern_cmp")) // EOR (B/W/L)
        .add(new OpCode("1011 ddd 0 ss mmm nnn", "CMP", "CMP", "ea_pattern_cmp")) // CMP (B/W/L)
        .add(new OpCode("0111 ddd 0 #### ####", "MOVEQ", "MOVEQ", "ea_pattern_moveq")) // MOVEQ (L)
        .add(new OpCode("0100 111 01 0 mmm nnn", "JSR", "JSR", "ea_pattern_jsr")) // JSR
        .add(new OpCode("0100 111 01 1 mmm nnn", "JMP", "JMP", "ea_pattern_jsr")) // JMP
        .add(new OpCode("0100 100 000 mmm nnn", "NBCD", "NBCD", "ea_pattern_jsr")) // NBCD   (B)
        .add(new OpCode("0100 101 011 mmm nnn", "TAS", "TAS", "ea_pattern_jsr")) // TAS (B)
        .add(new OpCode("0100 100 001 mmm ddd", "PEA", "PEA", "ea_pattern_jsr")) // PEA   (L)
        .isEa(EaMode._010_AnIndirect)
        .isEa(EaMode._101_AnDisplacement)
        .isEa(EaMode._110_AnIndex)
        .isEa(EaMode._111_AbsShort)
        .isEa(EaMode._111_AbsLong)
        .isEa(EaMode._111_ProgCounterWithDisplacement)
        .isEa(EaMode._111_ProgCounterWithIndex)
        .add(new OpCode("1011 aaa s 11 mmm nnn", "CMPA", "CMPA", "ea_pattern_cmpa")) // CMPA (W/L)
        .add(new OpCode("1101 aaa s 11 mmm nnn", "ADDA", "ADDA", "ea_pattern_cmpa")) // ADDA (W/L)
        .add(new OpCode("1001 aaa s 11 mmm nnn", "SUBA", "SUBA", "ea_pattern_cmpa")) // SUBA (W/L)
        .add(new OpCode("0100 aaa 11 1 mmm nnn", "LEA", "LEA", "ea_pattern_lea")) // LEA (L)
        .add(new OpCode("1000 ddd < ss mmm nnn", "OR", "OR", "ea_pattern_and")) // OR (B/W/L)
        .add(new OpCode("1001 ddd < ss mmm nnn", "SUB", "SUB", "ea_pattern_and")) // SUB (B/W/L)
        .add(new OpCode("1100 ddd < ss mmm nnn", "AND", "AND", "ea_pattern_and")) // AND (B/W/L)
        .add(new OpCode("1101 ddd < ss mmm nnn", "ADD", "ADD", "ea_pattern_and")) // ADD (B/W/L)
        .add(new OpCode("1000 ddd 011 mmm nnn", "DIVU", "DIVU_WORD", "ea_pattern_divs_word")) // DIVU (W)
        .notEa(EaMode._001_AnDirect)
        .add(new OpCode("1000 ddd 111 mmm nnn", "DIVS", "DIVS_WORD", "ea_pattern_divs_word")) // DIVS (W)
        .notEa(EaMode._001_AnDirect)
        .add(new OpCode("1100 ddd 011 mmm nnn", "MULU", "MULU_WORD", "ea_pattern_divs_word")) // MULU (W)
        .notEa(EaMode._001_AnDirect)
        .add(new OpCode("1100 ddd 111 mmm nnn", "MULS", "MULS_WORD", "ea_pattern_divs_word")) // MULS (W)
        .notEa(EaMode._001_AnDirect)
        //<editor-fold defaultstate="collapsed" desc="TODO:DIVS_LONG">
        .add(new OpCode("0100 1100 01 mmm nnn", "DIVU", "DIVU_LONG", "ea_pattern_divs_long")) // DIVU (L)
        .notEa(EaMode._001_AnDirect)
        // ext: 0rrr 0s00 0000 0rrr
        .add(new OpCode("0100 1100 01 mmm nnn", "DIVS", "DIVS_LONG", "ea_pattern_divs_long")) // DIVS (L)
        .notEa(EaMode._001_AnDirect)
        // ext: 0rrr 1s00 0000 0rrr
        .add(new OpCode("0100 1100 00 mmm nnn", "MULU", "MULU_LONG", "ea_pattern_divs_long")) // MULU (L)
        .notEa(EaMode._001_AnDirect)
        // ext: 0rrr 0s00 0000 0rrr
        .add(new OpCode("0100 1100 00 mmm nnn", "MULS", "MULS_LONG", "ea_pattern_divs_long")) // MULS (L)
        .notEa(EaMode._001_AnDirect)
        // ext: 0rrr 1s00 0000 0rrr
        //</editor-fold>

        .add(new OpCode("0100 11 0 01 s mmm nnn", "MOVEM", "MOVEM_D1", "ea_pattern_movem")) // MOVEM (W/L)
        .notEa(EaMode._000_DnDirect)
        .notEa(EaMode._001_AnDirect)
        .notEa(EaMode._011_AnPostIncrement)
        .notEa(EaMode._111_Immediate)
        .notEa(EaMode._111_ProgCounterWithDisplacement)
        .notEa(EaMode._111_ProgCounterWithIndex)
        .add(new OpCode("0100 10 0 01 s mmm nnn", "MOVEM", "MOVEM_D0", "ea_pattern_movem")) // MOVEM (W/L)
        .notEa(EaMode._000_DnDirect)
        .notEa(EaMode._001_AnDirect)
        .notEa(EaMode._100_AnPreDecrement)
        .notEa(EaMode._111_Immediate)
        .notEa(EaMode._111_ProgCounterWithDisplacement)
        .notEa(EaMode._111_ProgCounterWithIndex)
        .add(new OpCode("0000 ddd 1 Ds 001 aaa", "MOVEP", "MOVEP")) // MOVEP (W/L)
        .add(new OpCode("0100 11100110r aaa", "MOVE", "MOVE_USP", "NEXT_LONG")) // MOVE USP (L)
        .add(new OpCode("0100 100 0 1 s 000 nnn", "EXT", "EXT")) // EXT   (W/L)
        .add(new OpCode("0100 100 001 000 ddd", "SWAP", "SWAP", "NEXT_WORD")) // SWAP   (W)
        .add(new OpCode("0100 11100100 vvvv", "TRAP", "TRAP")) // TRAP
        .add(new OpCode("0100 111001010 aaa", "LINK", "LINK")) // LINK (W)
        .add(new OpCode("0100 111001011 aaa", "UNLK", "UNLK")) // UNLK
        .add(new OpCode("0100 ddd 11 0 mmm nnn", "CHK", "CHK")) // CHK (W)
        .add(new OpCode("0101 ### 0 ss mmm nnn", "ADDQ", "ADDQ")) // ADDQ (B/W/L)
        .add(new OpCode("0101 ### 1 ss mmm nnn", "SUBQ", "SUBQ")) // SUBQ (B/W/L)
        .add(new OpCode("0101 CCCC 11 mmm nnn", "S", "Scc", "NEXT_BYTE")) // Scc (B)
        .add(new OpCode("0101 CCCC 11 001 ddd", "DB", "DBcc", "NEXT_WORD")) // DBcc (W)
        .add(new OpCode("1000 nnn 10000 M nnn", "SBCD", "SBCD", "NEXT_BYTE")) // SBCD (B)
        .add(new OpCode("1001 nnn 1 ss 00 M nnn", "SUBX", "SUBX")) // SUBX (B/W/L)
        .add(new OpCode("1011 aaa 1 ss 001 aaa", "CMPM", "CMPM")) // CMPM (B/W/L)
        .add(new OpCode("1100 nnn 10000 M nnn", "ABCD", "ABCD")) // ABCD (B)
        .add(new OpCode("1100 nnn 1 mm 00 m nnn", "EXG", "EXG")) // EXG (L)
        .add(new OpCode("1101 nnn 1 ss 00 M nnn", "ADDX", "ADDX")) // ADDX (B/W/L)
        //                
        ;
  }
	//</editor-fold>

  //</editor-fold>
  private OpCodeContainer notEa(EaMode p_mode) {
    this.prevAddedOpCode.notEA(p_mode);
    return this;
  }

  private OpCodeContainer isEa(EaMode p_mode) {
    this.prevAddedOpCode.isEA(p_mode);
    return this;
  }

  private OpCode prevAddedOpCode = null;

  private OpCodeContainer add(OpCode code) {
    prevAddedOpCode = code;
    if (code != null) {
      this.allOpCodes.put(code.getFormat(), code);
      if (!codeBuckets.containsKey(code.getFirstFour())) {
        codeBuckets.put(code.getFirstFour(), new ArrayList<OpCode>());
      }
      codeBuckets.get(code.getFirstFour()).add(code);
    }
    return this;
  }

  //<editor-fold defaultstate="collapsed" desc="Analyze">
  public void getCoverageGaps() {
    TreeSet<Integer> allPossibilities = new TreeSet<>();
    for (int i = 0; i < 65535; i++) {
      allPossibilities.add(i);
    }
    for (String s : allOpCodes.keySet()) {
      allPossibilities.removeAll(allOpCodes.get(s).getPossibleIntValues());
    }
    System.out.println(allPossibilities.size());
  }

  @Override
  public String toString() {
    String s = "";
    for (String key : this.codeBuckets.keySet()) {
      ArrayList<OpCode> bucket = this.codeBuckets.get(key);
      s += "\r\n--------------------------------------------------------\r\n";
      for (OpCode code : bucket) {
        s += (code.toString()) + "\r\n";
      }
    }
    return s;
  }
  //</editor-fold>
  //<editor-fold defaultstate="collapsed" desc="Access">

  public TreeMap<String, OpCode> getAllOpCodes() {
    TreeMap<String, OpCode> output = new TreeMap<String, OpCode>();
    for (String s : codeBuckets.keySet()) {
      for (OpCode code : codeBuckets.get(s)) {
        output.put(code.getFormat(), code);
      }
    }
    return output;
  }

  //</editor-fold>
  //<editor-fold defaultstate="collapsed" desc="Output Code">
  public String getOpNameStrings() {
    TreeMap<String, OpCode> ops = getAllOpCodes();
    TreeSet<String> opNames = new TreeSet<String>();
    int maxLen = -1;
    for (OpCode op : ops.values()) {
      opNames.add(op.getDisplayName());
      if (op.getDisplayName().length() > maxLen) {
        maxLen = op.getDisplayName().length();
      }
    }
    String s = "";

    for (String name : opNames) {
      String paddedName = name;
      s += "opName_" + name + "\tDC.B\t'" + paddedName + "',0\r\n";
    }
    return s;
  }

  /**
   * Figures out the entire op code type, then branches to a is_opcode label. You can find the is_opcode labels section
   * in Layer 3.
   *
   */
  public String getLayer1And2AndInvalidCode() {
    StringBuilder sb = new StringBuilder();
    sb.append(";----------------------------------------------------------------------------------------------------\r\n");
    sb.append("; Layer 1 and 2\r\n");
    sb.append("DetermineOpCode:\r\n");
//		sb.append(getLayerInvalidCode());
    ArrayList<OpCode> codes = new ArrayList<>(allOpCodes.values());
    codes.sort(new Comparator<OpCode>() {
      @Override
      public int compare(OpCode o1, OpCode o2) {
        return o2.getSpecificity() - o1.getSpecificity();
      }
    });
    for (int i = 0; i < codes.size(); i++) {
      OpCode code = codes.get(i);
      sb.append("\tMOVE.L\tD3, D4\r\n");
      if (!code.getMaskHex().equalsIgnoreCase("FFFF")) {
        sb.append("\tANDI.L\t#$" + code.getMaskHex() + ", D4\r\n");
      }
      sb.append("\tCMPI.L\t#$" + code.getCompareMaskHex() + ", D4\r\n");
      sb.append("\tBNE\t\tnot_" + code.getCompareMaskHex() + "_" + code.getDisplayName() + "\r\n");
      sb.append("\tJMP\t\tisOp_" + code.getCompareMaskHex() + "_" + code.getOpMemonic() + "\r\n");
//					sb.append("\tRTS\r\n");
      sb.append("not_" + code.getCompareMaskHex() + "_" + code.getDisplayName() + ":");
      if (i < codes.size() - 1) {
        OpCode nextCode = codes.get(i + 1);
        sb.append("\t* Maybe it is " + nextCode.getOpMemonic() + "?\r\n");
      } else {
        sb.append("\r\n");
      }
    }
    sb.append("\tJMP\tisOp_0000_Invalid_Opcode\r\n");
//			sb.append("\tRTS\r\n"); 
    sb.append(";----------------------------------------------------------------------------------------------------\r\n");
    return sb.toString();
  }

  /**
   * is_opcode *
   */
  public String getLayer3Code() {
    StringBuilder sb = new StringBuilder();
    sb.append(";----------------------------------------------------------------------------------------------------\r\n");
    sb.append("; Layer 3\r\n");
    for (String firstFour : codeBuckets.keySet()) {

      ArrayList<OpCode> codes = codeBuckets.get(firstFour);
      codes.sort(new Comparator<OpCode>() {
        @Override
        public int compare(OpCode o1, OpCode o2) {
          return o2.getSpecificity() - o1.getSpecificity();
        }
      });
      for (OpCode code : codes) {
        String label = "isOp_" + code.getCompareMaskHex() + "_" + code.getOpMemonic();
        sb.append(label + ":\r\n");
        sb.append("\tLEA\t\topName_" + code.getDisplayName() + ", A3\r\n");
        sb.append("\tJSR\t\tAPPEND_A3\r\n");
        if (label.equals("isOp_0000_Invalid_Opcode")) {
          sb.append("\tJSR\t\tprintOutErrorColor\r\n");
        } else {
          sb.append("\tJSR\t\tprintOutOpColor\r\n");
        }
        if (label.equals("isOp_50c8_DBcc")) {
          sb.append("\tLEA\t\ts_DBccArray, A3\r\n");
          sb.append("\tCLR.L\tD4\r\n");
          sb.append("\tMOVE.B\tADDR_OP_0F00, D4 ; Move the condition codes where we want them.\r\n");
          sb.append("\tLSL.W\t#1, D4 \t; Multiply by 2 because it is 2 bytes per array index. \r\n");

          sb.append("\tJSR\t\tRESET_OUT\r\n");
          sb.append("\tMOVE.W\t(A3, D4.W), (A1)+\t; Move array index D4 to (A1), then increment.");
          sb.append("\tJSR\tprintOutOpColor \r\n");
        } else if (label.equals("isOp_50c0_Scc")) {
          sb.append("\tLEA\t\ts_SccArray, A3\r\n");
          sb.append("\tCLR.L\tD4\r\n");
          sb.append("\tMOVE.B\tADDR_OP_0F00, D4 ; Move the condition codes where we want them.\r\n");
          sb.append("\tLSL.W\t#1, D4 \t; Multiply by 2 because it is 2 bytes per array index. \r\n");

          sb.append("\tJSR\t\tRESET_OUT\r\n");
          sb.append("\tMOVE.W\t(A3, D4.W), (A1)+\t ; Move array index D4 to (A1), then increment.");
          sb.append("\tJSR\tprintOutOpColor \r\n");
        } else if (label.equals("isOp_6000_Bcc")) {
          sb.append("\tLEA\ts_BccArray, A3\r\n");
          sb.append("\tCLR.L\tD4\r\n");
          sb.append("\tMOVE.B\tADDR_OP_0F00, D4 ; Move the condition codes where we want them.\r\n");
          sb.append("\tLSL.W\t#1, D4 \t; Multiply by 2 because it is 2 bytes per array index. \r\n");

          sb.append("\tJSR\t\tRESET_OUT\r\n");
          sb.append("\tMOVE.W\t(A3, D4.W), (A1)+\t; Move array index D4 to (A1), then increment.");
          sb.append("\tJSR\tprintOutOpColor \r\n");
        }

        if (code.getEaPatternSubRoutine() != null) {
          sb.append("\tJMP\t\t" + code.getEaPatternSubRoutine() + "\r\n");
        } else {
          sb.append("\tRTS\r\n");
        }

      }

    }
    sb.append(";----------------------------------------------------------------------------------------------------\r\n");
    return sb.toString();
  }

  public TreeSet<Integer> getValidOpCodeBinaryInts() {
    TreeSet<Integer> valids = new TreeSet<>();
    for (OpCode code : this.allOpCodes.values()) {
      valids.addAll(code.getPossibleIntValues());
    }

    return valids;
  }

  public TreeSet<Integer> getInvalidOpCodeBinaryInts() {
    TreeSet<Integer> valids = new TreeSet<>();
    for (OpCode code : this.allOpCodes.values()) {
      valids.addAll(code.getPossibleIntValues());
    }

    TreeSet<Integer> invalids = new TreeSet<>();
    int twoPow16 = (int) Math.pow(2, 16);
    for (int i = 0; i < twoPow16; i++) {
      if (!valids.contains(i)) {
        invalids.add(i);
      }
    }

    return invalids;
  }

  /**
   * ALL IMPOSSIBLE ERRORS THAT COULD OTHERWISE FALL THROUGH THE CRACKS *
   */
  public String getLayerInvalidCode() {
    StringBuilder sb = new StringBuilder();
    TreeSet<String> invalids = new TreeSet<>();
    TreeSet<Integer> valids = new TreeSet<>();
    for (OpCode code : this.allOpCodes.values()) {
      valids.addAll(code.getPossibleIntValues());

      invalids.addAll(code.getAllBadVariations());
    }

    TreeSet<String> trueInvalids = new TreeSet<>();
    for (String bad : invalids) {
      //System.out.println(bad);
      boolean found = false;
      for (OpCode code : this.allOpCodes.values()) {
        TreeSet<String> codes = code.getPossibleBinaryValues();
        if (code.getPossibleBinaryValues().contains(bad)) {
          found = true;
          break;
        }
      }
      if (found) {
        //System.out.println("FOUND");
        trueInvalids.add(bad);
      }
    }
    // We've found the invalids by this point.
    sb.append(";----------------------------------------------------------------------------------------------------\r\n");
    sb.append("\tMOVE.W\tD3,D4\r\n");
    sb.append("\tANDI.W\t#$FFC0,D4\r\n");
    int n = 0;
    for (String k : trueInvalids) {
      sb.append("\tCMPI.W\t#%" + k + ", D4\r\n");
      sb.append("\tBEQ\tnot_0000_INVALID\r\n");
    }
    return sb.toString();
  }
  //</editor-fold>

}
