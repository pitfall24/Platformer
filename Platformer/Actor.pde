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
  int width, height;

  int facing;
  
  double timeOnGround;
  double timeDashing;
  double timeGrabbing;

  boolean onGround;
  boolean dashing;
  boolean grabbing;
  boolean crouching;

  public Actor(int width, int height, int xOrigin, int yOrigin) {
    super(width, height, xOrigin, yOrigin);

    this.width = width;
    this.height = height;

    this.facing = 0;
    
    this.timeOnGround = 0.0;
    this.timeDashing = 0.0;
    this.timeGrabbing = 0.0;

    this.onGround = true;
    this.dashing = false;
    this.grabbing = false;
    this.crouching = false;
  }

  public void move(double time) {
    super.move(time);
  }

  public ArrayList<Body> checkEntityCollisions(ArrayList<Body> bodies) {
    ArrayList<Body> out = new ArrayList<Body>();

    for (Body body : bodies) {
      if (this.colliding(body)) {
        out.add(body);
      }
    }

    return out;
  }
  
  public void blindUpdate(double deltaT) {
    super.move(deltaT);
  }

  public void update(double deltaT, int steps, ArrayList<Body> bodies) {
    double timeStep = deltaT / steps;

    while (deltaT > timeStep / 2) {
      this.move(timeStep);

      ArrayList<Body> collided = this.checkEntityCollisions(bodies);
    }
  }
}
