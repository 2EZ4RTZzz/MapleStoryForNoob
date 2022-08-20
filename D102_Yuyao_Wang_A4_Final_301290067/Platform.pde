// Platforms that allows player to stand on top of it
class Platform{
  PVector pos;
  PVector dim=platformDim.copy();
  Platform(PVector pos){
    this.pos = pos;
  }
  
  boolean checkHit(){
    // Check if player hit the platform
    if (abs(pos.x - player.pos.x) < dim.x/2 + 30 && abs(pos.y - player.pos.y) < dim.y/2 + player.Img.height/2){
      return true;
    }
    return false;
  }
  
  void drawMe(){
    image(platformImg, pos.x, pos.y);
  }
}
