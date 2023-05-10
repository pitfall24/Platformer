public class World {
    Tree<Screen> world;

    public World() {
        this.world = new Tree<Screen>();
    }

    public World(String filename) {
        this.world = new Tree<Screen>();

        this.loadTree(filename);
    }

    public void loadTree(String filename) {
        
    }
}