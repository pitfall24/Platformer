import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        File sourceDir = new File("resources/setup");
        File targetDir = new File("resources/tiles");

        Utilities.cleanDir(targetDir, true);
        Utilities.createTileBinaries(sourceDir, targetDir);
    }
}
