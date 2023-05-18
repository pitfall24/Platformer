import java.io.File;
import java.util.Scanner;

public class Screen {
  final int height;
  final int width;
  final String name;
  Tile[][] screen;

  public Screen(String name) {
    this.height = 22;
    this.width = 40;
    this.name = name;
    this.screen = new Tile[height][width];
  }
}
