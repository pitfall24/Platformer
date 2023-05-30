import java.io.File;

public class World {
    Tree<Screen> world;
    Screen currentlyOn;
    Actor player;

    public World(Screen start) {
        this.world = new Tree<Screen>(start);
        this.currentlyOn = start;
        
        this.player = new Actor(8, 10, start.spawns[0].xPos, start.spawns[0].yPos);
    }

    public World(String directory) {
        this.world = new Tree<Screen>();

        this.loadTree(directory);
    }

    public void loadTree(String directory) {
        File dir = new File(directory);

        for (File screen : dir.listFiles()) {
            System.out.println(screen.getName());

            Screen cur = this.parseScreen(screen, screen.getName());
        }
    }

    public Screen parseScreen(File screen, String name) {
        Screen out = new Screen(name);

        return out;
    }
}
