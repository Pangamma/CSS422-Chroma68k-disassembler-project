/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package info.taylorlove.opcodewriter;

import java.math.BigInteger;

/**
 *
 * @author Taylor
 */
public class STATIC
{
	public static String hexToBinary(String hexStr){
		return Integer.toBinaryString(Integer.parseInt(stripSpaces(hexStr), 16));
	}
	
	public static String binaryToHex(String binaryStr){
		String s = new BigInteger(binaryStr, 2).toString(16);
		int numHex = (int) Math.ceil(((double)binaryStr.length())/4);
		while (s.length() < numHex){
			s = "0"+s;
		}
		return s;
	}
	// For testing the outputs only.Not really useful for other stuff.
	public static int hexToInt(String hexStr){
		return Integer.parseInt(hexStr,16);
	}
	public static int binaryToInt(String binaryStr){
		return Integer.parseInt(binaryStr,2);
	}
	public static String intToBinary(int n){
		return new Integer(n).toString(2);
	}
	public static String intToHex(int n){
		return new Integer(n).toString(16);
	}
	/**
	 * Completely removes any spaces. Useful for when you want to write your 
	 * formats with spaces for readability, but you do not want it to affect
	 * actual functionality.
	 * @param input
	 * @return 
	 */
	public static String stripSpaces(String input){
		return input.replace(" ","");
	}
}
