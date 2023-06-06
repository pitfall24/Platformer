import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.util.Scanner;

public void refreshTileBinaries() throws Exception {
  File targetDir = new File(absoluteRepoPath() + "/resources/textures/bin");
  File sourceDir = new File(absoluteRepoPath() + "/resources/textures/tiles");
  
  cleanDir(targetDir, false);  
  createTileBinaries(sourceDir, targetDir);
}

public void createTileBinaries(File sourceDir, File targetDir) throws Exception {
  for (File file : sourceDir.listFiles()) {
    Texture texture = new Texture(file.getAbsolutePath(), 8, 8);
    
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

public ArrayList<Body> getBodies(ArrayList<Tile> tiles) {
  ArrayList<Body> out = new ArrayList<Body>(tiles.size());
  
  for (Tile tile : tiles) {
    out.add(tile.hitbox);
  }
  
  return out;
}

public ArrayList<Body> getBodies(Pair<ArrayList<Tile>, ArrayList<Tile>> pairs) {
  ArrayList<Body> out = new ArrayList<Body>(pairs.first.size());
  
  for (Tile tile : pairs.first) {
    out.add(tile.hitbox);
  }
  
  return out;
}
