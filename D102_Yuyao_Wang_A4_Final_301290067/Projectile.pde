class Projectile{
  PVector pos,vel,dim;
  //PImage bullets; 
  
  Projectile(PVector pos,PVector vel){
    this.pos=pos;
    this.vel=vel;
    dim=new PVector(30,40);
  }
  
  void move(){
    pos.add(vel);
  }
  void moveBossProjectile(){
    pos.add(vel);
  }
  boolean checkWalls(){
    return abs(pos.x-width/2)>width/2||abs(pos.y-height/2)>height/2;
  }
  void update(){
    move();
    drawMe();
    if(checkWalls()){                
      player.projectiles.remove(this);  
    }
  }
  void drawMe(){
    pushStyle();
    pushMatrix();
    noStroke();
    translate(pos.x,pos.y);   
    fill(128+128*sin(frameCount*0.3), 128+128*sin(frameCount*0.5), 128+128*sin(frameCount*0.4));
    ellipse(0, 0,20,20);
    //quad(0,0,-10,+10,0,+20,+10,+10);
    popMatrix();    
    popStyle();
  }
  boolean hit(Character a){
    return abs(pos.x-a.pos.x)<dim.x/2+a.Img.width/2 &&abs(pos.y-a.pos.y)<dim.y/2+a.Img.height/2;
  }
}
