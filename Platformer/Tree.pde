import java.util.ArrayList;

class Tree<T> {
  public T node;
  public ArrayList<Tree<T>> connections;

  public Tree() {
    this.node = null;
    this.connections = new ArrayList<Tree<T>>(0);
  }

  public Tree(T node) {
    this.node = node;
    this.connections = new ArrayList<Tree<T>>(0);
  }

  public Tree(T node, ArrayList<Tree<T>> connections) {
    this.node = node;
    this.connections = connections;

    for (Tree<T> tree : connections) {
      tree.connections.add(this);
    }
  }

  public boolean isIsland() {
    return this.connections.size() == 0;
  }

  public boolean isLeaf() {
    return this.connections.size() == 1;
  }
}
