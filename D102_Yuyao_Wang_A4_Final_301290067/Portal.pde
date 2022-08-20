// WHen player press UP at the portal, player can go to the next level
class Portal{
  PImage portalImg;
  PVector dim = new PVector(200, 200);
  PVector pos;
  int coolDown = 100; // Takes this amount of time to go to the next level
  boolean activated = false;
  Portal(PVector pos){
    this.pos = pos;
    portalImg = loadImage("portal.png");
    portalImg.resize(int(dim.x),int(dim.y));
  }
  
  void checkHit(){
    // Check if portal hits the player
    if(abs(player.pos.x - pos.x) < player.relativeWidth + dim.x/2 && abs(player.pos.y - pos.y) < player.Img.height/2 + dim.y/2){
      activated = true;
    }
  }
  
  void drawMe(){
    fill(255);
    image(portalImg, pos.x, pos.y);
    if (activated){
      coolDown -= 3;
      float transparency = map(coolDown, 100, 0, 0, 255);
      fill(0, transparency);
      rect(0, 0, width, height);
      if (coolDown <= 0){
        level += 1;
        checkLevel();
        activated = false;
        coolDown = 100;
      }
    }
  }
  
}
