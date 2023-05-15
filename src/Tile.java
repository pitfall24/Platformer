import java.io.ObjectInputStream;
import java.io.FileInputStream;

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
		this.texture = new Texture(name, 8, 8);

		this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

		this.hasHitbox = hasHitbox;
		this.canInteract = canInteract;

		this.texture.loadTexture(this.name);
	}

	public Tile(String name, String texturePath, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
		this.name = name;

		this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

		this.hasHitbox = hasHitbox;
		this.canInteract = canInteract;

		ObjectInputStream objIn = new ObjectInputStream(new FileInputStream(texturePath));
		this.texture = (Texture) objIn.readObject();
		objIn.close();
	}

	public String toString() {
		return this.texture.toString();
	}
}