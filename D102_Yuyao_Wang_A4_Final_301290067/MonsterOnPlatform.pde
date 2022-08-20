// This class makes monster on the platform
class MonsterOnPlatform extends Monster {
  Platform onPlatform;
  MonsterOnPlatform(float health, PImage Img, int expValue, Platform onPlatform) {
    super(new PVector(onPlatform.pos.x+Img.width/2, onPlatform.pos.y-onPlatform.dim.y/2-Img.height/2+10), new PVector(random(-5, 5), 0), health, Img, expValue);
    this.onPlatform = onPlatform;
  }

  void checkWalls() {
    if (pos.x<onPlatform.pos.x - onPlatform.dim.x/2 + Img.width/2 && vel.x<0) {
      vel.x=abs(vel.x);
    }
    if (pos.x>onPlatform.pos.x + onPlatform.dim.x/2 - Img.width/2 && vel.x>0) {
      vel.x=-abs(vel.x);
    }
  }
}
