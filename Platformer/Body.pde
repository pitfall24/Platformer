public class Body {
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
  
  public Body(Body other) {
    this.width = other.width;
    this.height = other.height;

    this.xOrigin = other.xOrigin;
    this.yOrigin = other.yOrigin;

    this.xVelocity = other.xVelocity;
    this.yVelocity = other.yVelocity;
    this.xAcceleration = other.xAcceleration;
    this.yAcceleration = other.yAcceleration;
    this.xJerk = other.xJerk;
    this.yJerk = other.yJerk;
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
  
  public void unmove(double time) {
    this.xAcceleration -= this.xJerk * time;
    this.yAcceleration -= this.yJerk * time;

    this.xVelocity -= (1.0 / 2.0) * this.xJerk * Math.pow(time, 2.0) + this.xAcceleration * time;
    this.yVelocity -= (1.0 / 2.0) * this.yJerk * Math.pow(time, 2.0) + this.yAcceleration * time;
    
    this.xOrigin -= (1.0 / 6.0) * this.xJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.xAcceleration * Math.pow(time, 2.0) + this.xVelocity * time;
    this.yOrigin -= (1.0 / 6.0) * this.yJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.yAcceleration * Math.pow(time, 2.0) + this.yVelocity * time;
  }
  
  public void unmoveX(double time) {
    this.xAcceleration -= this.xJerk * time;
    this.xVelocity -= (1.0 / 2.0) * this.xJerk * Math.pow(time, 2.0) + this.xAcceleration * time;
    this.xOrigin -= (1.0 / 6.0) * this.xJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.xAcceleration * Math.pow(time, 2.0) + this.xVelocity * time;
  }
  
  public void unmoveY(double time) {
    this.yAcceleration -= this.yJerk * time;
    this.yVelocity -= (1.0 / 2.0) * this.yJerk * Math.pow(time, 2.0) + this.yAcceleration * time;
    this.yOrigin -= (1.0 / 6.0) * this.yJerk * Math.pow(time, 3.0)
        + (1.0 / 2.0) * this.yAcceleration * Math.pow(time, 2.0) + this.yVelocity * time;
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
    if (this == other) {
      return false;
    }
    
    boolean xOverlap = this.xOrigin - this.width / 2 < other.xOrigin + other.width / 2 && this.xOrigin + this.width / 2 > other.xOrigin - other.width / 2;
    boolean yOverlap = this.yOrigin + this.height / 2 > other.yOrigin - other.height / 2 && this.yOrigin - this.height / 2 < other.yOrigin + other.height / 2;

    return xOverlap && yOverlap;
  }
  
  public ArrayList<Pair<Body, Direction>> checkEntityCollisions(ArrayList<Body> bodies) {
    ArrayList<Pair<Body, Direction>> out = new ArrayList<Pair<Body, Direction>>();

    for (Body body : bodies) {
      if (this.colliding(body)) {
        Direction dir;
        
        /*
        Logic for which direction  the two bodies collided in.
        e.g. Directions.LEFT means (other) `body` collided into the left side of `this`.
        Figure out at some point
        */
        
        
        
        out.add(new Pair<Body, Direction>(body, dir));
      }
    }

    return out;
  }
  
  public void update(double deltaT, int steps, ArrayList<Body> bodies) {
    double timeStep = deltaT / steps;

    while (deltaT > timeStep / 2) {
      this.move(timeStep);
      ArrayList<Pair<Body, Direction>> collided = this.checkEntityCollisions(bodies);
      
      
      
      deltaT -= timeStep;
    }
  }

  public void draw(PApplet sketch) {
    int mode = sketch.getGraphics().rectMode;
    
    sketch.rectMode(PConstants.CENTER);
    sketch.rect((float) this.xOrigin, (float) (sketch.height - this.yOrigin), (float) this.width, (float) this.height);
    sketch.rectMode(mode);
  }
  
  public void draw(PApplet sketch, int tilesWide, int tilesTall) {
    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);
    
    int mode = sketch.getGraphics().rectMode;
    
    sketch.rectMode(PConstants.CENTER);
    sketch.rect((float) (this.xOrigin * pixelW), (float) (sketch.height - this.yOrigin * pixelH), (float) (this.width * pixelW), (float) (this.height * pixelH));
    sketch.rectMode(mode);
  }
  
  public void drawHitbox(PApplet sketch, int tilesWide, int tilesTall) {
    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);
    float boxWidth = min(pixelW, pixelH);
        
    int mode = sketch.getGraphics().rectMode;
    color c = sketch.getGraphics().fillColor;
    
    sketch.rectMode(PConstants.CENTER);
    sketch.stroke(0, 0, 255);
    sketch.fill(0, 0, 0, 0);
    sketch.strokeWeight(boxWidth);
    
    sketch.rect((float) this.xOrigin * pixelW, (float) (tilesTall * pixelH * 8.0 - this.yOrigin * pixelH), (float) this.width * boxWidth - boxWidth, (float) this.height * boxWidth - boxWidth);
    
    sketch.noStroke();
    sketch.rectMode(mode);
    sketch.fill(c);
  }
  
  public void drawHitbox(PApplet sketch) {
    float pixelW = max((float) this.width / 25.0, 3.0);
    float pixelH = max((float) this.height / 25.0, 3.0);
    float boxWidth = min(pixelW, pixelH);
    
    int mode = sketch.getGraphics().rectMode;
    sketch.rectMode(PConstants.CENTER);
    sketch.stroke(0, 0, 255);
    sketch.fill(0, 0, 0, 0);
    sketch.strokeWeight(boxWidth);
    
    sketch.rect((float) this.xOrigin, (float) (sketch.height - this.yOrigin), (float) this.width - boxWidth, (float) this.height - boxWidth);
    
    sketch.noStroke();
    sketch.rectMode(mode);
  }
}
