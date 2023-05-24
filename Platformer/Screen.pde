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
      
      {
        String ln = sc.nextLine();

        this.numSpawns = Integer.parseInt(ln.substring(ln.indexOf(":") + 1));
        this.spawns = new Location[this.numSpawns];
      }
      
      for (int i = 0; i < this.numSpawns; i++) {
        try {
          this.spawns[i] = new Location(sc.nextLine());
        } catch (Exception e) {
          System.out.println("Number of given locations or their format does not match:");
          System.out.println(e);
        }
      }
      
      assert(sc.nextLine().equals("tiles:"));
      for (int i = 0; i < this.height; i++) {
        String ln = sc.nextLine();
        for (int j = 0; j < this.width; j++) {
          String next = ln.substring(0, ln.indexOf(","));
          ln = ln.substring(next.length() + 1);
          
          this.screen[i][j] = new Tile(next, "C:/Users/326517/Platformer/Platformer/resources/textures/bin/" + next + ".bin", true, false, j * 8, i * 8);
        }
      }
      
      sc.close();
    } catch (Exception e) {
      System.out.println(e);
    }
  }
  
  public String toString() {
    String out = this.name + "\n";
    
    out += "width: " + this.width + ", height: " + this.height + ", numSpawns: " + this.numSpawns + "\n";
    out += "spawnLocations:\n";
    
    for (Location loc : this.spawns) {
      out += loc + "\n";
    }
    
    for (Tile[] row : this.screen) {
      for (Tile tile : row) {
        out += tile.name + ", ";
      }
      out += "\n";
    }
    
    return out;
  }
  
  public void draw(PApplet sketch) {
    for (Tile[] row : this.screen) {
      for (Tile tile : row) {
        tile.draw(sketch);
      }
    }
  }
}
