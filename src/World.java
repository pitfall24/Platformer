import java.io.File;

public class World {
    Tree<Screen> world;
    Actor player;

    public World() {
        this.world = new Tree<Screen>();
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