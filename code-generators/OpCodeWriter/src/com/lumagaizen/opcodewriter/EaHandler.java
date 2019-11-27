package com.lumagaizen.opcodewriter;

/**
 *
 * @author Taylor
 */
public class EaHandler {
	private static String[] DnArray = new String[]{
	"D0","D1","D2","D3","D4","D5","D6","D7"
	};
	/** An example pattern that an OP code would use. 
	 * 00000000 00	111	100		B I
	 **/
	public void patternORI(){
		int size = 1;		// collect size, transform it.
		transformSizeORI(size);	// JSR
		printSize(size);		// Size out... + print... 
		int mode = 7; // 111
		int Xn = 4;	 // 100
		handleMode(size,mode,Xn);
	}
	
	//<editor-fold defaultstate="collapsed" desc="Size Transforms">
	/**
	 * B = 00
	 * W = 01
	 * L = 10 
	 */
	public void transformSizeORI(int size){
		// do nothing
	}
	
	/**
	 * B = 01
	 * W = 11
	 * L = 10 
	 */
	public void transformSizeMoveA(int size){
		int[] sizeMoveA = new int[]{
			3	// 0 = unknown
			,0	// 1 = .B
			,2	// 2 = .L
			,1	// 3 = .W
		};
		size = sizeMoveA[size];	// Transform it using a pre-defined int array.
	}	
	/**
	 * W = 0
	 * L = 1
	 */
	public void transformSizeExt(int size){
		size++;	// Just increment once to get values printSize will use.
	}
	//</editor-fold>
	
	// ORI
	public void printSize(int size){
		switch(size){
			case 0: System.out.println(".B");
			case 1: System.out.println(".W");
			case 2: System.out.println(".L");
			case 3: System.out.println(".?");	// INVALID
		}
	}

	private void handleMode(int size, int mode, int Xn){
		switch(mode){
			case 000: handleMode000(size, Xn);
			case 111: handleMode111(size,mode,Xn);
			default: throw new IllegalArgumentException("Not yet handled.");
		}
	}
	public void handleMode000(int size, int Xn){
		// first read immediate data, then print things properly.
		System.out.println(DnArray[Xn]);
	}

	private void handleMode111(int size, int mode, int Xn){
		if (mode == 7 && Xn == 4){
			System.out.print("#$");
			//fetch SIZE... 
		}
	}
}
