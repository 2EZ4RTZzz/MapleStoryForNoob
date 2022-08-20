class Character{
  int relativeWidth = 95;
  PVector pos,vel;
  float health;
  PImage Img;
  float scale = 0.1;
  boolean jumping = false;  
  int turning = 1;
  Character(PVector pos,PVector vel ,float health, PImage Img){
    this.pos=pos;
    this.vel=vel;
    this.health=health;
    this.Img=Img;
  }
  
  void moveCharacter(){
    pos.add(vel);
    if (vel.x > 0) turning = 1;
    else if (vel.x < 0) turning = -1;
  }
  
  void accelerate (PVector force){
    vel.add(force);
  }
  
  void drawMe(){ 
    pushMatrix();
    translate(pos.x, pos.y);
    scale(turning, 1);
    image(Img,0,0);
    popMatrix();
  }
  
  boolean hit(Character a){
    return abs(pos.x-a.pos.x)<relativeWidth+a.Img.width/2 &&abs(pos.y-a.pos.y)<this.Img.height/2+a.Img.height/2;
  }
 
 void checkWalls(){
   if (pos.x<Img.width/2) pos.x=Img.width/2;
   if (pos.x>width-Img.width/2) pos.x=width-Img.width/2;  //x zhou
   if (pos.y>680) pos.y=680;   //y zhou
  }
  
  void update(){
    moveCharacter();
    checkWalls();
    fall();
    if(pos.y>=760-Img.height){
      jumping=false;
    }
  }
 
 void jump(PVector upAcc) {
    vel.add(upAcc);
    moveCharacter();
    jumping = true;
  }
  
  void fall(){
    if(pos.y<820-Img.height){
      pos.y+=50;
    }
    //println(pos.y);
  }
  
  void drawHP(){
    rect(100,100,100,100); //dummytest poly.
  }
  void decreaseHp(int dmg){
    if (portal.activated) return;
    if(health>0){
      this.health-=dmg;  
      this.health = max(this.health, 0);
    }
  }

  
}
