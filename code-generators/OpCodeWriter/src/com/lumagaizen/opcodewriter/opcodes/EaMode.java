package com.lumagaizen.opcodewriter.opcodes;

/**
 *
 * @author Taylor
 */
public enum EaMode {
	/** INVALID **/
	_("invalid","nope"),
	/** Dn **/
	_000_DnDirect("000","xxx"),
	/** An **/
	_001_AnDirect("001","xxx"),
	/** (An) **/
	_010_AnIndirect("010","xxx"),
	/** (An)+ **/
	_011_AnPostIncrement("011","xxx"),
	/** -(An) **/
	_100_AnPreDecrement("100","xxx"),
	/** (D16, An) **/
	_101_AnDisplacement("101","xxx"),
	/** (D8, An, Xn) **/
	_110_AnIndex("110","xxx"),
	/** (xxx).W **/
	_111_AbsShort("111","000"),
	/** (xxx).L **/
	_111_AbsLong("111","001"),
	/** (D16, PC) **/
	_111_ProgCounterWithDisplacement("111","010"),
	/** (D8, PC, Xn) **/
	_111_ProgCounterWithIndex("111","011"),
	/** (xxx).W **/
	_111_Immediate("111","100"),
	;
	private String mode;
	private String reg;
	EaMode(String mode,String register){
		this.mode = mode;
		this.reg = register;
	}
	EaMode(String mode){
		this(mode,"xxx");
	}

	public String getMode(){
		return mode;
	}

	public String getReg(){
		return reg;
	}
}
