package splashgen;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import javax.imageio.ImageIO;

/**
 *
 * @author Taylor
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {        
        makeSplashBitmap();
    }
    public static void makeSplashBitmap() throws IOException{
        File f = new File("splash.png");
		File fo = new File("out.txt");
		PrintStream ps = new PrintStream(fo);
		
		if (f.exists()){
			BufferedImage bi = ImageIO.read(f);
			System.out.println("W: "+bi.getWidth());
			System.out.println("H: "+bi.getHeight());
			int scale = 640;
			scale /= bi.getWidth(); // If 640, then you have scale of 1. If 320, scale of 2, and so on.
			
			StringBuilder sb = new StringBuilder("BMP_IMG_ZOOM\tEQU\t"+scale+"\r\n");
			sb.append("BMP_ARRAY:");
			int cnt = 0;
			for(int y = 0; y < bi.getHeight(); y++){
				for (int x = 0; x < bi.getWidth(); x++){
					if (cnt % 16 == 0){
						sb.append("\r\n\tDC.L\t");
					}else{
						 sb.append(", ");
					}
					
					int rgb = bi.getRGB(x, y);
					Color c = new Color(rgb);
                    sb.append(String.format("$%02x%02x%02x", c.getBlue() , c.getGreen(),c.getRed()));
					cnt++;
				}
			}
			ps.print(sb.toString());
			ps.flush();
		}else{
			System.err.println("Could not find splash.png");
		}
    }
}
