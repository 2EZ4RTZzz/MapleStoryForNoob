import controlP5.*;
Button play, replay;
 
void loadButton(){
  controlP5 = new ControlP5(this);
  PFont ffont = loadFont("Serif-48.vlw");//this is not create by me , i download from the processing library
  replay=controlP5.addButton("Replay", 0, width/2 - 225, height/2 + 50, 450, 100);
  replay.getCaptionLabel().setFont(ffont);
  replay.setColorForeground(color(0, 200, 0));         
  replay.setColorBackground(color(0, 0, 0));
  replay.hide();
  
  play=controlP5.addButton("Play", 0, width/2 - 100, height/2 + 50, 200, 60);
  play.getCaptionLabel().setFont(ffont);
  play.setColorForeground(color(0, 200, 0));         
  play.setColorBackground(color(0, 0, 0));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() =="Replay") {
    restartGame();
    replay.hide();
  }
  
  if (theEvent.getController().getName() =="Play") {
    gamebegin=true;
    play.hide();
  }
}
