public class Body { //<>// //<>//
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

  public Body transform(Body other, PApplet sketch, int tilesWide, int tilesTall) {
    Body out = new Body(other);

    out.width *= (double) sketch.width / (tilesWide * 8.0);
    out.height *= (double) sketch.height / (tilesTall * 8.0);

    out.xOrigin *= (double) sketch.width / (tilesWide * 8.0);
    out.xVelocity *= (double) sketch.width / (tilesWide * 8.0);
    out.xAcceleration *= (double) sketch.width / (tilesWide * 8.0);
    out.xJerk *= (double) sketch.width / (tilesWide * 8.0);

    out.yOrigin *= (double) sketch.height / (tilesTall * 8.0);
    out.yVelocity *= (double) sketch.height / (tilesTall * 8.0);
    out.yAcceleration *= (double) sketch.height / (tilesTall * 8.0);
    out.yJerk *= (double) sketch.height / (tilesTall * 8.0);

    return out;
  }

  public Body untransform(Body other, PApplet sketch, int tilesWide, int tilesTall) {
    Body out = new Body(other);

    out.width /= (double) sketch.width / (tilesWide * 8.0);
    out.height /= (double) sketch.height / (tilesTall * 8.0);

    out.xOrigin /= (double) sketch.width / (tilesWide * 8.0);
    out.xVelocity /= (double) sketch.width / (tilesWide * 8.0);
    out.xAcceleration /= (double) sketch.width / (tilesWide * 8.0);
    out.xJerk /= (double) sketch.width / (tilesWide * 8.0);

    out.yOrigin /= (double) sketch.height / (tilesTall * 8.0);
    out.yVelocity /= (double) sketch.height / (tilesTall * 8.0);
    out.yAcceleration /= (double) sketch.height / (tilesTall * 8.0);
    out.yJerk /= (double) sketch.height / (tilesTall * 8.0);

    return out;
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
    // Always return false for now

    return false;
  }

  public Direction findCollisionDirection(double deltaT, Body copy, Body body) {
    Direction dir = Direction.UP; // default to moving up;
    /*
        Logic for which direction  the two bodies collided in.
     e.g. Directions.LEFT means (other) `body` collided into the right side of `this`.
     If returned direction is for example UP, we move `this` up
     */

    Body copyB = new Body(body);
    copyB.unmove(deltaT);

    double relX = body.xOrigin - copyB.xOrigin - (this.xOrigin - copy.xOrigin);
    double relY = body.yOrigin - copyB.yOrigin - (this.yOrigin - copy.yOrigin);

    if (relX == 0) {
      return relY > 0 ? Direction.UP : Direction.DOWN;
    }
    if (relY == 0) {
      return relX > 0 ? Direction.RIGHT : Direction.LEFT;
    }

    if (diagonalMoveRequired(copy, body, copyB)) {
      // diagonally move to a corner
      // will never happen for now
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
    } else {
      double slope = relY / relX;

      // todo: figure out which direction to move this for all these cases
      if (relX > 0) {
        if (relY > 0) {
          // body is moving upright (compared to this)
          if (slope * (this.xOrigin - this.width / 2.0 - (body.xOrigin + body.width / 2.0)) + body.yOrigin + body.height / 2.0 < this.yOrigin - this.height / 2.0) {
            // ray of motion goes through bottom edge of this
            dir = Direction.UP;
          } else {
            // ray of motion goes through left edge of this
            dir = Direction.RIGHT;
          }
        } else {
          // body is moving downright (compared to this)
          if (slope * (this.xOrigin - this.width / 2.0 - (body.xOrigin + body.width / 2.0)) + body.yOrigin - body.height / 2.0 > this.yOrigin + this.height / 2.0) {
            // ray of motion goes through top edge of this
            dir = Direction.DOWN;
          } else {
            // ray of motion goes through left edge of this
            dir = Direction.RIGHT;
          }
        }
      } else {
        if (relY > 0) {
          // body is moving upleft (compared to this)
          if (slope * (this.xOrigin + this.width / 2.0 - (body.xOrigin - body.width / 2.0)) + body.yOrigin + body.height / 2.0 < this.yOrigin - this.height / 2.0) {
            // ray of motion goes through bottom edge of this
            dir = Direction.UP;
          } else {
            // ray of motion goes through right edge of this
            dir = Direction.LEFT;
          }
        } else {
          // body if moving downleft (compared to this)
          if (slope * (this.xOrigin + this.width / 2.0 - (body.xOrigin - body.width / 2.0)) + body.yOrigin - body.height / 2.0 > this.yOrigin + this.height / 2.0) {
            // ray of motion goes through top edge of this
            dir = Direction.DOWN;
          } else {
            // ray of motion goes through right edge of this
            dir = Direction.LEFT;
          }
        }
      }
    }

    return dir;
  }

  public ArrayList<Pair<Body, Direction>> checkEntityCollisions(PApplet sketch, ArrayList<Body> bodies, double deltaT, boolean propToScreen) {
    ArrayList<Pair<Body, Direction>> out = new ArrayList<Pair<Body, Direction>>();

    Body copy = new Body(this);
    copy.unmove(deltaT);

    for (Body body : bodies) {
      Direction dir;
      if (propToScreen) {
        Body transformed = this.transform(body, sketch, 40, 22);
        if (this.colliding(transformed)) {
          dir = findCollisionDirection(deltaT, copy, transformed);
          out.add(new Pair<Body, Direction>(body, dir));
        }
      } else {
        if (this.colliding(body)) {
          dir = findCollisionDirection(deltaT, copy, body);
          out.add(new Pair<Body, Direction>(body, dir));
        }
      }
    }

    return out;
  }

  public ArrayList<Pair<Body, Direction>> checkEntityCollisions(PApplet sketch, Screen screen, double deltaT, boolean propToScreen) {
    ArrayList<Pair<Body, Direction>> out = new ArrayList<Pair<Body, Direction>>();

    Body copy = new Body(this);
    copy.unmove(deltaT);

    for (Tile[] row : screen.screen) {
      for (Tile tile : row) {
        if (tile.hasHitbox) {
          Direction dir;
          if (propToScreen) {
            Body transformed = this.transform(tile.hitbox, sketch, screen.width, screen.height);
            if (this.colliding(transformed)) {
              dir = findCollisionDirection(deltaT, copy, transformed);
              out.add(new Pair<Body, Direction>(tile.hitbox, dir));
            }
          } else {
            if (this.colliding(tile.hitbox)) {
              dir = findCollisionDirection(deltaT, copy, tile.hitbox);
              out.add(new Pair<Body, Direction>(tile.hitbox, dir));
            }
          }
        }
      }
    }

    return out;
  }

  public void update(PApplet sketch, double deltaT, int steps, ArrayList<Body> bodies, boolean propToScreen) {
    double timeStep = deltaT / steps;

    while (deltaT > timeStep / 2) {
      this.step(sketch, timeStep, bodies, propToScreen);

      deltaT -= timeStep;
    }
  }

  public void update(PApplet sketch, double deltaT, int steps, Screen screen, boolean propToScreen) {
    double timeStep = deltaT / steps;

    while (deltaT > timeStep / 2) {
      this.step(sketch, timeStep, screen, propToScreen);

      deltaT -= timeStep;
    }
  }

  public void step(PApplet sketch, double timeStep, ArrayList<Body> bodies, boolean propToScreen) {
    this.move(timeStep);
    ArrayList<Pair<Body, Direction>> collided = this.checkEntityCollisions(sketch, bodies, timeStep, propToScreen);

    this.handleCollisions(sketch, collided, new Screen(), propToScreen);
  }

  public void step(PApplet sketch, double timeStep, Screen screen, boolean propToScreen) {
    this.move(timeStep);
    ArrayList<Pair<Body, Direction>> collided = this.checkEntityCollisions(sketch, screen, timeStep, propToScreen);

    this.handleCollisions(sketch, collided, screen, propToScreen);
  } //<>//

  public void handleCollisions(PApplet sketch, ArrayList<Pair<Body, Direction>> collided, Screen screen, boolean propToScreen) {
    if (collided.size() == 0) {
      return;
    }

    for (Pair<Body, Direction> body : collided) {
      Body copy = this.transform(body.first, sketch, screen.width, screen.height);
      if (propToScreen) {
        Body temp = new Body(copy);
        copy = new Body(body.first);
        body.first = new Body(temp);
      }

      switch (body.second) {
      case UP:
        {
          if (this.yOrigin - this.height / 2.0 < body.first.yOrigin + body.first.height / 2.0) {
            this.yOrigin = body.first.yOrigin + (this.height + body.first.height) / 2.0;
          }
          this.yVelocity = 0.0;
          this.yAcceleration = 0.0;
          this.yJerk = 0.0;

          break;
        }
      case DOWN:
        {
          if (this.yOrigin + this.height / 2.0 > body.first.yOrigin - body.first.height / 2.0) {
            this.yOrigin = body.first.yOrigin - (this.height + body.first.height) / 2.0;
          }
          this.yVelocity = 0.0;
          this.yAcceleration = 0.0;
          this.yJerk = 0.0;

          break;
        }
      case LEFT:
        {
          if (this.xOrigin + this.width / 2.0 > body.first.xOrigin - body.first.width / 2.0) {
            this.xOrigin = body.first.xOrigin - (this.width + body.first.width) / 2.0;
          }
          this.xVelocity = 0.0;
          this.xAcceleration = 0.0;
          this.xJerk = 0.0;

          break;
        }
      case RIGHT:
        {
          if (this.xOrigin - this.width / 2.0 < body.first.xOrigin + body.first.width / 2.0) {
            this.xOrigin = body.first.xOrigin + (this.width + body.first.width) / 2.0;
          }
          this.xVelocity = 0.0;
          this.xAcceleration = 0.0;
          this.xJerk = 0.0;

          break;
        }
      default:
        {
          println("what? no cases caught");
          break;
        }
      }

      if (propToScreen) {
        body.first = new Body(copy);
      }
    }
  }

  public void draw(PApplet sketch) {
    sketch.pushStyle();
    sketch.rect((float) this.xOrigin, (float) (sketch.height - this.yOrigin), (float) this.width, (float) this.height);
    sketch.popStyle();
  }

  public void draw(PApplet sketch, int tilesWide, int tilesTall) {
    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);

    sketch.pushStyle();

    sketch.rectMode(PConstants.CENTER);
    sketch.rect((float) (this.xOrigin * pixelW), (float) (sketch.height - this.yOrigin * pixelH), (float) (this.width * pixelW), (float) (this.height * pixelH));

    sketch.popStyle();
  }

  public void drawHitbox(PApplet sketch, int tilesWide, int tilesTall) {
    float pixelW = (float) sketch.width / (8.0 * tilesWide);
    float pixelH = (float) sketch.height / (8.0 * tilesTall);
    float boxWidth = min(pixelW, pixelH);

    sketch.pushStyle();

    sketch.rectMode(PConstants.CENTER);
    sketch.stroke(0, 0, 255);
    sketch.fill(0, 0, 0, 0);
    sketch.strokeWeight(boxWidth);

    sketch.rect((float) this.xOrigin * pixelW, (float) (sketch.height - this.yOrigin * pixelH), (float) this.width * pixelW - boxWidth, (float) this.height * pixelH - boxWidth);

    sketch.popStyle();
  }

  public void drawHitbox(PApplet sketch) {
    float pixelW = max((float) this.width / 25.0, 3.0);
    float pixelH = max((float) this.height / 25.0, 3.0);
    float boxWidth = min(pixelW, pixelH);

    sketch.pushStyle();

    sketch.rectMode(PConstants.CENTER);
    sketch.stroke(0, 0, 255);
    sketch.fill(0, 0, 0, 0);
    sketch.strokeWeight(boxWidth);

    sketch.rect((float) this.xOrigin, (float) (sketch.height - this.yOrigin), (float) this.width - boxWidth, (float) this.height - boxWidth);

    sketch.popStyle();
  }
}
