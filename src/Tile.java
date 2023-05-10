public class Tile {
  String id;

  byte[][] redTexture;
  byte[][] greenTexture;
  byte[][] blueTexture;
  
  Body hitbox;
  int xPosition;
  int yPosition;
  
  boolean hasHitbox;
  boolean canInteract;

  public Tile(String id, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) {
    this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);
    
    this.id = id;
    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;
    
    this.redTexture = new byte[8][8];
    this.greenTexture = new byte[8][8];
    this.blueTexture = new byte[8][8];
    
    this.setTexture(this.id);
  }

  private void setPixel(int x, int y, byte red, byte green, byte blue) {
    this.redTexture[y][x] = red;
    this.greenTexture[y][x] = green;
    this.blueTexture[y][x] = blue;
  }
  
  private void setTexture(String id) {
    switch (id) {
      case "solid-black" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = -128;
            this.greenTexture[i][j] = -128;
            this.blueTexture[i][j] = -128;
          }
        }
        break;
      case "solid-white" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = 127;
            this.greenTexture[i][j] = 127;
            this.blueTexture[i][j] = 127;
          }
        }
        break;
      case "solid-red" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = 127;
            this.greenTexture[i][j] = -128;
            this.blueTexture[i][j] = -128;
          }
        }
        break;
      case "solid-green" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = -128;
            this.greenTexture[i][j] = 127;
            this.blueTexture[i][j] = -128;
          }
        }
        break;
      case "solid-blue" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = -128;
            this.greenTexture[i][j] = -128;
            this.blueTexture[i][j] = 127;
          }
        }
        break;
      case "solid-gray" : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = 0;
            this.greenTexture[i][j] = 0;
            this.blueTexture[i][j] = 0;
          }
        }
        break;
      case "white-spike" : 
        for (int i = 0; i < 7; i++) { this.setPixel(0, i, (byte) -128, (byte) -128, (byte) -128); }
        for (int i = 0; i < 5; i++) { this.setPixel(1, i, (byte) -128, (byte) -128, (byte) -128); }
        for (int i = 0; i < 3; i++) { this.setPixel(2, i, (byte) -128, (byte) -128, (byte) -128); }
        this.setPixel(3, 0, (byte) -128, (byte) -128, (byte) -128);
        for (int i = 0; i < 2; i++) { this.setPixel(5, i, (byte) -128, (byte) -128, (byte) -128); }
        for (int i = 0; i < 4; i++) { this.setPixel(6, i, (byte) -128, (byte) -128, (byte) -128); }
        for (int i = 0; i < 6; i++) { this.setPixel(7, i, (byte) -128, (byte) -128, (byte) -128); }

        this.setPixel(2, 7, (byte) 0, (byte) 0, (byte) 0);
        for (int i = 5; i < 8; i++) { this.setPixel(3, i, (byte) 0, (byte) 0, (byte) 0); }
        for (int i = 3; i < 8; i++) { this.setPixel(4, i, (byte) 0, (byte) 0, (byte) 0); }
        for (int i = 5; i < 8; i++) { this.setPixel(5, i, (byte) 0, (byte) 0, (byte) 0); }
        this.setPixel(6, 7, (byte) 0, (byte) 0, (byte) 0);

        this.setPixel(1, 6, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(2, 4, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(3, 2, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(4, 0, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(5, 2, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(6, 4, (byte) 68, (byte) 68, (byte) 68);
        this.setPixel(7, 6, (byte) 68, (byte) 68, (byte) 68);

        this.setPixel(0, 7, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(1, 7, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(1, 5, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(2, 5, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(2, 6, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(3, 3, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(4, 3, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(4, 4, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(3, 1, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(4, 1, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(4, 2, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(5, 3, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(5, 4, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(6, 5, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(6, 6, (byte) 127, (byte) 127, (byte) 127);
        this.setPixel(7, 7, (byte) 127, (byte) 127, (byte) 127);
        
        break;
      case "grass-ground" : 
        for (int i = 0; i < 8; i++) { this.setPixel(i, 0, (byte) -93, (byte) 50, (byte) -50); }
        
        for (int i = 1; i < 4; i++) { this.setPixel(i, 1, (byte) -115, (byte) -25, (byte) -91); }
        for (int i = 5; i < 7; i++) { this.setPixel(i, 1, (byte) -115, (byte) -25, (byte) -91); }

        for (int i = 1; i < 4; i++) { this.setPixel(i, 2, (byte) 1, (byte) -47, (byte) -106); }
        for (int i = 5; i < 7; i++) { this.setPixel(i, 2, (byte) 1, (byte) -47, (byte) -106); }
        for (int i = 0; i < 8; i++) { { for (int j = 3; j < 8; j++) this.setPixel(i, j, (byte) 1, (byte) -47, (byte) -106); } }

        this.setPixel(0, 1, (byte) -93, (byte) 50, (byte) -50);
        this.setPixel(4, 1, (byte) -93, (byte) 50, (byte) -50);
        this.setPixel(7, 1, (byte) -93, (byte) 50, (byte) -50);

        this.setPixel(0, 2, (byte) -115, (byte) -25, (byte) -91);
        this.setPixel(4, 2, (byte) -115, (byte) -25, (byte) -91);
        this.setPixel(7, 2, (byte) -115, (byte) -25, (byte) -91);
        break;
      default : 
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            this.redTexture[i][j] = -128;
            this.greenTexture[i][j] = -128;
            this.blueTexture[i][j] = -128;
          }
        }
        break;
    }
  }
}