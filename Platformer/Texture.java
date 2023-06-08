import java.io.Serializable;
import java.util.Scanner;
import java.io.File;
import processing.core.PApplet;
import processing.core.PConstants;

public class Texture implements Serializable {
  String name;

  int width;
  int height;

  byte[][] redTexture;
  byte[][] greenTexture;
  byte[][] blueTexture;
  byte[][] alphaTexture;

  public Texture(String name, int width, int height) {
    this.name = name;

    this.width = width;
    this.height = height;

    this.redTexture = new byte[height][width];
    this.greenTexture = new byte[height][width];
    this.blueTexture = new byte[height][width];
    this.alphaTexture = new byte[height][width];

    this.loadTexture(name);
  }
  
  public void draw(PApplet sketch, int tilesWide, int tilesTall, double xPosition, double yPosition) {
    sketch.pushStyle();
    
    sketch.rectMode(PConstants.CORNER);
    sketch.noStroke();

    float pixelW = (float) (sketch.width / (8.0 * tilesWide));
    float pixelH = (float) (sketch.height / (8.0 * tilesTall));

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        this.setSketchColor(sketch, i, j);
        sketch.rect((float) (i * pixelW + xPosition * pixelW), (float) (j * pixelH + yPosition * pixelH), pixelW, pixelH);
      }
    }

    sketch.popStyle();
  }
  
  public void setSketchColor(PApplet sketch, int i, int j) {
    sketch.fill(this.redTexture[j][i] + 128, this.greenTexture[j][i] + 128, this.blueTexture[j][i] + 128, this.alphaTexture[j][i] + 128);
  }
  
  public boolean equals(Object o) {
    Texture other = (Texture) o;
    
    return this.name.equals(other.name);
  }

  public void loadTexture(String filepath) {
    try {
      Scanner sc = new Scanner(new File(filepath));

      assert(sc.nextLine().equals("redTexture:"));
      for (int i = 0; i < this.height; i++) {
        String line = sc.nextLine();

        for (int j = 0; j < this.width; j++) {
          this.redTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
          line = line.substring(line.indexOf(",") + 1);
        }
      }

      assert(sc.nextLine().equals("greenTexture:"));
      for (int i = 0; i < this.height; i++) {
        String line = sc.nextLine();

        for (int j = 0; j < this.width; j++) {
          this.greenTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
          line = line.substring(line.indexOf(",") + 1);
        }
      }

      assert(sc.nextLine().equals("blueTexture:"));
      for (int i = 0; i < this.height; i++) {
        String line = sc.nextLine();

        for (int j = 0; j < this.width; j++) {
          this.blueTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
          line = line.substring(line.indexOf(",") + 1);
        }
      }

      assert(sc.nextLine().equals("alphaTexture:"));
      for (int i = 0; i < this.height; i++) {
        String line = sc.nextLine();

        for (int j = 0; j < this.width; j++) {
          this.alphaTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
          line = line.substring(line.indexOf(",") + 1);
        }
      }

      sc.close();
    }
    catch (Exception e) {
      System.out.println(e);
      e.printStackTrace();
    }
  }

  public String toString() {
    String out = "";

    out += "redTexture:\n";
    for (byte[] row : this.redTexture) {
      for (byte i : row) {
        out += i + ", ";
      }
      out += "\n";
    }

    out += "greenTexture:\n";
    for (byte[] row : this.greenTexture) {
      for (byte i : row) {
        out += i + ", ";
      }
      out += "\n";
    }

    out += "blueTexture:\n";
    for (byte[] row : this.blueTexture) {
      for (byte i : row) {
        out += i + ", ";
      }
      out += "\n";
    }

    out += "alphaTexture:\n";
    for (byte[] row : this.alphaTexture) {
      for (byte i : row) {
        out += i + ", ";
      }
      out += "\n";
    }

    return out;
  }
}
