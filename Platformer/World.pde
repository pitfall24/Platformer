import java.io.File;

public class World {
  Tree<Pair<Screen, ArrayList<Layer>>> world;
  Pair<Screen, ArrayList<Layer>> currentlyOn;
  Actor player;

  public World(Pair<Screen, ArrayList<Layer>> start) {
    this.world = new Tree<Pair<Screen, ArrayList<Layer>>>(start);
    this.currentlyOn = start;

    this.player = new Actor(8, 10, start.first.spawns[0].xPos, start.first.spawns[0].yPos);
  }

  public World(String path) {
    this.world = new Tree<Pair<Screen, ArrayList<Layer>>>();

    this.loadTree(path);
  }

  public void loadTree(String path) {
    File file = new File(path);

    
  }

  public Screen parseScreen(File screen, String name) {
    Screen out = new Screen(name);

    return out;
  }
}
