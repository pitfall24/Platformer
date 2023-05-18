import processing.core.PApplet;
import processing.core.PConstants;

public class Body extends PApplet {
  int width, height;
  double xOrigin, yOrigin;
  double xVelocity, yVelocity;
  double xAcceleration, yAcceleration;
  double xJerk, yJerk;

  public Body(int width, int height, double xOrigin, double yOrigin) {
    this.width = width;
    this.height = height;

    this.xOrigin = xOrigin;
    this.yOrigin = yOrigin;

    this.xVelocity = 0.0;
    this.yVelocity = 0.0;
    this.xAcceleration = 0.0;
    this.yAcceleration = 0.0;
    this.xJerk = 0.0;
    this.yJerk = 0.0;
  }

  public void move(double time) {
    // For decent jump curve thingy:
    // yOrigin=0, yVelocity=10, vAcceleration=-9.8, yJerk=3.3
    // Once passed yOrigin going down or interacted with something, set yJerk=0 so
    // you dont fly to infinity.

    this.xOrigin += (1.0 / 6.0) * this.xJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.xAcceleration * Math.pow(time, 2.0) + this.xVelocity * time;
    this.yOrigin += (1.0 / 6.0) * this.yJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.yAcceleration * Math.pow(time, 2.0) + this.yVelocity * time;

    this.xVelocity += (1.0 / 2.0) * this.xJerk * Math.pow(time, 2.0) + this.xAcceleration * time;
    this.yVelocity += (1.0 / 2.0) * this.yJerk * Math.pow(time, 2.0) + this.yAcceleration * time;

    this.xAcceleration += this.xJerk * time;
    this.yAcceleration += this.yJerk * time;
  }

  public void setPosition(double xDest, double yDest) {
    this.xOrigin = xDest;
    this.yOrigin = yDest;

    this.xVelocity = 0.0;
    this.yVelocity = 0.0;

    this.xAcceleration = 0.0;
    this.yAcceleration = 0.0;

    this.xAcceleration = 0.0;
    this.yAcceleration = 0.0;
  }

  public void teleport(double xDest, double yDest) {
    this.xOrigin = xDest;
    this.yOrigin = yDest;
  }

  public int getIntXPosition() {
    return (int) Math.round(this.xOrigin);
  }

  public int getIntYPosition() {
    return (int) Math.round(this.yOrigin);
  }

  public boolean colliding(Body other) {
    boolean xOverlap = this.xOrigin - this.width / 2 < other.xOrigin + other.width / 2 && this.xOrigin + this.width / 2 > other.xOrigin - other.width / 2;
    boolean yOverlap = this.yOrigin + this.height / 2 > other.yOrigin - other.height / 2 && this.yOrigin - this.height / 2 < other.yOrigin + other.height / 2;

    return xOverlap && yOverlap;
  }

  public void draw(PApplet sketch) {
    int mode = sketch.getGraphics().rectMode;
    
    sketch.rectMode(PConstants.CENTER);
    sketch.rect((float) this.xOrigin, (float) this.yOrigin, (float) this.width, (float) this.height);
    sketch.rectMode(mode);
  }
}