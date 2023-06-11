import java.util.Arrays;

Screen editing;
Background back;

//Actor b1;
//Actor b2;

HashMap<Integer, Pair<Boolean, Boolean>> inputs;

String newName;

int tileInd;
int switchInd;
ArrayList<Tile> palette;

boolean hasHitbox;
boolean canInteract;

void setup() {
  //try { refreshBinaries(); } catch (Exception e) { e.printStackTrace(); println("refresh error ^^"); } exit(); return;
  
  frameRate(30);
  size(1920, 1056);

  rectMode(CENTER);
  
  // refactor into world probably
  inputs = new HashMap<Integer, Pair<Boolean, Boolean>>();
  
  inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(false, false));
  inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(false, false));
  inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(false, false));
  inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(false, false));
  
  inputs.put((int) 'z', new Pair<Boolean, Boolean>(false, false));
  inputs.put((int) 'x', new Pair<Boolean, Boolean>(false, false));
  inputs.put((int) 'c', new Pair<Boolean, Boolean>(false, false));


  editing = new Screen("world1", "test");
  newName = "test2";
  
  back = new Background(absoluteRepoPath() + "resources/images/starryBackground.png");

  tileInd = 0;
  switchInd = 0;
  palette = new ArrayList<Tile>();

  for (File file : new File(absoluteRepoPath() + "resources/textures/tiles/").listFiles()) {
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

  //b1 = new Actor(8, 10, 25, 40, absoluteRepoPath() + "resources/textures/bin/player.bin", -2.5, 0.0);
  //b2 = new Actor(8, 10, 25, 25);
}

void draw() {
  back.draw(this);
  
  editing.draw(this);
  editing.drawHitboxes(this);
  
  /*
  for (Map.Entry<Integer, Pair<Boolean, Boolean>> entry : inputs.entrySet()) {
    println(entry.getKey() + ": " + entry.getValue());
  }
  */

  //println(frameRate);
  //b1.draw(this, spawn.width, spawn.height);
  //b2.draw(this, spawn.width, spawn.height);

  //b1.drawHitbox(this, spawn.width, spawn.height);

  /*
  if (mousePressed) {
   // fix this. scale by what to make one-to-one?
   
   if (mouseButton == LEFT) {
   b1.xOrigin = mouseX / 4;
   b1.yOrigin = (height - mouseY) / 5;
   } else if (mouseButton == RIGHT) {
   b2.xOrigin = mouseX / 4;
   b2.yOrigin = (height - mouseY) / 5;
   }
   }
   
   b1.update(this, 1.0 / frameRate, 15, new ArrayList<Body>(Arrays.asList(new Body[] { b2 })), false);
   b2.blindUpdate(1.0 / frameRate);
   
   b1.update(this, 1.0 / frameRate, 15, spawn, false);
   */
}

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
  }
}

/* for creating new screens
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
 */
