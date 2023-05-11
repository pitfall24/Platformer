import java.util.Scanner;
import java.io.File;

public class Tile {
	String name;

	byte[][] redTexture;
	byte[][] greenTexture;
	byte[][] blueTexture;

	Body hitbox;
	int xPosition;
	int yPosition;

	boolean hasHitbox;
	boolean canInteract;

	public Tile(String name, boolean hasHitbox, boolean canInteract, int xPosition, int yPosition) throws Exception {
		this.hitbox = new Body(8, 8, xPosition + 4.0, yPosition + 4.0);

		this.name = name;
		this.hasHitbox = hasHitbox;
		this.canInteract = canInteract;

		this.redTexture = new byte[8][8];
		this.greenTexture = new byte[8][8];
		this.blueTexture = new byte[8][8];

		this.setTexture(this.name);
	}

	private void setTexture(String name) throws Exception {
		Scanner sc = new Scanner(new File(".\\resources\\tiles\\" + name + ".txt"));

		String ln = sc.nextLine();
		for (int i = 0; i < 8; i++) {
			ln = sc.nextLine();

			for (int j = 0; j < 8; j++) {
				this.redTexture[i][j] = Byte.valueOf(ln.substring(0, ln.indexOf(",")));
				
			}
		}
		sc.nextLine();
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				this.greenTexture[i][j] = sc.nextByte();
				sc.next();
			}
			sc.next();
		}
		sc.nextLine();
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				this.blueTexture[i][j] = sc.nextByte();
				sc.next();
			}
			sc.next();
		}

		sc.close();
	}

	public String toString() {
		String out = "";

		out += "redTexture:\n";
		for (byte[] row : this.redTexture) {
			for (byte c : row) {
				out += c + ", ";
			}
			out += "\n";
		}
		out += "greenTexture:\n";
		for (byte[] row : this.greenTexture) {
			for (byte c : row) {
				out += c + ", ";
			}
			out += "\n";
		}
		out += "blueTexture:\n";
		for (byte[] row : this.blueTexture) {
			for (byte c : row) {
				out += c + ", ";
			}
			out += "\n";
		}

		return out;
	}
}