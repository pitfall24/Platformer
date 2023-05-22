import java.io.File;
import java.util.Scanner;

public class Screen {
  final int height;
  final int width;
  final String name;
  int numSpawns;
  Location[] spawns;
  Tile[][] screen;
  

  public Screen(String name) {
    this.height = 22;
    this.width = 40;
    this.name = name;
    this.screen = new Tile[height][width];
    
    File dir = new File("C:/Users/326517/Platformer/Platformer/resources/worlds/screens");
    for (File f : dir.listFiles()) {
      System.out.println(f.getAbsolutePath());
    }
    
    this.loadScreen("C:/Users/326517/Platformer/Platformer/resources/worlds/screens/" + name + ".txt");
  }
  
  public Screen(String name, String path) {
    this.height = 22;
    this.width = 40;
    this.name = name;
    this.screen = new Tile[height][width];
    
    this.loadScreen(path);
  }
  
  public void loadScreen(String path) {
    try {
      Scanner sc = new Scanner(new File(path));
      
      assert(sc.nextLine().equals("name:" + this.name));
      sc.nextLine();
      
      {
        String ln = sc.nextLine();
        this.numSpawns = Integer.parseInt(ln.substring(ln.indexOf(":") + 1));
        this.spawns = new Location[this.numSpawns];
      }
      
      for (int i = 0; i < this.numSpawns; i++) {
        this.spawns[i] = new Location(sc.nextLine());
      }
      
      for (Location l : this.spawns) {
        System.out.println(l);
      }
      
      sc.close();
    } catch (Exception e) {
      System.out.println(e);
    }
  }
}
