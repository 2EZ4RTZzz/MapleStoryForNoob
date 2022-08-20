// This is the class for monsters

class Monster extends Character{
  int defTime=0;
  int switchTimer=0;
  int damage=1;
  boolean isAlive;
  float maxHealth=3;
  float healthPercentage=1;
  boolean isImgOne = true;
  int walkFrame = 0;
  
  ArrayList<Projectile> MonsterShot=new ArrayList<Projectile>();
  int expValue;
  
  Monster(PVector pos,PVector vel ,float health, PImage Img, int expValue){
    super(pos,vel,health,Img);
    this.expValue=expValue;
    this.maxHealth = health;
    this.vel = new PVector(random(-5, 5), 0);
    // Update monster's damage according to the game level
    switch(level){
      case 0:
        damage = 1;
        break;
      case 1:
        damage = 2;
        break;
      case 2:
        damage = 3;
        break;
      case 3:
        damage = 5;
        break;
    }
  }
  
  void update(){
    healthPercentage=(float)this.health/maxHealth;//xdxdxd..
    drawHP();
    super.moveCharacter();
    drawMe();
    checkWalls(); 
    if(player.hit(this)&&this.health!=0){ 
      if(defTime == 0){
        player.decreaseHp(damage); //xdxdxdxd ....
        defTime=60;  //once the player get hit , it will be protect in 1 sec 
      } 
        defTime--;
    } 
    if(this.health==0){
      monsters.remove(this);
      player.exp+=expValue;
      //player.expPercentage+=0.2;   //.......xd
      isAlive=false;  
    }
}
  
  void checkWalls(){
   if (pos.x<Img.width/2) {
     vel.x*=-1;
   }
   if (pos.x>width-Img.width/2){
     vel.x*=-1;
   }
   if (pos.y>680) pos.y=680;   //y zhou
   }
  boolean collision(Player other){
    if (dist(pos.x, pos.y, other.pos.x, other.pos.y) < Img.width/2 +other.Img.width/2) {
      return true;
    }
    return false;
  }
  
  void drawMe(){  //switch the image had problem here ,
    if (frameCount % 5 == 0){
      walkFrame += 1;
    }
    pushMatrix();
    translate(pos.x, pos.y);
    scale(-turning, 1);
    if(state==LEVEL_ONE){
        walkFrame %= monsterMapOne.length;
        image(monsterMapOne[walkFrame],0,0);
    }
    if(state==LEVEL_TWO){
       walkFrame %= monsterMapTwo.length;
       image(monsterMapTwo[walkFrame],0,0);
    }
    if(state==LEVEL_THREE){
        image(monsterMapThree,0,0);
        monsterMapThree.resize(192,156);
      }
    popMatrix();
  }
  
  void drawHP(){
    int healthBarWidth = this.Img.width/2;
    pushMatrix();
    fill(0, 64);
    translate(pos.x-healthBarWidth, pos.y - 80);
    rect(+50, -10, healthBarWidth, -20); //container for health
    fill(255, 0, 0, 255);
    rect(+50, -10, healthBarWidth * healthPercentage, -20); //health bar
    popMatrix();  
  }
  
  //void attack(){
  //  MonsterShot.add(new Projectile(new PVector(monsters.pos.x,monsters.pos.y),new PVector((player.pos.x - monsters.pos.x)/100,(player.pos.y - monsters.pos.y)/100)));
  //}
  //void checkBullet(){
  //  for(int i = 0; i < MonsterShot.size(); i++){
  //    Projectile a = MonsterShot.get(i);
  //    a.update();
  //    a.drawMe();
  //    if(a.collision(player)){
  //      player.health-=1;
  //      MonsterShot.remove(a);
  //    }
  //  }
  //}
}
  
  
  
