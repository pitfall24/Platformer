Screen spawn;

Body b1;
Body b2;

ArrayList<Pair<Integer, Integer>> tiles;

void setup() {
  size(960, 528);
  
  rectMode(CENTER);
  
  spawn = new Screen("spawn");
  
  b1 = new Body(80, 100, 90, 120);
  b2 = new Body(8, 10, 50, 150);
  
  b1.yAcceleration = -9.81;
  b1.yJerk = -1;
  
  tiles = new ArrayList<>();
  tiles.add(new Pair<>(39, 0));
  tiles.add(new Pair<>(5, 5));
  tiles.add(new Pair<>(0, 21));
}

void draw() {
  background(255, 255, 255);
  
  spawn.draw(this);
  spawn.drawHitboxes(this, tiles);
  
  b1.draw(this);
  b2.draw(this);
  
  if (mousePressed) {
    if (mouseButton == LEFT) {
      b1.xOrigin = mouseX;
      b1.yOrigin = height - mouseY;
    } else if (mouseButton == RIGHT) {
      b2.xOrigin = mouseX;
      b2.yOrigin = height - mouseY;
    }
  }
  
  b1.move(1.0 / 60.0);
}
