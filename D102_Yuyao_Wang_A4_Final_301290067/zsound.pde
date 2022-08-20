//this is the game sound , i had 5 different sound used in this game
import ddf.minim.*;
import controlP5.*;

Minim minim; 
ControlP5 controlP5;

AudioPlayer bgm, levelupsound, gunshootsound, jumpsound, bossbgm;

void loadSounds(){
  minim = new Minim(this);
  bgm = minim.loadFile("backGround.mp3");
  bgm.setGain(-10);
  bgm.loop();
  
  levelupsound = minim.loadFile("levelup.mp3");
  gunshootsound = minim.loadFile("GunShotSound.mp3");
  jumpsound = minim.loadFile("Jump.mp3");
  bossbgm = minim.loadFile("song.mp3");
}
