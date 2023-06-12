import java.util.ArrayList;

public enum Direction {
  UP        (0x1),
    DOWN      (0x2),
    LEFT      (0x4),
    RIGHT     (0x8),
    UPRIGHT   (0x10),
    DOWNRIGHT (0x20),
    UPLEFT    (0x40),
    DOWNLEFT  (0x80);

  public final byte label;

  private Direction(int label) {
    this.label = (byte) label;
  }
}

public class Actor extends Body {
  int facing;
  int dashes;

  double timeOnGround;
  double timeDashing;
  double timeGrabbing;

  boolean onGround;
  boolean dashing;
  boolean grabbing;
  boolean crouching;

  Texture texture;
  double textureX;
  double textureY;

  public Actor(int width, int height, int xOrigin, int yOrigin) {
    super(width, height, xOrigin, yOrigin);

    this.width = width;
    this.height = height;

    this.facing = 0;
    this.dashes = 1;

    this.timeOnGround = 0.0;
    this.timeDashing = 0.0;
    this.timeGrabbing = 0.0;

    this.onGround = true;
    this.dashing = false;
    this.grabbing = false;
    this.crouching = false;
  }

  public Actor(int width, int height, int xOrigin, int yOrigin, Texture texture, double textureX, double textureY) {
    super(width, height, xOrigin, yOrigin);

    this.width = width;
    this.height = height;

    this.facing = 0;
    this.dashes = 1;

    this.timeOnGround = 0.0;
    this.timeDashing = 0.0;
    this.timeGrabbing = 0.0;

    this.onGround = true;
    this.dashing = false;
    this.grabbing = false;
    this.crouching = false;

    this.texture = texture;
    this.textureX = textureX;
    this.textureY = textureY;
  }

  public Actor(int width, int height, int xOrigin, int yOrigin, String texturePath, double textureX, double textureY) {
    super(width, height, xOrigin, yOrigin);

    this.width = width;
    this.height = height;

    this.facing = 0;
    this.dashes = 1;

    this.timeOnGround = 0.0;
    this.timeDashing = 0.0;
    this.timeGrabbing = 0.0;

    this.onGround = true;
    this.dashing = false;
    this.grabbing = false;
    this.crouching = false;

    this.texture = this.getTexture(texturePath);
    this.textureX = textureX;
    this.textureY = textureY;
  }

  public Actor(int width, int height, int xOrigin, int yOrigin, String texturePath, int textureW, int textureH, double textureX, double textureY) {
    super(width, height, xOrigin, yOrigin);

    this.width = width;
    this.height = height;

    this.facing = 0;
    this.dashes = 1;

    this.timeOnGround = 0.0;
    this.timeDashing = 0.0;
    this.timeGrabbing = 0.0;

    this.onGround = true;
    this.dashing = false;
    this.grabbing = false;
    this.crouching = false;

    this.texture = new Texture(texturePath, textureW, textureH);
    this.textureX = textureX;
    this.textureY = textureY;
  }

  public Actor(Actor other) {
    super((Body) other);

    this.width = other.width;
    this.height = other.height;

    this.facing = other.facing;
    this.dashes = other.dashes;

    this.timeOnGround = other.timeOnGround;
    this.timeDashing = other.timeOnGround;
    this.timeGrabbing = other.timeGrabbing;

    this.onGround = other.onGround;
    this.dashing = other.dashing;
    this.grabbing = other.grabbing;
    this.crouching = other.crouching;
  }

  public void act(PApplet sketch, Screen screen, double deltaT, HashMap<Integer, Pair<Boolean, Boolean>> inputs) {
    Direction dir = this.update(sketch, deltaT, 10, screen);
    
    if (this.isOnGround(screen)) {
      this.dashing = false;
      this.timeOnGround += 1 / sketch.frameRate;
      
      this.onGround = true;
    } else {
      this.onGround = false;
      this.timeOnGround = 0;
    }
    
  }

  public Texture getTexture(String texturePath) {
    try {
      Texture out;

      ObjectInputStream objIn = new ObjectInputStream(new FileInputStream(texturePath));
      out = (Texture) objIn.readObject();
      objIn.close();

      return out;
    }
    catch (Exception e) {
      e.printStackTrace();

      return null;
    }
  }

  public void draw(PApplet sketch, int tilesWide, int tilesTall) {
    if (this.texture == null) {
      super.draw(sketch, tilesWide, tilesTall);
    } else {
      this.texture.draw(sketch, tilesWide, tilesTall, this.xOrigin + this.textureX - this.width / 2.0, this.yOrigin + this.textureY - this.height / 2.0);
    }
  }

  public void blindUpdate(double deltaT) {
    this.move(deltaT);
  }

  public Direction update(PApplet sketch, double deltaT, int steps, ArrayList<Body> bodies) {
    // might not need direction for updating non-tile bodies
    return super.update(sketch, deltaT, steps, bodies, false);
  }

  public Direction update(PApplet sketch, double deltaT, int steps, Screen screen) {
    return super.update(sketch, deltaT, steps, screen, false);
  }

  public boolean isOnGround(Screen screen) {
    int leftX = min(screen.width - 1, max(0, (int) ((this.xOrigin - this.width / 2) / 8)));
    int rightX = min(screen.width - 1, max(0, (int) ((this.xOrigin + this.width / 2) / 8)));

    int y = min(screen.height - 1, max(0, (int) ((this.yOrigin - this.height / 2.05) / 8) - 1));

    for (int i = leftX; i <= rightX; i++) {
      if (screen.screen[screen.height - y - 1][i].hasHitbox && abs((float) (this.yOrigin - this.height / 2 - (screen.screen[screen.height - y - 1][i].hitbox.yOrigin + screen.screen[screen.height - y - 1][i].hitbox.height / 2))) < 0.05) {
        return true;
      }
    }

    return false;
  }
}
