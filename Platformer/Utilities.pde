import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.util.Scanner;

public void refreshTileBinaries() throws Exception {
  File targetDir = new File(absoluteRepoPath() + "/resources/textures/bin");
  ArrayList<File> sourceDirs = new ArrayList<File>();
  
  sourceDirs.add(new File(absoluteRepoPath() + "/resources/textures/tiles"));
  sourceDirs.add(new File(absoluteRepoPath() + "/resources/textures/sprites"));

  cleanDir(targetDir, false);
  createTileBinaries(sourceDirs, targetDir);
}

public void createTileBinaries(ArrayList<File> sourceDirs, File targetDir) throws Exception {
  for (File sourceDir : sourceDirs) {
    for (File file : sourceDir.listFiles()) {
      Texture texture = new Texture(file.getAbsolutePath());

      ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(targetDir.getAbsolutePath() + "/" + removeExtension(file) + ".bin"));

      out.writeObject(texture);
      out.close();
    }
  }
}

public void createTileBinaries(File sourceDir, File targetDir) throws Exception {
  for (File file : sourceDir.listFiles()) {
    Texture texture = new Texture(file.getAbsolutePath());

    ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(targetDir.getAbsolutePath() + "/" + removeExtension(file) + ".bin"));

    out.writeObject(texture);
    out.close();
  }
}

public void cleanDir(File dir, boolean recursive) {
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

public boolean hasExtension(File file, String extension) {
  return hasExtension(file.getName(), extension);
}

public boolean hasExtension(String path, String extension) {
  return path.indexOf(extension) == path.length() - extension.length() && path.charAt(path.indexOf(extension) - 1) == '.';
}

public String removeExtension(File file) throws Exception {
  if (file.isDirectory()) {
    throw new Exception("Cannot remove extension from directory");
  } else {
    return removeExtension(file.getName());
  }
}

public String removeExtension(String name) {
  int ind = name.indexOf(".");
  if (ind == -1) {
    return name;
  } else {
    return name.substring(0, ind);
  }
}

public Screen parseScreen(File screen, String name) throws Exception {
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

public String absoluteRepoPath() {
  String os = System.getProperty("os.name");

  if (os.equals("Windows 10")) {
    return "C:/Users/326517/Platformer/Platformer/";
  } else {
    return "/Users/phineas/Documents/Java/Platformer/";
  }
}

public double dot(double x1, double y1, double x2, double y2) {
  return x1 * x2 + y1 * y2;
}
