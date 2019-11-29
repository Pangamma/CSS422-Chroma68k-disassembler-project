//package com.lumagaizen.opcodewriter.opcodes;
//
//import java.util.TreeMap;
//
//
//public class EA {
//	TreeMap<String,String> eaPatterns = new TreeMap<>();
//	public EA(){
//		eaPatterns.put("TRAP", 
//			"\tMOVE.W D3, D4\r\n" +
//			"\tANDI #$000F, D4\r\n" +
//			"\tMOVE.L #ADDR_OUT, A1\r\n" +
//			"\tMOVE.B #'$', (A1)+"+
//			"\tMOVE.B D4, (A1)+\r\n"+
//			"\tJSR	PRINT_OUT_EA\r\n"
//		);
//	}
//}
