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
  
  public boolean diagonalMoveRequired(Body thisCopy, Body other, Body otherCopy) {
    double relX = other.xOrigin - otherCopy.xOrigin - (this.xOrigin - thisCopy.xOrigin);
    double relY = other.yOrigin - otherCopy.yOrigin - (this.yOrigin - thisCopy.yOrigin);
    
    return false;
  }
  
  public ArrayList<Pair<Body, Direction>> checkEntityCollisions(ArrayList<Body> bodies, double deltaT) {
    ArrayList<Pair<Body, Direction>> out = new ArrayList<Pair<Body, Direction>>();
    
    Body copy = new Body(this);
    copy.unmove(deltaT);
    
    for (Body body : bodies) {
      if (this.colliding(body)) {
        Direction dir = Direction.UP; // default to moving up;
        /*
        Logic for which direction  the two bodies collided in.
        e.g. Directions.LEFT means (other) `body` collided into the left side of `this`.
        If returned direction is for example UP, we move `this` up
        */
        
        Body copyB = new Body(body);
        copyB.unmove(deltaT);
        
        double relX = body.xOrigin - copyB.xOrigin - (this.xOrigin - copy.xOrigin);
        double relY = body.yOrigin - copyB.yOrigin - (this.yOrigin - copy.yOrigin);
        
        println("relX=" + relX + ", relY=" + relY);
        if (diagonalMoveRequired(copy, body, copyB)) {
          // diagonally move to a corner
          println("diagonal move required");
          if (relX >= 0) {
            if (relY >= 0) {
              dir = Direction.UPRIGHT;
            } else {
              dir = Direction.DOWNRIGHT;
            }
          } else {
            if (relY >= 0) {
              dir = Direction.UPLEFT;
            } else {
              dir = Direction.DOWNLEFT;
            }
          }
        } else if (abs((float) relX) > abs((float) relY)) {
          // move left/right
          println("left/right move");
          if (relX >= 0) {
            dir = Direction.RIGHT;
          } else {
            dir = Direction.LEFT;
          }
        } else {
          println("up/down move");
          // move up/down
          if (relY >= 0) {
            dir = Direction.UP;
          } else {
            dir = Direction.DOWN;
          }
        }
        
        println("dir=" + dir);
        out.add(new Pair<Body, Direction>(body, dir));
      }
    }

    return out;
  }
  
  public void update(double deltaT, int steps, ArrayList<Body> bodies) {
    double timeStep = deltaT / steps;

    while (deltaT > timeStep / 2) {
      this.move(timeStep);
      ArrayList<Pair<Body, Direction>> collided = this.checkEntityCollisions(bodies, deltaT);
      
      if (collided.size() != 0) {
        println("collision happened");
        // handle collision
        for (Pair<Body, Direction> body : collided) {
          switch (body.second) {
            case UP: {
              println("case UP");
              if (this.yOrigin < body.first.yOrigin) {
                this.yOrigin = body.first.yOrigin + (this.height + body.first.height) / 2.0;
              }
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
            case DOWN: {
              println("case DOWN");
              if (this.yOrigin > body.first.yOrigin) {
                this.yOrigin = body.first.yOrigin - (this.height + body.first.height) / 2.0;
              }
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
            case LEFT: {
              println("case LEFT");
              if (this.xOrigin < body.first.xOrigin) {
                this.xOrigin = body.first.xOrigin + (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              break;
            }
            case RIGHT: {
              println("case RIGHT");
              if (this.xOrigin > body.first.xOrigin) {
                this.xOrigin = body.first.xOrigin - (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              break;
            }
            case UPRIGHT: {
              println("case UPRIGHT");
              if (this.yOrigin - this.height / 2.0 < body.first.yOrigin + body.first.height / 2.0) {
                println("first if");
                this.yOrigin = body.first.yOrigin + (this.height + body.first.height) / 2.0;
              }
              if (this.xOrigin - this.width / 2.0 > body.first.xOrigin + body.first.width / 2.0) {
                println("second if");
                this.xOrigin = body.first.xOrigin + (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
            case UPLEFT: {
              println("case UPLEFT");
              if (this.yOrigin < body.first.yOrigin) {
                this.yOrigin = body.first.yOrigin + (this.height + body.first.height) / 2.0;
              }
              if (this.xOrigin < body.first.xOrigin) {
                this.xOrigin = body.first.xOrigin + (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
            case DOWNRIGHT: {
              println("case DOWNRIGHT");
              if (this.yOrigin > body.first.yOrigin) {
                this.yOrigin = body.first.yOrigin - (this.height + body.first.height) / 2.0;
              }
              if (this.xOrigin > body.first.xOrigin) {
                this.xOrigin = body.first.xOrigin - (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
            case DOWNLEFT: {
              println("case DOWNLEFT");
              if (this.yOrigin > body.first.yOrigin) {
                this.yOrigin = body.first.yOrigin - (this.height + body.first.height) / 2.0;
              }
              if (this.xOrigin < body.first.xOrigin) {
                this.xOrigin = body.first.xOrigin + (this.width + body.first.width) / 2.0;
              }
              this.xVelocity = 0.0;
              this.xAcceleration = 0.0;
              this.xJerk = 0.0;
              
              this.yVelocity = 0.0;
              this.yAcceleration = 0.0;
              this.yJerk = 0.0;
              
              break;
            }
          }
        }
        
        break;
      }
      
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
