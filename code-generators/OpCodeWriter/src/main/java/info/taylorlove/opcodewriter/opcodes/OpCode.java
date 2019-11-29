package info.taylorlove.opcodewriter.opcodes;

import info.taylorlove.opcodewriter.STATIC;
import java.util.TreeSet;

/**
 *
 * @author Taylor
 */
public class OpCode {

  /**
   * Of all possible variations (variables includes), which are invalid? *
   */
  private final TreeSet<String> invalidVariations = new TreeSet<>();

  /**
   * Example: 0111 ddd 0 #### ####
   */
  private final String format;

  /**
   * Example: MOVEQ
   */
  private String displayName;

  /**
   * Name of the OP code to use for code variable names Example: MOVE_to_ccr
   */
  private String opMemonic;

  /**
   * Name of the snippet of code to JMP to. Example: ea_pattern_moveq
   */
  private final String eaPatternSubRoutine;

  /**
   *
   * @param format
   * @param dispName MOVE
   * @param opBranchLabel MOVE_to_ccr
   */
  public OpCode(String format, String dispName, String opBranchLabel) {
    this(format, dispName, opBranchLabel, null);
  }

  /**
   *
   * @param p_format 0100010011mmmnnn
   * @param p_dispName MOVE
   * @param p_opMemonic MOVE_to_ccr
   * @param p_sizeSubRoutineName ea_pattern_move_to_ccr
   */
  public OpCode(String p_format, String p_dispName, String p_opMemonic, String p_sizeSubRoutineName) {
    this.format = p_format.replace(" ", "");
    this.displayName = p_dispName;
    this.opMemonic = p_opMemonic.replace(" ", "_");
    this.eaPatternSubRoutine = p_sizeSubRoutineName;

    // Size codes
    if (this.format.contains("ss")) {
      int i = this.format.indexOf("ss");
      if (i == 8) {
        TreeSet<String> p = OpCode.expandPatternIntoPossibilities(this.format.replace("ss", "11").replace("mmmnnn", "000000"));
        this.invalidVariations.addAll(p);
      } else if (i == 2) {
        TreeSet<String> p = OpCode.expandPatternIntoPossibilities(this.format.replace("ss", "00").replace("mmmnnn", "000000"));
        this.invalidVariations.addAll(p);
      }
//			System.out.println(this.opMemonic+"\t"+this.format.indexOf("ss")+"\t"+this.format);
    }
  }

  public String getFirstFour() {
    return this.format.substring(0, 4);
  }

  /**
   * Branches to this for EA. Null if notEA set. *
   */
  public String getEaPatternSubRoutine() {
    return eaPatternSubRoutine;
  }

  /**
   * Could be, "MOVE TO CCR" as an example *
   */
  public String getOpMemonic() {
    return opMemonic;
  }

  /**
   * Only show variable letters. No 1's or 0's. *
   */
  public String getVariablesPattern() {
    return this.format.replace("1", "_").replace("0", "_");
  }

  /**
   * ANDI.L mask, D4*
   */
  public String getMaskBinary() {
    String s = "";
    for (int i = 0; i < this.format.length(); i++) {
      char c = this.format.charAt(i);
      if (c == '0' || c == '1') {
        c = '1';
      } else {
        c = '0';
      }
      s += c;
    }
    return s;
  }

  /**
   * ANDI.L mask, D4*
   */
  public String getMaskHex() {
    String s = getMaskBinary();
    return STATIC.binaryToHex(s);
  }

  /**
   * Contains 1's where 1 isEA = 1. 0's for any format codes or 0's. CMPI.L cmpMask, D4*
   */
  public String getCompareMaskHex() {
    String s = getKnownBinaryPattern();
    s = s.replace("_", "0");
    return STATIC.binaryToHex(s);
  }

  /**
   * Returns binary pattern of known values.*
   */
  public String getKnownBinaryPattern() {
    return OpCode.getKnownBinaryPattern(this.format);
  }

  /**
   * Returns binary pattern of known values.*
   */
  public static String getKnownBinaryPattern(String format) {
    String s = "";
    for (int i = 0; i < format.length(); i++) {
      char c = format.charAt(i);
      if (c != '0' && c != '1') {
        c = '_';
      }
      s += c;
    }
    return s;
  }

  @Override
  public String toString() {
    return this.format;
  }

  /**
   * Higher the number, easier it isEA to determine. *
   */
  public int getSpecificity() {
    int n = 0;
    for (int i = 0; i < format.length(); i++) {
      if (format.charAt(i) == '0' || format.charAt(i) == '1')
        n++;
    }
    return n;
  }

  public int getMatchLevel(OpCode other) {
    int n = 0;
    for (int i = 0; i < Math.max(other.format.length(), this.format.length()); i++) {
      char c1 = other.format.charAt(i);
      char c2 = other.format.charAt(i);
    }
    return n;
  }

  public String getFormat() {
    return this.format;
  }

  public String getDisplayName() {
    return this.displayName;
  }

  //--------------------------------------------------------------------------
  /**
   * returns all possibles with specified pattern *
   */
  public static TreeSet<String> expandPatternIntoPossibilities(String p_pattern) {
    TreeSet<String> vs = new TreeSet<String>();
    TreeSet<String> vst = new TreeSet<String>();
    String known = getKnownBinaryPattern(p_pattern);
    vs.add(known);
    boolean changed = false;
    for (int i = 0; i < 16; i++) {	//iterate across...
      for (String s : vs) {
        if (s.charAt(i) == '_') {	// variable? Split it then.
          vst.add(s.replaceFirst("_", "1"));
          vst.add(s.replaceFirst("_", "0"));	// add splits to a temp array. 
          changed = true;
        }
      }
      if (changed) { //cycle the array so it only includes changed things.
        vs.clear();
        vs.addAll(vst);
        vst.clear();
      }
    }
    return vs;
  }

  /**
   * use for finding coverage gaps TODO: take modes into account so we don't have full optimistic coverage. *
   */
  public TreeSet<String> getPossibleBinaryValues() {

    TreeSet<String> vs = new TreeSet<String>();
    TreeSet<String> vst = new TreeSet<String>();
    vs.add(getKnownBinaryPattern());
    boolean changed = false;
    for (int i = 0; i < 16; i++) {	//iterate across...
      for (String s : vs) {
        if (s.charAt(i) == '_') {	// variable? Split it then.
          vst.add(s.replaceFirst("_", "1"));
          vst.add(s.replaceFirst("_", "0"));	// add splits to a temp array. 
          changed = true;
        }
      }
      if (changed) { //cycle the array so it only includes changed things.
        vs.clear();
        vs.addAll(vst);
        vst.clear();
      }
    }

    vs.removeAll(this.invalidVariations);
    return vs;
  }

  public TreeSet<String> getAllBadVariations() {
    return invalidVariations;
  }

  public OpCode not(String... s) {
    for (int i = 0; i < s.length; i++) {
      this.invalidVariations.add(s[i]);
    }
    return this;
  }

  /**
   * Converts all possible binary combinations into ints for quick comparisons
   * @return 
   */
  public TreeSet<Integer> getPossibleIntValues() {
    TreeSet<String> vs = getPossibleBinaryValues();
    TreeSet<Integer> vsi = new TreeSet<>();
    for (String s : vs) {
      vsi.add(STATIC.binaryToInt(s));
    }
    return vsi;
  }

  /**
   * if null, disregard. If set, then only use included ea modes. Only counts for last six bits. *
   */
  private TreeSet<EaMode> validEaModesLastSix = null;

  /**
   * Use either IS, or NOT, but never both for same op code *
   */
  public OpCode notEA(EaMode p_mode) {
    if (validEaModesLastSix == null) {
      this.validEaModesLastSix = new TreeSet<EaMode>();
      for (EaMode m : EaMode.values()) {
        this.validEaModesLastSix.add(m);
      }
    }
    this.validEaModesLastSix.remove(p_mode);
    return this;
  }

  /**
   * Use either IS, or NOT, but never both for same op code *
   */
  public OpCode isEA(EaMode p_mode) {
    if (validEaModesLastSix == null) {
      this.validEaModesLastSix = new TreeSet<EaMode>();
    }
    this.validEaModesLastSix.add(p_mode);
    return this;
  }
}
