import java.util.Arrays;

Screen editing;
Background back;

Actor b1;
//Actor b2;

HashMap<Integer, Pair<Boolean, Boolean>> inputs;

String newName;

int tileInd;
int switchInd;
ArrayList<Tile> palette;

boolean hasHitbox;
boolean canInteract;

void setup() {
  //try { refreshBinaries(); exit(); return; } catch (Exception e) { e.printStackTrace(); println("refresh error ^^"); }

  frameRate(30);
  size(960, 528);

  rectMode(CENTER);

  /*
  // refactor into world probably
   inputs = new HashMap<Integer, Pair<Boolean, Boolean>>();
   
   inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(false, false));
   inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(false, false));
   inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(false, false));
   inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(false, false));
   
   inputs.put((int) 'z', new Pair<Boolean, Boolean>(false, false));
   inputs.put((int) 'x', new Pair<Boolean, Boolean>(false, false));
   inputs.put((int) 'c', new Pair<Boolean, Boolean>(false, false));
   */

  editing = new Screen("world1", "test");
  newName = "test2";

  back = new Background(absoluteRepoPath() + "resources/images/starryBackground.png");

  tileInd = 0;
  switchInd = 0;
  palette = new ArrayList<Tile>();

  for (File file : new File(absoluteRepoPath() + "resources/textures/tiles/").listFiles()) {
    if (file.getName().charAt(0) == '.') {
      continue;
    }
    
    try {
      String name = removeExtension(file.getName());
      palette.add(new Tile(name, absoluteRepoPath() + "resources/textures/bin/" + name + ".bin", false, false, 0, 0));
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  for (File file : new File(absoluteRepoPath() + "resources/textures/sprites/").listFiles()) {
    if (file.getName().charAt(0) == '.') {
      continue;
    }
    
    try {
      String name = removeExtension(file.getName());
      palette.add(new Tile(name, absoluteRepoPath() + "resources/textures/bin/" + name + ".bin", false, false, 0, 0));
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  hasHitbox = true;
  canInteract = false;

  b1 = new Actor(8, 10, 40, 80, absoluteRepoPath() + "resources/textures/bin/player.bin", 0.0, 0.0);
  //b2 = new Actor(8, 10, 25, 25);
}

void draw() {
  back.draw(this);

  editing.draw(this);
  //editing.drawHitboxes(this);

  /*
  for (Map.Entry<Integer, Pair<Boolean, Boolean>> entry : inputs.entrySet()) {
   println(entry.getKey() + ": " + entry.getValue());
   }
   */

  //println(frameRate);
  b1.draw(this, editing.width, editing.height);
  //b2.draw(this, spawn.width, spawn.height);

  //b1.drawHitbox(this, spawn.width, spawn.height);


  if (mousePressed) {
    // fix this. scale by what to make one-to-one?

    if (mouseButton == RIGHT) {
      b1.xOrigin = mouseX / 4;
      b1.yOrigin = (height - mouseY) / 5;
    }
  }

  b1.update(this, 1.0 / frameRate, 15, editing, false);
}

/*
void keyPressed() {
 switch (keyCode) {
 case UP:
 {
 inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.UP.label).first));
 }
 case DOWN:
 {
 inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.DOWN.label).first));
 }
 case LEFT:
 {
 inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.LEFT.label).first));
 }
 case RIGHT:
 {
 inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.RIGHT.label).first));
 }
 }
 
 switch (key) {
 case 'z':
 {
 inputs.put((int) 'z', new Pair<Boolean, Boolean>(true, inputs.get((int) 'z').first));
 }
 case 'x':
 {
 inputs.put((int) 'x', new Pair<Boolean, Boolean>(true, inputs.get((int) 'x').first));
 }
 case 'c':
 {
 inputs.put((int) 'c', new Pair<Boolean, Boolean>(true, inputs.get((int) 'c').first));
 }
 
 // ------------------
 case 'w':
 {
 b1.yVelocity = 50;
 
 break;
 }
 case 'a':
 {
 b1.xVelocity = -50;
 
 break;
 }
 case 's':
 {
 b1.yVelocity = -50;
 
 break;
 }
 case 'd':
 {
 b1.xVelocity = 50;
 
 break;
 }
 }
 }
 
 void keyReleased() {
 switch (keyCode) {
 case UP:
 {
 inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.UP.label).first));
 }
 case DOWN:
 {
 inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.DOWN.label).first));
 }
 case LEFT:
 {
 inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.LEFT.label).first));
 }
 case RIGHT:
 {
 inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.RIGHT.label).first));
 }
 }
 
 switch (key) {
 case 'z':
 {
 inputs.put((int) 'z', new Pair<Boolean, Boolean>(false, inputs.get((int) 'z').first));
 }
 case 'x':
 {
 inputs.put((int) 'x', new Pair<Boolean, Boolean>(false, inputs.get((int) 'x').first));
 }
 case 'c':
 {
 inputs.put((int) 'c', new Pair<Boolean, Boolean>(false, inputs.get((int) 'c').first));
 }
 
 // ------------------
 case 'w':
 {
 b1.yVelocity = 0;
 
 break;
 }
 case 'a':
 {
 b1.xVelocity = 0;
 
 break;
 }
 case 's':
 {
 b1.yVelocity = 0;
 
 break;
 }
 case 'd':
 {
 b1.xVelocity = 0;
 
 break;
 }
 default:
 {
 b1.xVelocity = 0;
 b1.yVelocity = 0;
 }
 }
 }
 */

// for creating new screens
void mouseReleased() {
  int x = mouseX / (width / editing.width);
  int y = editing.height - mouseY / (height / editing.height);

  Tile tile = new Tile(palette.get(tileInd));

  tile.hitbox = new Body(8, 8, x * 8 + 4.0, (y - 1) * 8 + 4.0);
  tile.xPosition = x * 8;
  tile.yPosition = (y - 1) * 8;

  tile.hasHitbox = hasHitbox;
  tile.canInteract = canInteract;

  editing.screen[editing.height - y][x] = tile;
}

void keyReleased() {
  switch (keyCode) {
  case ENTER:
    {
      try {
        editing.writeScreen(absoluteRepoPath() + "resources/worlds/screens/" + newName + ".txt", newName);
        exit();
      }
      catch (Exception e) {
        e.printStackTrace();
        return;
      }
    }
  }

  switch (key) {
  case 'h':
    {
      hasHitbox = !hasHitbox;
      println("hasHitbox=" + hasHitbox);
      break;
    }
  case 'i':
    {
      canInteract = !canInteract;
      println("canInteract=" + canInteract);
      break;
    }
  case 'e':
    {
      int temp = tileInd;
      tileInd = switchInd;
      switchInd = temp;
    }
  case 's':
    {
      editing.numSpawns += 1;
      Location[] added = new Location[editing.numSpawns];

      for (int i = 0; i < editing.numSpawns - 1; i++) {
        added[i] = editing.spawns[i];
      }
      added[editing.numSpawns - 1] = new Location(mouseX * editing.width / width, editing.height - mouseY * editing.height / height);

      editing.spawns = added;
      break;
    }
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() > 0) {
    tileInd = (tileInd + 1) % palette.size();
  } else if (event.getCount() < 0) {
    tileInd = (tileInd - 1) % palette.size();

    if (tileInd < 0) {
      tileInd += palette.size();
    }
  }

  println("tileInd=" + tileInd + ", tilename=" + palette.get(tileInd).name);
}
