class GameMap {
  PImage map;
  int mapWidth;
  int mapHeight;

  GameMap() {
    map=loadImage("MapOne.png");
    mapWidth = map.width*2;
    mapHeight = map.height*2;   
    map.resize(mapWidth,mapHeight); 
  }

  void display() {
    //display the image
    image(map, width/2, height/2);
  }
  
  void switchLevel(){
    if(state==LEVEL_ONE){
      map=loadImage("MapOne.png");
      platforms.clear();
      platforms.add(new Platform(new PVector(400, 550)));
      platforms.add(new Platform(new PVector(650, 400)));
      monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(0)));
      monsters.add(new MonsterOnPlatform(3, monsterMapOne[0], 2, platforms.get(1)));
    }
    if(state==LEVEL_TWO){
      map=loadImage("MapTwo.png");
      mapWidth = map.width*2;
      mapHeight = map.height*2;   
      map.resize(mapWidth,mapHeight); 
      platforms.clear();
      portal.pos=new PVector(800, 320);
      platforms.add(new Platform(new PVector(250, 550)));
      platforms.add(new Platform(new PVector(650, 550)));
      platforms.add(new Platform(new PVector(750, 400)));
    }
    if(state == LEVEL_THREE){
      map=loadImage("MapThree.png");
      mapWidth = map.width*2;
      mapHeight = map.height*2;   
      map.resize(mapWidth,mapHeight); 
      platforms.clear();
      portal.pos=new PVector(850, 320);
      platforms.add(new Platform(new PVector(400, 550)));
      platforms.add(new Platform(new PVector(800, 400)));
      
    }
    if(state == Boss){
      map=loadImage("BossRoom.png");
      mapWidth = map.width*2;
      mapHeight = map.height*2;   
      map.resize(mapWidth,mapHeight); 
      platforms.clear();
      platforms.add(new Platform(new PVector(200, 550)));
      platforms.add(new Platform(new PVector(700, 550)));
      platforms.add(new Platform(new PVector(1200, 550)));
      
    }   
  }
}
