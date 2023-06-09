import java.util.Arrays;

Screen screen;
Background back;

Actor player;

HashMap<Integer, Pair<Boolean, Boolean>> inputs;

String newName;

/*
int tileInd;
 int tileSwitchInd;
 
 int spriteInd;
 int spriteSwitchInd;
 
 boolean tiling;
 boolean hitboxes;
 
 ArrayList<Tile> tilePalette;
 ArrayList<Sprite> spritePalette;
 
 boolean hasHitbox;
 boolean canInteract;
 */

void setup() {
  //try { refreshBinaries(); exit(); return; } catch (Exception e) { e.printStackTrace(); println("refresh error ^^"); }

  frameRate(30);
  size(960, 528);

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

  screen = new Screen("world1", "final");
  //newName = "final";

  back = new Background(absoluteRepoPath() + "resources/images/starryBackground.png");

  /*
  tileInd = 0;
   tileSwitchInd = 0;
   
   spriteInd = 0;
   spriteSwitchInd = 0;
   
   tiling = true;
   hitboxes = true;
   
   tilePalette = new ArrayList<Tile>();
   spritePalette = new ArrayList<Sprite>();
   
   for (File file : new File(absoluteRepoPath() + "resources/textures/tiles/").listFiles()) {
   if (file.getName().charAt(0) == '.') {
   continue;
   }
   
   try {
   String name = removeExtension(file.getName());
   tilePalette.add(new Tile(name, absoluteRepoPath() + "resources/textures/bin/" + name + ".bin", false, false, 0, 0));
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
   spritePalette.add(new Sprite(name, absoluteRepoPath() + "resources/textures/bin/" + name + ".bin", false, false, 0, 0));
   }
   catch (Exception e) {
   e.printStackTrace();
   }
   }
   
   hasHitbox = true;
   canInteract = false;
   */

  player = new Actor(8, 10, 24, 93, absoluteRepoPath() + "resources/textures/bin/player.bin", 0.0, 0.0);
  //b2 = new Actor(8, 10, 25, 25);
}

void draw() {
  back.draw(this);

  screen.draw(this);
  //screen.drawHitboxes(this);
  player.draw(this, screen.width, screen.height);
  /*
  if (hitboxes) {
   editing.drawHitboxes(this);
   }
   
   if (!tiling) {
   Sprite toDraw = spritePalette.get(spriteInd);
   
   toDraw.xPosition = (int) (mouseX / (width / (8.0 * editing.width))) - toDraw.texture.xOrigin;
   toDraw.yPosition = (int) (mouseY / (height / (8.0 * editing.height))) - toDraw.texture.yOrigin;
   
   toDraw.draw(this, editing.width, editing.height);
   }
   */
   
  /*
  for (Map.Entry<Integer, Pair<Boolean, Boolean>> entry : inputs.entrySet()) {
    println(entry.getKey() + ": " + entry.getValue());
  }
  */

  println(frameRate);

  /*
  if (mousePressed) {
   // fix this. scale by what to make one-to-one?
   
   if (mouseButton == RIGHT) {
   b1.xOrigin = mouseX / 4;
   b1.yOrigin = (height - mouseY) / 5;
   }
   }
   */

  //b1.update(this, 1.0 / frameRate, 15, editing, false);
  player.act(this, screen, 1.0 / frameRate, inputs);
}

void keyPressed() {
  switch (keyCode) {
  case UP:
    {
      inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.UP.label).first));
      
      break;
    }
  case DOWN:
    {
      inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.DOWN.label).first));
      
      break;
    }
  case LEFT:
    {
      inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.LEFT.label).first));
      
      break;
    }
  case RIGHT:
    {
      inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(true, inputs.get((int) Direction.RIGHT.label).first));
      
      break;
    }
  case ENTER:
    {
      try { screen.writeScreen(absoluteRepoPath() + "resources/worlds/world1/screens/" + "final2" + ".txt", "final2"); exit(); return; } catch (Exception e) {}
    }
  }

  switch (key) {
  case 'z':
    {
      inputs.put((int) 'z', new Pair<Boolean, Boolean>(true, inputs.get((int) 'z').first));
      
      break;
    }
  case 'x':
    {
      inputs.put((int) 'x', new Pair<Boolean, Boolean>(true, inputs.get((int) 'x').first));
      
      break;
    }
  case 'c':
    {
      inputs.put((int) 'c', new Pair<Boolean, Boolean>(true, inputs.get((int) 'c').first));
      
      break;
    }

    /*
    // ------------------
     case 'w':
     {
     player.yVelocity = 50;
     
     break;
     }
     case 'a':
     {
     player.xVelocity = -50;
     
     break;
     }
     case 's':
     {
     player.yVelocity = -50;
     
     break;
     }
     case 'd':
     {
     player.xVelocity = 50;
     
     break;
     }
     */
  }
}

void keyReleased() {
  switch (keyCode) {
  case UP:
    {
      inputs.put((int) Direction.UP.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.UP.label).first));
      
      break;
    }
  case DOWN:
    {
      inputs.put((int) Direction.DOWN.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.DOWN.label).first));
      
      break;
    }
  case LEFT:
    {
      inputs.put((int) Direction.LEFT.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.LEFT.label).first));
      
      break;
    }
  case RIGHT:
    {
      inputs.put((int) Direction.RIGHT.label, new Pair<Boolean, Boolean>(false, inputs.get((int) Direction.RIGHT.label).first));
      
      break;
    }
  }

  switch (key) {
  case 'z':
    {
      inputs.put((int) 'z', new Pair<Boolean, Boolean>(false, inputs.get((int) 'z').first));
      
      break;
    }
  case 'x':
    {
      inputs.put((int) 'x', new Pair<Boolean, Boolean>(false, inputs.get((int) 'x').first));
      
      break;
    }
  case 'c':
    {
      inputs.put((int) 'c', new Pair<Boolean, Boolean>(false, inputs.get((int) 'c').first));
      
      break;
    }

    /*
    // ------------------
     case 'w':
     {
     player.yVelocity = 0;
     
     break;
     }
     case 'a':
     {
     player.xVelocity = 0;
     
     break;
     }
     case 's':
     {
     player.yVelocity = 0;
     
     break;
     }
     case 'd':
     {
     player.xVelocity = 0;
     
     break;
     }
     default:
     {
     player.xVelocity = 0;
     player.yVelocity = 0;
     }
     */
  }
}

/*
// for creating new screens
 void mouseReleased() {
 if (tiling) {
 int x = mouseX / (width / editing.width);
 int y = editing.height - mouseY / (height / editing.height);
 
 Tile tile = new Tile(tilePalette.get(tileInd));
 
 tile.hitbox = new Body(8, 8, x * 8 + 4.0, (y - 1) * 8 + 4.0);
 tile.xPosition = x * 8;
 tile.yPosition = (y - 1) * 8;
 
 tile.hasHitbox = hasHitbox;
 tile.canInteract = canInteract;
 
 editing.screen[editing.height - y][x] = tile;
 } else {
 int x = (int) (mouseX / (width / (8.0 * editing.width)));
 int y = (int) (mouseY / (height / (8.0 * editing.height)));
 
 Sprite sprite = new Sprite(spritePalette.get(spriteInd));
 
 sprite.hitbox = new Body(sprite.texture.width, sprite.texture.height, x, editing.height * 8 - y);
 sprite.xPosition = x - sprite.texture.xOrigin;
 sprite.yPosition = y - sprite.texture.yOrigin;
 
 sprite.hasHitbox = hasHitbox;
 sprite.canInteract = canInteract;
 
 editing.sprites.add(sprite);
 }
 }
 
 void keyReleased() {
 switch (keyCode) {
 case ENTER:
 {
 try {
 editing.writeScreen(absoluteRepoPath() + "resources/worlds/world1/screens/" + newName + ".txt", newName);
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
 if (tiling) {
 int temp = tileInd;
 tileInd = tileSwitchInd;
 tileSwitchInd = temp;
 } else {
 int temp = spriteInd;
 spriteInd = spriteSwitchInd;
 spriteSwitchInd = temp;
 }
 }
 case 's':
 {
 tiling = !tiling;
 if (tiling) {
 println("now tiling");
 } else {
 println("now spriting");
 }
 }
 case 'd':
 {
 hitboxes = !hitboxes;
 }
 }
 }
 
 void mouseWheel(MouseEvent event) {
 if (tiling) {
 if (event.getCount() > 0) {
 tileInd = (tileInd + 1) % tilePalette.size();
 } else if (event.getCount() < 0) {
 tileInd = (tileInd - 1) % tilePalette.size();
 
 if (tileInd < 0) {
 tileInd += tilePalette.size();
 }
 }
 
 println("tileInd=" + tileInd + ", tilename=" + tilePalette.get(tileInd).name);
 } else {
 if (event.getCount() > 0) {
 spriteInd = (spriteInd + 1) % spritePalette.size();
 } else if (event.getCount() < 0) {
 spriteInd = (spriteInd - 1) % spritePalette.size();
 
 if (spriteInd < 0) {
 spriteInd += spritePalette.size();
 }
 }
 
 println("spriteInd=" + spriteInd + ", spritename=" + spritePalette.get(spriteInd).name);
 }
 }
 */
