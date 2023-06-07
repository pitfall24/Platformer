import java.io.File; //<>//
import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap;

public class Screen {
  final int height;
  final int width;
  final String name;
  int numSpawns;
  Location[] spawns;
  Tile[][] screen;
  
  public Screen() {
    this.height = 22;
    this.width = 40;
    this.name = "";
  }
  
  public Screen(String name) {
    this.height = 22;
    this.width = 40;
    this.name = name;
    this.screen = new Tile[height][width];

    this.loadScreen(absoluteRepoPath() + "/resources/worlds/screens/" + name + ".txt");
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

        assert(ln.substring(0, ln.indexOf(":")).equals("locations"));

        this.numSpawns = Integer.parseInt(ln.substring(ln.indexOf(":") + 1));
        this.spawns = new Location[this.numSpawns];
      }

      for (int i = 0; i < this.numSpawns; i++) {
        try {
          this.spawns[i] = new Location(sc.nextLine());
        }
        catch (Exception e) {
          System.out.println("Number of given locations or their format does not match:");
          System.out.println(e);
        }
      }

      int numTiles;
      HashMap<String, Tile> tiles = new HashMap<String, Tile>();
      {
        String ln = sc.nextLine();

        assert(ln.substring(0, ln.indexOf(":")).equals("tiles"));

        numTiles = Integer.parseInt(ln.substring(ln.indexOf(":") + 1));
      }

      for (int i = 0; i < numTiles; i++) {
        String ln = sc.nextLine();

        String label = ln.substring(0, ln.indexOf(":"));
        String name = ln.substring(ln.indexOf(":") + 1, ln.indexOf(";"));
        String info = ln.substring(ln.indexOf(";") + 1);

        boolean hasHitbox = info.substring(0, info.indexOf(";")).equals("true");
        boolean canInteract = info.substring(info.indexOf(";") + 1).equals("true;");

        if (tiles.containsKey(label)) {
          throw new Exception("Redefinition of tile label `" + label + "`");
        } else {
          tiles.put(label, new Tile(name, absoluteRepoPath() + "/resources/textures/bin/" + name + ".bin", hasHitbox, canInteract, 0, 0));
        }
      }

      assert(sc.nextLine().equals("screen:"));
      for (int i = 0; i < this.height; i++) {
        String ln = sc.nextLine();
        for (int j = 0; j < this.width; j++) {
          String next = ln.substring(0, ln.indexOf(","));
          ln = ln.substring(next.length() + 1);

          if (!tiles.containsKey(next)) {
            throw new Exception("tile label `" + next + "` used but never defined");
          } else {
            this.screen[i][j] = new Tile(tiles.get(next), j * 8, this.height * 8 - i * 8 - 8);
          }
        }
      }

      sc.close();
    }
    catch (Exception e) {
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
    sketch.pushStyle();
    
    sketch.rectMode(PConstants.CORNER);
    sketch.noStroke();

    for (Tile[] row : this.screen) {
      for (Tile tile : row) {
        tile._draw(sketch, this.width, this.height);
      }
    }

    sketch.popStyle();
  }

  public void drawHitboxes(PApplet sketch) {
    for (Tile[] row : this.screen) {
      for (Tile tile : row) {
        tile.drawHitbox(sketch, this.width, this.height);
      }
    }
  }

  public void drawHitboxes(PApplet sketch, ArrayList<Pair<Integer, Integer>> tiles) {
    for (Pair<Integer, Integer> point : tiles) {
      this.screen[point.second][point.first].drawHitbox(sketch, this.width, this.height);
    }
  }
}
