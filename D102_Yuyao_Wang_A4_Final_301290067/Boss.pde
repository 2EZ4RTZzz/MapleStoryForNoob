class Boss extends Monster{
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  //boolean isBossDead=false;
  Boss(PVector pos,PVector vel ,float health, PImage Img){
    super(pos,vel,health,Img, 1000);
    //this.isBossDead=isBossDead;
  }
  void update(){
    healthPercentage=(float)this.health/maxHealth;//xdxdxd..
    drawHP();
    super.moveCharacter();
    drawMe();
    checkWalls(); 
    if(player.hit(this)&&this.health!=0){ 
      if(defTime == 0){
        player.health-=5; 
        defTime=60;  //once the player get hit , it will be protect in 1 sec 
      } 
        defTime--;
    } 
    if(this.health==0){
      monsters.remove(this);
      player.exp+=2;
      //isBossDead=true;
      state=WON;
    }
    checkProjectiles();
}
  
  void decreaseHp(int dmg){
    super.decreaseHp(dmg);
    // Boss generate a projectile towards the player
    PVector heading = PVector.sub(player.pos, pos);
    heading.normalize();
    heading.mult(15);
    gunshootsound.play(0);
    projectiles.add(new Projectile(pos.copy(), heading));
  }
  
  void checkProjectiles(){
    for(int i=0;i<projectiles.size();i++){
    Projectile shot = projectiles.get(i);
    shot.update();
    if(shot.checkWalls()){
      projectiles.remove(shot);
    }
    else{
        if(shot.hit(player)){
          projectiles.remove(shot);  
          player.decreaseHp(5); 
        }
      }
  
    }
  }

  void checkWalls(){
   if (pos.x<Img.width/2) {
     //pos.x=Img.width/2-60;
     vel.x*=-1;
   }
   if (pos.x>width-Img.width/2){
     //pos.x=width-Img.width/2+50;
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
      walkFrame %= 2;
    }
    pushMatrix();
    translate(pos.x, pos.y);
    scale(-turning, 1);
    image(finalBoss[walkFrame], 0, 0);
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
}
