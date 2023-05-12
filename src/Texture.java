import java.io.Serializable;
import java.util.Scanner;
import java.io.File;

public class Texture implements Serializable {
    String name;

    byte[][] redTexture;
    byte[][] greenTexture;
    byte[][] blueTexture;

    public Texture(String name) {
        this.name = name;

        this.redTexture = new byte[8][8];
        this.greenTexture = new byte[8][8];
        this.blueTexture = new byte[8][8];

        this.loadTexture(name + ".txt");
    }

    public void loadTexture(String filepath) {
        try {
            Scanner sc = new Scanner(new File(filepath));

            assert(sc.nextLine().equals("redTexture:"));
            sc.nextLine();
            for (int i = 0; i < 8; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < 8; j++) {
                    this.redTexture[i][j] = Byte.valueOf(line.substring(0, line.indexOf(",")));
                    this.redTexture[i][j] -= 128;
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            assert(sc.nextLine().equals("greenTexture:"));
            sc.nextLine();
            for (int i = 0; i < 8; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < 8; j++) {
                    this.greenTexture[i][j] = Byte.valueOf(line.substring(0, line.indexOf(",")));
                    this.redTexture[i][j] -= 128;
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            assert(sc.nextLine().equals("blueTexture:"));
            sc.nextLine();
            for (int i = 0; i < 8; i++) {
                String line = sc.nextLine();

                for (int j = 0; j < 8; j++) {
                    this.blueTexture[i][j] = Byte.valueOf(line.substring(0, line.indexOf(",")));
                    this.redTexture[i][j] -= 128;
                    line = line.substring(line.indexOf(",") + 1);
                }
            }

            sc.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
