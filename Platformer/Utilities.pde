import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.util.Scanner;

public static void createTileBinaries(File sourceDir, File targetDir) throws Exception {
      for (File file : sourceDir.listFiles()) {
          Texture testTexture = new Texture(file.getAbsolutePath(), 8, 8);

          ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(targetDir.getAbsolutePath() + "/" + Utilities.removeExtension(file) + ".bin"));

          out.writeObject(testTexture);
          out.close();
      }
  }

  public static void cleanDir(File dir, boolean recursive) {
      if (!dir.isDirectory()) {
          return;
      }
      
      for (File file : dir.listFiles()) {
          if (recursive && file.isDirectory()) {
              cleanDir(file, recursive);
          } else if (!file.isDirectory()) {
              file.delete();
          }
      }
  }

  public static String removeExtension(File file) {
      if (file.isDirectory()) {
          return "";
      } else {
          return Utilities.removeExtension(file.getName());
      }
  }

  public static String removeExtension(String name) {
      int ind = name.indexOf(".");
      if (ind == -1) {
          return name;
      } else {
          return name.substring(0, ind);
      }
  }
  
  public static Screen parseScreen(File screen, String name) throws Exception {
  Scanner sc = new Scanner(screen);

  {
    String firstLine = sc.nextLine();
    int left = firstLine.indexOf(":") + 2;

    if (!name.equals(firstLine.substring(left))) {
      sc.close();
      throw new Exception("");
    }
  }

  Screen out = new Screen(name);

  while (sc.hasNextLine()) {
    String line = sc.nextLine();

    
  }

  sc.close();

  return out;
}
