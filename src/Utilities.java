import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.File;

public class Utilities {
    public static void createBinaries(File sourceDir, File targetDir) throws Exception {
        for(File file: targetDir.listFiles()) {
            if (!file.isDirectory()) {
                file.delete();
            }
        }
        
        for (File file : sourceDir.listFiles()) {
            Texture testTexture = new Texture(file.getAbsolutePath());
            
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(".\\resources\\tiles\\" + file.getName() + ".bin"));

            out.writeObject(testTexture);

            out.close();
        }
    }
}
