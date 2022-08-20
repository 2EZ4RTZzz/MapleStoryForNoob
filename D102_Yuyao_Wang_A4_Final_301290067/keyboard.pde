//keyboard class
//up down left right , c for melee attack , space for range attack ,press f have hp recovery skill
boolean fire;
int switchT=0;
boolean isImg=true;
int timer=30;
float speed = 2;
PVector upAcc = new PVector(0, -70);
PVector downAcc = new PVector(0, speed);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);
boolean up, down, left, right;
void keyPressed() {
  if (portal.activated) return;
  if (key == CODED) {
    if (keyCode == UP) {
      portal.checkHit();
      if(!portal.activated)
        up = true;
    }
    else if (keyCode == DOWN) down = true;
    else if (keyCode == LEFT) left = true;
    else if (keyCode == RIGHT) right = true;
  }
  if(key == ' '&& player.health > 0){  
    player.fire();
  } else {
    //player.Img=loadImage("RealPlayer.png");
    //player.Img.resize(102,156);
    player.lowHp();
  }
  if(key == 'c' || key == 'C' && player.health > 0){
    player.melee();//still had dect problem , 
  }
  
  
  if(key =='f' || key == 'F' && player.health>0){
    player.def(); //player will protect herself not getting hit or hp increase
  }
  
  if(key == 'q' || key == 'Q' && player.health>0 && player.damageUpTimer == 0){
    player.damageUpTimer = 600;
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;
    else if (keyCode == RIGHT) right = false;
    else if (keyCode == LEFT)  left = false;
    else if (keyCode ==' ') fire=false;
  }
  if(!fire){
    player.Img = playerWalk[player.walkFrame];
    player.lowHp();
      //player.Img=loadImage("RealPlayer.png");
      //player.Img.resize(106,156);
  }
}
