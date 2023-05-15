import java.io.Serializable;
import java.util.Scanner;
import java.io.File;

public class Texture implements Serializable {
    String name;

    int width;
    int height;

    byte[][] redTexture;
    byte[][] greenTexture;
    byte[][] blueTexture;

    public Texture(String name, int width, int height) {
        this.name = name;

        this.width = width;
        this.height = height;

        this.redTexture = new byte[height][width];
        this.greenTexture = new byte[height][width];
        this.blueTexture = new byte[height][width];

        this.loadTexture(name);
    }

    public void loadTexture(String filepath) {
        try {
            Scanner sc = new Scanner(new File(filepath));

            assert(sc.nextLine().equals("redTexture:"));
            sc.nextLine();
            for (int i = 0; i < this.height; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < this.width; j++) {
                    this.redTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            assert(sc.nextLine().equals("greenTexture:"));
            sc.nextLine();
            for (int i = 0; i < this.height; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < this.width; j++) {
                    this.greenTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            assert(sc.nextLine().equals("blueTexture:"));
            sc.nextLine();
            for (int i = 0; i < this.height; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < this.width; j++) {
                    this.blueTexture[i][j] = Byte.valueOf("" + (Integer.valueOf(line.substring(0, line.indexOf(","))) - 128));
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            sc.close();
        } catch (Exception e) {
            System.out.println(e);
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

        return out;
    }
}
