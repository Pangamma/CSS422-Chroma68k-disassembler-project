/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package info.taylorlove.disassemblertester;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.RegularExpression;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 *
 * @author prota
 */
public abstract class Tester {

  public Tester() {
  }

  public void runTests() {
    List<String> linesFromSource = this.readLines(Main.SOURCE_X68_PATH);
    List<String> linesFromOutput = this.readLines(Main.DISASSEMBLER_OUTPUT_PATH);
    
    for(int a = 0,b = 0; a < linesFromSource.size() && b < linesFromOutput.size();a++, b++){
      String lineA = linesFromSource.get(a);
      String lineB = linesFromOutput.get(b);
      
      if (!lineA.replace(" ","").equalsIgnoreCase(lineB.replace(" ",""))){
        System.err.println(a + " |\t" + this.padRightSpaces(lineA, 32) + " <>      " + lineB);
      }else{
        System.err.println(a + " |\t" + this.padRightSpaces(lineA, 32) + " ==      " + lineB);
      }
    }
    
    System.out.println("Finish!");
  }
  
  public String padLeftSpaces(String inputString, int length) {
      if (inputString.length() >= length) {
          return inputString;
      }
      StringBuilder sb = new StringBuilder();
      while (sb.length() < length - inputString.length()) {
          sb.append(' ');
      }
      sb.append(inputString);

      return sb.toString();
  }  
  
  public String padRightSpaces(String inputString, int length) {
      if (inputString.length() >= length) {
          return inputString;
      }
      StringBuilder sb = new StringBuilder();
      while (sb.length() < length - inputString.length()) {
          sb.append(' ');
      }
      
      sb.insert(0, inputString);

      return sb.toString();
  }


  private List<String> readLines(String path) {
    List<String> output = new ArrayList<>();
    try {
      Path toPath = new File(path).toPath();
      output.addAll(Files.readAllLines(toPath));
      output = output.stream()
          .map(line -> {
            // Get rid of comments
            int a = line.indexOf("*");
            int b = line.indexOf(";");

            if (a == -1 && b == -1) {
              return line.trim();
            }

            int abMin = -1;
            if (a > -1 && b > -1) {
              abMin = Math.min(a, b);
            } else if (a > -1) {
              abMin = a;
            } else if (b > -1) {
              abMin = b;
            }

            return line.substring(0, abMin).trim();
          })
          .filter(line -> !line.isEmpty() && !regexBranchLabel.matches(line))
          .map(x -> {
            if (regexMemoryLabel.matches(x)){
              x = x.substring(8).trim();
            }
            return x;
          })
          .collect(Collectors.toList());

    } catch (IOException ex) {
      Logger.getLogger(Tester.class.getName()).log(Level.SEVERE, null, ex);
    }

    return output;
  }
  
  private RegularExpression regexBranchLabel = new RegularExpression("^([a-zA-Z0-9_\\.]+:?)$", "m");
  private RegularExpression regexMemoryLabel = new RegularExpression("^([0-9A-F]{8})\\s.*");
  private RegularExpression regexFooLong_L = new RegularExpression("^(.*?).B\\s+([0-9A-F]{8})\\s.*");
  private RegularExpression regexFooByteAsLong_R = new RegularExpression("^(.*?).B\\s+([0-9A-F]{8})\\s.*");
  
  private RegularExpression regexByteAsLong = new RegularExpression("000000([0-9A-F]{2})", "m");
  private RegularExpression regexByteAsWord = new RegularExpression("00([0-9A-F]{2})", "m");
  private RegularExpression regexWordAsLong = new RegularExpression("0000([0-9A-F]{4})", "m");
  private RegularExpression regexByte = new RegularExpression("([0-9A-F]{2})", "m");
  private RegularExpression regexWord = new RegularExpression("([0-9A-F]{4})", "m");
  private RegularExpression regexLong = new RegularExpression("([0-9A-F]{8})", "m");
}
