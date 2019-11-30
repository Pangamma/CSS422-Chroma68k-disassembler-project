/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package info.taylorlove.opcodewriter.opcodes;

/**
 *
 * @author prota
 */
public enum EaFormat {

  f_xxxx_xxx_x_00_mmm_nnn("ea_pattern_ori_to_ccr"),
  f_xxxx_xxx_x_01_mmm_nnn("ea_pattern_ori_to_sr"),
  f_xxxx_xxx_x_ss_mmm_nnn("ea_pattern_ori"),
  f_xxxx_xxx_x_xx_mmm_nnn("ea_pattern_jsr"),
  f_xxxx_ddd_x_xx_mmm_nnn("ea_pattern_xxxx_ddd_x_xx_mmm_nnn"), // BSTS formats with the ddd stuff
  
  ;
  private String subroutineName;

  EaFormat(String subroutineName) {
    this.subroutineName = subroutineName;
  }
}
