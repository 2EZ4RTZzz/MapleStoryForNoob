//this is the game images class included all the images that i used in the game
PImage playerImg;
PImage mapTwo;
PImage monsterMapThree;
PImage introImg;
PImage platformImg;
PVector platformDim = new PVector(300, 40);

PImage[] playerWalk = new PImage[4];
PImage[] monsterMapOne = new PImage[2];
PImage[] monsterMapTwo = new PImage[2];
PImage[] finalBoss = new PImage[2];
PImage[] attackImg = new PImage[15];

void loadImages(){
  playerImg= loadImage("RealPlayer.png");  
  monsterMapThree= loadImage("MonsterMapThree.png");
  introImg=loadImage("intro.png");
  platformImg=loadImage("platform.png");
  platformImg.resize(int(platformDim.x), int(platformDim.y));
  loadFrames(playerWalk, "walk/walk_");
  loadFrames(monsterMapOne, "MonsterMapOne", 192, 156);
  loadFrames(monsterMapTwo, "MonsterMapTwo", 192, 156);
  loadFrames(finalBoss, "Boss_", 226,141);
  loadFrames(attackImg, "rangeatk/range_");
}

void loadFrames(PImage[] arr, String path){
  for (int i=0; i<arr.length; i++){
    PImage frame = loadImage(path+i+".png");
    arr[i] = frame;
  }
}

void loadFrames(PImage[] arr, String path, int dimx, int dimy){
  for (int i=0; i<arr.length; i++){
    PImage frame = loadImage(path+i+".png");
    frame.resize(dimx, dimy);
    arr[i] = frame;
  }
}
