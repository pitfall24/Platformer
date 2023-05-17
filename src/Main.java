import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        
        File sourceDir = new File("resources/textures/tiles");
        File targetDir = new File("resources/textures/bin");

        Utilities.cleanDir(targetDir, true);
        Utilities.createTileBinaries(sourceDir, targetDir);

        Tile testTile = new Tile("solid-black", "./resources/textures/bin/solid-black.bin", true, true, 0, 0);
        
        System.out.println("solid-black:");
        System.out.println(testTile);
        
        /*
        Body b1 = new Body(8, 10, 15, 20);
        Body b2 = new Body(8, 10, 19, 12);

        System.out.println(b1.colliding(b2));
        */
    }
}
