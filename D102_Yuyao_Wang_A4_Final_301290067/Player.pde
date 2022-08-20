
class Player extends Character {
  
  int playerHpRecoveryChance = 5;
  int currFrame = 0;
  PImage[] activeFrames; //pointer
  int animationRate = 6;
  float healthPercentage=1;
  float expPercentage=0;
  int maxExp=1;
  int exp=0;
  int playerLevel = 0;
  float damp = 0.8;
  
  int fireTime=0;
  int damageUpTimer=0; // Increases damage by 20%
  
  int maxHp=10;
  boolean jumping = false;
  
  int walkFrame = 0;
  int damage = 1;
  int attackFrame=0;
  boolean attacking;
  
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  
  Player(PVector pos,PVector vel,float health){
    super(pos,vel,health, playerWalk[0]);
  }

  void update(){
    // Update bonus damage timer
    damageUpTimer = max(damageUpTimer-1, 0);
    
    // Update walk frames
    if (!jumping && abs(vel.x) >= 1 && frameCount%4 == 0){ //i used 4 different images to load the walking images
      walkFrame += 1;
      walkFrame %= playerWalk.length;
      Img = playerWalk[walkFrame];
    }    
    if(fireTime>0){
      fireTime--;
    }
    expPercentage=(float)exp/maxExp; //xd 
    healthPercentage=(float)health/maxHp; //checking the percentages
    super.update();
    vel.mult(damp);
    super.checkWalls();  // boundaryDete
    super.drawMe();
    checkProjectiles();
    //println(state);
    fall();                        
    if(player.pos.y>=760-playerImg.height){
      jumping=false;
    }
    //if(exp == 5){
    //  level=1;              
    //}
    //if(exp == 10){
    //  level=2;
    //}
    
    //if(exp == 15){
    //  level=3;
    //}
    //if(exp == 18){
    //  level=4;
    //} 
    if(player.health<=0){
      state = LOSE;
    }
    if (exp >= maxExp){  
      exp %= maxExp;
      if (playerLevel < 6){
        playerLevel += 1;
        maxHp += pow(2, playerLevel);  //when player level up , the plyaer hp will be max hp , and attack will increase 1 also max hp increase 2 point!
        health = maxHp;
        damage += 1;
        playerHpRecoveryChance=5; //when player level up , it will reset the hp recovery skill again.
      }
    
      
      maxExp += pow(2, playerLevel);
      hudlevelups.add(new HUDLevelUp());
    }
    
    if (attackFrame < attackImg.length - 1 && attacking){
      attackFrame += 1;
      if (attackFrame >= attackImg.length - 2){
        attacking = false;
        Img=playerWalk[walkFrame];
      } else {
        Img = attackImg[attackFrame];
      }
    }
  }
  //jump method
  void jump(PVector upAcc) {
    if (!jumping){
      jumpsound.play(0);
      vel.add(upAcc);
      moveCharacter();
      jumping = true;
    }
  }
  //fall down method
  void fall(){
    if(pos.y<680){
      for (int i=0; i<platforms.size(); i++){
        Platform platform=platforms.get(i);
       if (platform.checkHit()){
          pos.y = platform.pos.y - 70 - platform.dim.y/2;
          vel.y=0;
          jumping = false;
        } else {
          pos.y+=10;
        }
      }
      
    }
  }
      
  
  void checkProjectiles(){
    for(int i=0;i<projectiles.size();i++){
    Projectile shot = projectiles.get(i);
    shot.update();
    if(shot.checkWalls()){
      projectiles.remove(shot);
    }
    else{
      for(int j  = 0 ; j<monsters.size();j++){
        Monster e = monsters.get(j); 
        if(shot.hit(e)){
          projectiles.remove(shot); 
          if (damageUpTimer>0)
            e.decreaseHp(int(damage*1.2)); 
          else
            e.decreaseHp(int(damage));
        }
      }
    }
  }
  }
  
  void lowHp(){
    if(player.health<3){
      player.Img=loadImage("PlayerLowHp.png");
      player.Img.resize(102,156);
    }
  }

  void fire(){
    if(fireTime==0){
      projectiles.add(new Projectile(new PVector(pos.x,pos.y),new PVector(10 * turning,0))); 
      fireTime=20;
      gunshootsound.play(0);
      attackFrame=0;
      attacking=true;
    }
    
  }
  
  void melee(){
    player.Img=loadImage("RealPlayerMelee.png");
    player.Img.resize(200,156);
  }
  void def(){  //only have 5 times to increase the hp.
    player.Img=loadImage("RealPlayerDef.png");
    player.Img.resize(102,156);
    if(player.health>0&&player.health!=maxHp&&playerHpRecoveryChance>=0){
      player.health+=1;
      playerHpRecoveryChance-=1;
    }
  }
  
  //hp bar and exp bar 
  void drawHealthBar() {
    int healthBarWidth = 200;
    pushMatrix();
    fill(0, 64);
    translate(70, 30);
    pushStyle();
    fill(0);
    text("HP Bar", 0,0);
    popStyle();
    rect(-50, 0, healthBarWidth, 20); //container for health
    fill(255, 0, 0, 255);
    rect(-50, 0, healthBarWidth * healthPercentage, 20); //health bar
    popMatrix();
  }
  
  void drawExpBar(){
    int expBarWidth=200;
    pushMatrix();
    fill(0,64);
    translate(350,30);
    pushStyle();
    fill(0);
    text("Exp Bar", 0,0);
    popStyle();
    rect(-50, 0, expBarWidth,20); //container for health
    fill(127,255,0, 255);
    rect(-50, 0, expBarWidth * expPercentage, 20); //health bar
    popMatrix();
    
    fill(255);
    textAlign(CENTER);
    text("lv."+playerLevel, pos.x, pos.y - 70);
    
    if (damageUpTimer > 0){
      fill(0, 255, 0);
      text("damage+20% - "+ int(damageUpTimer/60), pos.x, pos.y - 90);
    }
  }
  
//  void increaseExp(){
//    if(Monster.health == 0 ){
//      exp+=1;
//  }
//}

}




  //void drawMe() {
  //  pushMatrix();
  //  translate(pos.x, pos.y);
  //  image(Img,0,0);
  //  popMatrix();
  //}
  

  
  //void boundaryDete(){
  //  if (pos.x<PlayerImg.width/2-50) pos.x=PlayerImg.width/2-50;
  //  if (pos.x>width-PlayerImg.width/2-50) pos.x=width-PlayerImg.width/2-50;  //x zhou
  //  if (pos.y>730-PlayerImg.height/2-50) pos.y=730-PlayerImg.height/2-50;   //y zhou
  //}
