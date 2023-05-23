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
}
