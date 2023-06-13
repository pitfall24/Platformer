import java.io.ObjectInputStream;
import java.io.FileInputStream;
import java.util.HashMap;

public class Sprite {
  String name;
  Texture texture;

  Body hitbox;
  int xPosition;
  int yPosition;

  boolean hasHitbox;
  boolean canInteract;
  
  public Sprite(Sprite other) {
    this.name = other.name;
    this.texture = other.texture;
    
    this.hitbox = other.hitbox;
    this.xPosition = other.xPosition;
    this.yPosition = other.yPosition;
    
    this.hasHitbox = other.hasHitbox;
    this.canInteract = other.canInteract;
  }

  public Sprite(String name, String texturePath, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
    this.name = name;

    if (loaded.containsKey(this.name)) {
      this.texture = loaded.get(this.name);
    } else {
      ObjectInputStream objIn = new ObjectInputStream(new FileInputStream(texturePath));
      this.texture = (Texture) objIn.readObject();
      objIn.close();

      loaded.put(this.name, this.texture);
    }

    this.hitbox = new Body(this.texture.width, this.texture.height, xPosition + this.texture.xOrigin, yPosition + this.texture.yOrigin);
    this.xPosition = xPosition;
    this.yPosition = yPosition;

    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;
  }

  public Sprite(String name, Texture texture, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
    this.name = name;
    this.texture = texture;

    this.hitbox = new Body(8, 8, xPosition + this.texture.xOrigin, yPosition + this.texture.yOrigin);
    this.xPosition = xPosition;
    this.yPosition = yPosition;

    this.hasHitbox = hasHitbox;
    this.canInteract = canInteract;

    if (!loaded.containsKey(this.name)) {
      loaded.put(this.name, this.texture);
    }
  }

  public Sprite(Sprite other, int xPosition, int yPosition) {
    this.name = other.name;
    this.texture = other.texture;

    this.hitbox = new Body(other.texture.width, other.texture.height, xPosition + this.texture.xOrigin, yPosition + this.texture.yOrigin);
    this.xPosition = xPosition;
    this.yPosition = yPosition;

    this.hasHitbox = other.hasHitbox;
    this.canInteract = other.canInteract;
  }
  
  boolean equals(Object o) {
    Sprite other = (Sprite) o;
    
    return this.name.equals(other.name) && this.texture.equals(other.texture) && this.hasHitbox == other.hasHitbox && this.canInteract == other.canInteract;
  }

  public void draw(PApplet sketch, int tilesWide, int tilesTall) {
    if (this.texture == null) {
      return;
    }

    sketch.pushStyle();
    
    sketch.rectMode(PConstants.CORNER);
    sketch.noStroke();

    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);

    for (int i = 0; i < this.texture.width; i++) {
      for (int j = this.texture.height - 1; j >= 0; j--) {
        this.setSketchColor(sketch, i, j);
        sketch.rect(i * pixelW + this.xPosition * pixelW, j * pixelH + this.yPosition * pixelH, pixelW, pixelH);
      }
    }

    sketch.popStyle();
  }

  public void _draw(PApplet sketch, int tilesWide, int tilesTall) {
    if (this.texture == null) {
      return;
    }

    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);

    for (int i = 0; i < this.texture.width; i++) {
      for (int j = this.texture.height - 1; j >= 0; j--) {
        this.setSketchColor(sketch, i, this.texture.height - j - 1);
        sketch.rect(i * pixelW + this.xPosition * pixelW, sketch.height - (j + 1) * pixelH - this.yPosition * pixelH, pixelW, pixelH);
      }
    }
  }
  
  public void forceDrawHitbox(PApplet sketch, int tilesWide, int tilesTall) {
    this.hitbox.drawHitbox(sketch, tilesWide, tilesTall);
  }

  public void drawHitbox(PApplet sketch, int tilesWide, int tilesTall) {
    if (!this.hasHitbox) {
      return;
    }

    this.hitbox.drawHitbox(sketch, tilesWide, tilesTall);
  }

  public void setSketchColor(PApplet sketch, int i, int j) {
    sketch.fill(this.texture.redTexture[j][i] + 128, this.texture.greenTexture[j][i] + 128, this.texture.blueTexture[j][i] + 128, this.texture.alphaTexture[j][i] + 128);
  }
}
