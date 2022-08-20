/*
Game level one , kill enough enemies ,  get level one , the level one will be finish. and level two will facing different enemies and enemies will have different atks and hp.
 but more exps.
 ********************************
 Different between Assignment3 , 
 i added a push back skill , when the enemies hurt the player , 
 the enemies will turn back to another side to walk away
 ********************************
 
 Also i created another bar called EXP bar
 when player gets enough exp , player level up and win the game.
 
 ALL the fonts are not create by me 
 i used all the fonts from the processing tools
 
 for this work , i used 3 images so far, 
 background image reference: 
 Author name: IforLiving
 publish date: Apr 17,2013 
 download page: https://www.deviantart.com/iforliving/art/Maplestory-Map-Field-366309445
 MapleStoryBackground. (2013, April 17). MapleStoryBackgound. https://www.deviantart.com/iforliving/art/Maplestory-Map-Field-366309445
 
 character image reference:
 i download from the website: https://pnghut.com/png/a7qR6zbEJV/maplestory-playstation-2-super-nintendo-entertainment-system-sega-saturn-mega-drive-playstation-transparent-png
 author name: Drsydvm , size 800x800;
 MapleStory Character Image. (2021, July 19). 
 MapleStoryCharacter. https://pnghut.com/png/a7qR6zbEJV/maplestory-playstation-2-super-nintendo-entertainment-system-sega-saturn-mega-drive-playstation-transparent-png
 
 
 
 
 
 
 July 26 th
 milestone2.
 added jump ,(just need to press up case)
 added melee attack( press c) but havent done the hit dete part
 added level2 
 added background muisc
 reference: 
 download from: https://downloads.khinsider.com/game-soundtracks/album/maplestory/217%2520-%2520music%252034.mp3
 Album name: MapleStory
 Song name: music 34
 download date: july 26 
 
 *****there are some error about monster pushback function , i comment it out , cause once the monster hit the character , monster will fly away(i dont know how..)
 
 
 monster image1 and 2 reference: 
 MapleStoryEnemy Karu. (2021, July 19). [PNG]. https://strategywiki.org/wiki/File:MS_Monster_Kru.png
 download page: https://strategywiki.org/wiki/File:MS_Monster_Kru.png
 
 Music Pack (used from the procesing libary tools
 not yet.
 
 *****about game level two , i have no idea why the monster are super fast , just keep fire it , when the exp >=10, the game will be win
 
 i will addup rest of other works in the mileStone3!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
 */
/*
Aug 2nd
 Mile3
 added player hp recovery skill "press F" only 5 times , will add increase chance hit box in the next week
 speed up the pojectile shotting speed
 added lvl3 , with new monster image and increased HP and atk
 added final boss , but there are little bit problem so i comment it out.
 added few new images , all the new image reference are the same with last two weeks.
 going to move all global methods into methods class to makes program cleaner.
 going to move all sounds into sounds class.
 player can jump a bit higher 
 
 about the sound reference 
 MapleStory, music 34. (n.d.). MapleStorySounds. VideoGameMusic. https://downloads.khinsider.com/game-soundtracks/album/maplestory/217%2520-%2520music%252034.mp3. 
 
 player will get 3 new skills and some npc to talk about the game in the next week!
 
 i got fever this week , so sorry i didnt do a lot work ...
 
 
 */
GameMap map;
Player player;
Portal portal;

boolean mapChange=false;
boolean mapTwoChange=false;
boolean mapThreeChange=false;
int numberOfMonsterOne=5;
int numberOfMonsterTwo=5;
int numberOfMonsterThree=5;
int NumOfBoss=1;
int Exp=0;
int level=0;
PImage mapOne;
PImage mapFour;

int introTime=120;
int levelTwoTime=120;
int lvlThreeTime=60;
int curLevel=1;
final String intro="BEGIN LEVEL ONE!";
final String introHowToPlay="Space for shot,F for HP recovery!";
final String levelTwo="BEGIN LEVEL TWO";
final String levelThree="BEGIN LEVEL THREE";

int state; //current state of game
final int LEVEL_ONE=0;  //game play and game 1 
final int LEVEL_TWO=1;  //game play and game2
final int LEVEL_THREE=2;  //for mile3
final int Boss=3;  //for mile3 + boss room
final int WON=4;  //win
final int LOSE=5; //lose 
boolean isLevelOneCleared =false;
boolean isLevelTwoCleared =false;
boolean isLevelThreeCleared =false;
boolean gamebegin=false;

ArrayList<Monster> monsters;  //3 arraylists about monster,hud and platform
ArrayList<HUDLevelUp> hudlevelups;
ArrayList<Platform> platforms;

void setup() {
  size(1400, 800);
  imageMode(CENTER);
  PFont font=loadFont("OldEnglishTextMT-48.vlw");  //this is not create by me , i download from the processing library
  textFont(font);
  textSize(30);
  loadSounds();
  loadImages();
  loadButton();
  
  // Neccessary setups for game
  introTime=120;
  levelTwoTime=120;
  lvlThreeTime=60;
  map=new GameMap();
  state=LEVEL_ONE;
  curLevel=1;
  level=0;
  Exp=0;
  
  mapChange=false;
  mapTwoChange=false;
  mapThreeChange=false;
  isLevelOneCleared=false;
  isLevelTwoCleared=false;
  isLevelThreeCleared=false;

  platforms=new ArrayList<Platform>();
  platforms.add(new Platform(new PVector(400, 550)));
  platforms.add(new Platform(new PVector(650, 400)));
  player=new Player(new PVector(0, 760), new PVector(5, 5), 10);
  portal=new Portal(new PVector(1200, 670));
  hudlevelups=new ArrayList<HUDLevelUp>();
  monsters= new ArrayList<Monster>();
  
  for (int i=0; i<numberOfMonsterOne; i++) {
    monsters.add(new Monster(new PVector(random(width/2, 1200), 680), new PVector(-3, 0), 3, monsterMapOne[0], 2));
  }
  monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(0)));
  monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(1)));
}

void draw() {
  if(!gamebegin){
    image(introImg, width/2, height/2);
    return;
  }
  map.display();
  //println(player.exp);
  fill(0, 100);
  rect(1090, 20, 290, 180, 10);
  fill(255);
  //text("State: "+state,1150,50);
  textAlign(LEFT);
  textSize(30);
  text("Hp: "+int(player.health)+"/"+player.maxHp, 1100, 55);
  text("Exp: "+player.exp+"/"+player.maxExp, 1100, 100);
  text("Attack: "+player.damage, 1100, 145);
  text("Level-"+curLevel, 1100, 190);
  textAlign(CENTER);
  switch(state) {

  case LEVEL_ONE:
    curLevel=1;
    if (introTime>0) {
      introTime--;
      showScreen(intro);
      //showScreenTwo(introHowToPlay);
    }
    if (introTime==0) {   
      gamePlay();
    }


    break;

  case LEVEL_TWO:
    curLevel=2;
    if (levelTwoTime>0) {
      levelTwoTime--;
      showScreen(levelTwo);
    }
    if (levelTwoTime==0) {
      gamePlayTwo();
    }
    break;

  case LEVEL_THREE:
    curLevel=3;
    if (lvlThreeTime>0) {
      lvlThreeTime--;
      showScreen(levelThree);
    }
    if (lvlThreeTime==0) {
      gamePlayThree();
    }
    break;

  case Boss:
    // Change bgm to boss level
    if (!bossbgm.isPlaying()) bossbgm.loop(0);
    if (bgm.isPlaying()) bgm.pause();
    curLevel=4;
    gamePlayBoss();
    break;


  case WON:
    bossbgm.pause();
    bgm.pause();
    replay.show();
    textScreen("YOU WON", width/2, height/2);  
    break;

  case LOSE:  //HP LESS THAN 0 
    bossbgm.pause();
    bgm.pause();
    replay.show();
    textScreen("YOU LOST", width/2, height/2);
    break;
  }

  if (up&& !player.jumping) {
    //player.accelerate(upAcc);
    player.jump(upAcc);
  }
  if (down) player.accelerate(downAcc);
  if (left) player.accelerate(leftAcc);
  if (right) player.accelerate(rightAcc);

  for (int i=0; i<hudlevelups.size(); i++) {
    HUDLevelUp hudlevelup=hudlevelups.get(i);
    hudlevelup.drawMe();
    if (!hudlevelup.isAlive)
      hudlevelups.remove(i);
  }
}
void gamePlay() {
  for (int i=0; i<platforms.size(); i++){
    Platform platform=platforms.get(i);
    platform.drawMe();
  }
  portal.drawMe();
  player.update();
  player.drawHealthBar();
  player.drawExpBar();
  for (int i=0; i<monsters.size(); i++) {
    monsters.get(i).update();
  }
  // Respawn every 3 seconds
  if (monsters.size() < numberOfMonsterTwo + 2 && frameCount % 180 == 0)
    spawnMon();
  
  if (portal.coolDown <= 0){
    level += 1;
    checkLevel();
  }
  
}

void gamePlayTwo() {
  for (int i=0; i<platforms.size(); i++){
    Platform platform=platforms.get(i);
    platform.drawMe();
  }
  portal.drawMe();
  if (!isLevelOneCleared) {
    clearLevelOne();
    isLevelOneCleared=true;
  }
  player.update();
  player.drawHealthBar();
  player.drawExpBar();
  for (int i=0; i<monsters.size(); i++) {
    monsters.get(i).update();
  }
  
  // Respawn every 3 seconds
  if (monsters.size() < numberOfMonsterTwo + 3 && frameCount % 180 == 0)
    spawnMon();
  
  if (portal.coolDown <= 0){
    level += 1;
    checkLevel();
  }
  
}

void gamePlayThree() {
  for (int i=0; i<platforms.size(); i++){
    Platform platform=platforms.get(i);
    platform.drawMe();
  }
  portal.drawMe();
  if (!isLevelTwoCleared) {
    clearLevelTwo();
    isLevelTwoCleared=true;
  }  
  player.update();
  player.drawHealthBar();
  player.drawExpBar();
  for (int i=0; i<monsters.size(); i++) {
    monsters.get(i).update();
  }
  if (portal.coolDown <= 0){
    level += 1;
    checkLevel();
  }
  
  // Respawn every 3 seconds
  if (monsters.size() < numberOfMonsterTwo + 2 && frameCount % 180 == 0)
    spawnMon();
  
  
}


void gamePlayBoss() {
  portal.activated=false;
  if (!isLevelThreeCleared) {
    clearLevelThree();
    isLevelThreeCleared=true;
  }  
  player.update();
  player.drawHealthBar();
  player.drawExpBar();
  for (int i=0; i<monsters.size(); i++) {
    monsters.get(i).update();
  }
  if (monsters.size() <= 0){
    level += 1;
    checkLevel();
  }
  for (int i=0; i<platforms.size(); i++){
    Platform platform=platforms.get(i);
    platform.drawMe();
  }
}


void clearLevelOne() {
  monsters.clear();
  player.pos=new PVector(0, 760);
  for (int i=0; i<numberOfMonsterTwo; i++) {
    spawnMon();
  }
  monsters.add(new MonsterOnPlatform(4, monsterMapTwo[0], 10, platforms.get(0)));
  monsters.add(new MonsterOnPlatform(4, monsterMapTwo[0], 10, platforms.get(1)));
  monsters.add(new MonsterOnPlatform(4, monsterMapTwo[0], 10, platforms.get(2)));
  // respawn every 3 seconds
}

void clearLevelTwo() {
  monsters.clear();
  player.pos=new PVector(0, 760);
  for (int i=0; i<numberOfMonsterThree; i++) {
    spawnMon();
  }
  monsters.add(new MonsterOnPlatform(5, monsterMapThree, 15, platforms.get(0)));
  monsters.add(new MonsterOnPlatform(5, monsterMapThree, 15, platforms.get(1)));
}

void clearLevelThree() {
  monsters.clear();
  player.pos=new PVector(0, 760);
  for (int i=0; i<NumOfBoss; i++) {
    spawnBoss();
  }
}
void spawnMon() {
  switch(level) {
  case 0:
    // Mosters have 3 health in level 1
    monsters.add(new Monster(new PVector(random(300, 1200), 680), new PVector(-3, 0), 3, monsterMapTwo[0], 1));
    break;
  case 1:
    // Mosters have 4 health in level 2
    monsters.add(new Monster(new PVector(random(300, 1200), 680), new PVector(-3, 0), 10, monsterMapTwo[0], 2));
    
    break;
  case 2:
    // Mosters have 5 health in level 3
    monsters.add(new Monster(new PVector(random(300, 1200), 680), new PVector(-3, 0),15, monsterMapTwo[0], 3));
    
    break;
  case 3:
    break;
  }
}  

void spawnBoss() {
  for (int i=0; i<NumOfBoss; i++) {
    monsters.add(new Boss(new PVector(random(width/2, 1200), 680), new PVector(-5, 0), 50, finalBoss[0]));
  }
}

void checkLevel(){
  if(level==1){
      state=LEVEL_TWO;
      if(mapChange==false){
        map.switchLevel();
        mapChange=true;
      }
    }
    if(level==2){
      state=LEVEL_THREE;
      if(mapTwoChange==false){
        map.switchLevel();
        mapTwoChange=true;
      }
    } 
    
    if(level ==3){
      state=Boss;
      if(mapThreeChange==false){
        map.switchLevel();
        mapThreeChange=true;
      }
    }
    if(level ==4){
      state=WON;
    }
    
}

void textScreen(String words, int a, int b) {
  background(255);
  PFont font=loadFont("Rockwell-ExtraBold-48.vlw");
  fill(0, 255, 255);
  textFont(font, 60);
  textSize(40);
  textAlign(CENTER);
  text(words, a, b);
}

void restartGame(){
  // Neccessary setups for game
  bossbgm.pause();
  bgm.pause();
  bgm.loop();
  introTime=120;
  levelTwoTime=120;
  lvlThreeTime=60;
  map=new GameMap();
  state=LEVEL_ONE;
  curLevel=1;
  level=0;
  Exp=0;
  
  mapChange=false;
  mapTwoChange=false;
  mapThreeChange=false;
  isLevelOneCleared=false;
  isLevelTwoCleared=false;
  isLevelThreeCleared=false;

  player=new Player(new PVector(0, 760), new PVector(5, 5), 10);
  portal=new Portal(new PVector(1200, 670));
  hudlevelups=new ArrayList<HUDLevelUp>();
  monsters= new ArrayList<Monster>();
  platforms.clear();
  platforms.add(new Platform(new PVector(400, 550)));
  platforms.add(new Platform(new PVector(650, 400)));
  
  for (int i=0; i<numberOfMonsterOne; i++) {
    monsters.add(new Monster(new PVector(random(width/2, 1200), 680), new PVector(-3, 0), 3, monsterMapOne[0], 2));
  }
  monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(0)));
  monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(1)));
}
