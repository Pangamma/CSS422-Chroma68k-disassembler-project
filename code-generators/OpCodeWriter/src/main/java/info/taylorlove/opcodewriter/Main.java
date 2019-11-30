package info.taylorlove.opcodewriter;

import info.taylorlove.opcodewriter.opcodes.OpCode;
import info.taylorlove.opcodewriter.opcodes.OpCodeContainer;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

/**
 * TODO: Invalid data or opcodes should show as: 1000 DATA $WXYZ
 *
 * @author Taylor
 */
public class Main {

  public static void main(String[] args) throws IOException {
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
    // M = Mode. 0 = Dn, 1 = -(An)
    // < = Direction. 0: <ea> --> Dn, 1: Dn --> <ea>
    OpCodeContainer container = new OpCodeContainer();
		ArrayList<OpCode> codes = new ArrayList<>(container.getAllOpCodes().values());
		Collections.sort(codes,new Comparator<OpCode>(){
			@Override
			public int compare(OpCode o1, OpCode o2){
				return o1.getVariablesPattern().compareTo(o2.getVariablesPattern());
			}
		});

//------------------------------------------------------------------------------
//    System.out.println(container.getOpNameStrings());
//		container.getLayer1And2AndInvalidCode();
    System.out.println(container.getLayer1And2AndInvalidCode());
//		System.out.println(container.getLayer1And2AndInvalidCode());
		System.out.println(container.getLayer3Code());
//		for(OpCode code : codes){
//			System.out.println(code.getSpecificity()+"\t"+code.getFormat()+"\t"+code.getOpMemonic()+"\t"+code.getVariablesPattern()+"\t"+code.getEaPatternSubRoutine());
//			System.out.println(code.getOpMemonic());
//		}
//		

//		
////		Collections.sort(codes,new Comparator<OpCode>(){
////			@Override
////			public int compare(OpCode o1, OpCode o2){
////				return o1.getVariablesPattern().compareTo(o2.getVariablesPattern());
////			}
////		});
////		HashMap<String,Integer> counts = new HashMap<>();
////		for(OpCode code : codes){
////			if (!counts.containsKey(code.getVariablesPattern())){
////				counts.put(code.getVariablesPattern(),1);
////			}else{
////				int i = counts.get(code.getVariablesPattern());
////				counts.put(code.getVariablesPattern(),i+1);
////			}
//////			System.out.println(code.getSpecificity()+"\t"+code.getVariablesPattern()+"\t"+code.getDisplayName()+"\t"+code.getKnownBinaryPattern());
////		}
////		int mmmnnn = 0;
////		for(String s : counts.keySet()){
////			System.out.println(counts.get(s)+"\t"+s);
////			if (s.endsWith("mmmnnn")){
////				mmmnnn+= counts.get(s);
////			}
////		}
////		System.out.println("rows="+counts.size()+","+mmmnnn+"/"+codes.size());
//		
////        System.out.println(container.getLayer1Code());
////        System.out.println(container.getLayer2Code());
//       System.out.println(container.getOpNameStrings());
  }

}
