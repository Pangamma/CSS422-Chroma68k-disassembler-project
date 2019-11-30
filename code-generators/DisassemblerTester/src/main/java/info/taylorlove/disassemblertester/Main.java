package info.taylorlove.disassemblertester;

/**
 *
 * @author prota
 */
public class Main {

  public static final String OUTPUT_L68_PATH = "C:\\Users\\prota\\Downloads\\Chroma68\\disassembler code\\test_codes.L68";
  public static final String SOURCE_X68_PATH = "C:\\Users\\prota\\Downloads\\Chroma68\\disassembler code\\test_codes.X68";
  public static final String DISASSEMBLER_OUTPUT_PATH = "C:\\Users\\prota\\Downloads\\Chroma68\\disassembler code\\output.txt";
  
  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {
    Tester tester = new Tester() {};
    tester.runTests();
  }
}
