import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.util.HashMap;

static HashMap<String, Texture> loaded = new HashMap<String, Texture>();

public class Tile {
  String name;
  Texture texture;

  Body hitbox;
  int xPosition;
  int yPosition;

  boolean hasHitbox;
  boolean canInteract;

  public Tile(String name, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
    this.name = name;

    if (loaded.containsKey(this.name)) {
      this.texture = loaded.get(this.name);
    } else {
      this.texture = new Texture(name, 8, 8);

      loaded.put(this.name, this.texture);
    }

    this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;
  }

  public Tile(String name, String texturePath, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
    this.name = name;

    if (loaded.containsKey(this.name)) {
      this.texture = loaded.get(this.name);
    } else {
      ObjectInputStream objIn = new ObjectInputStream(new FileInputStream(texturePath));
      this.texture = (Texture) objIn.readObject();
      objIn.close();

      loaded.put(this.name, this.texture);
    }

    this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;
  }

  public Tile(String name, Texture texture, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
    this.name = name;
    this.texture = texture;

    this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;

    if (!loaded.containsKey(this.name)) {
      loaded.put(this.name, this.texture);
    }  
  }

  public String toString() {
    return this.texture.toString();
  }
  
  public void draw(PApplet sketch) {
    if (this.texture == null) { return; }
    
    int mode = sketch.getGraphics().rectMode;
    sketch.rectMode(PConstants.CORNER);
    
    float pixelW;
    float pixelH;
    
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        /* Make a better way to do this besides hardcoding it */
        pixelW = (float) sketch.width / (8.0 * 40.0);
        pixelH = (float) sketch.height / (8.0 * 22.0);
                
        sketch.rect(i * pixelW + this.xPosition * pixelW, sketch.height - j * pixelH - this.yPosition * pixelH, pixelW, pixelH);
        println("rect drawn at (" + (i * pixelW + this.xPosition * pixelW) + ", " + (sketch.height - j * pixelH - this.yPosition * pixelH) + ")");
        /*
        int mode = sketch.getGraphics().rectMode;
        
        sketch.rectMode(PConstants.CENTER);
        sketch.rect((float) this.xOrigin, (float) this.yOrigin, (float) this.width, (float) this.height);
        sketch.rectMode(mode);
        */
      }
    }
    
    sketch.rectMode(mode);
  }
  
  public void drawHitbox(PApplet sketch) {
    if (!this.hasHitbox) { return; }
  }
}
