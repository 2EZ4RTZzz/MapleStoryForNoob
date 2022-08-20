// Display level up HUD when player levels up
class HUDLevelUp{
  boolean isAlive=true;
  float timer = PI; // Display for 1 seconds
  HUDLevelUp(){
    levelupsound.play(0);
  }
  
  void drawMe(){
    timer -= 2*PI/120;
    float transparency = 127 + sin(timer)*128;
    fill(0, transparency);
    noStroke();
    rect(0, height/2-40, width, 80);
    fill(255, transparency);
    textAlign(CENTER);
    textSize(50);
    text("Level UP! You are now "+player.playerLevel, width/2, height/2+12);
    if (timer <= 0) isAlive = false;
    stroke(0);
  }
}
