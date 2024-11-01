import fisica.*;
import java.util.*;
import java.io.*;

int mode = 0;
int player = 1;
int winner = 0;
PFont starborn = new PFont();
/*
modes
0 - title
1 - game
2 - end


player
1 - p1
2 - p2

*/
FPoly frametop, framebot, framelefttop, frameleftbot, framerighttop, framerightbot;
void setup(){
  starborn = createFont("starborn/Starborn.ttf", 128);
  textFont(starborn);
  initializevar();
  frameRate(144);
  size(700,1000);
  Fisica.init(this);
  
  world = new FWorld();
  world.setGravity(0,0);
  noStroke();
}
void initializevar(){
  
  ontable = new boolean[15];
  for(int i = 0; i < 15; i++){
    ontable[i] = true;
  }
  sticktheta = HALF_PI;
  stickv = 0;
  stickpower = 0;
  powermode = true;
  showstick = true;
  disappearframe = new int[15];
  switchplayer = false;
  ball8hitin = false;
  hitin = false;
  winreason = "";
  hitinthisturn = new ArrayList<>();
  whiteballdraggable = false;
}

void draw(){
 
  //println(mouseX + " " + mouseY);
  
  if(whiteballdraggable) println("1");
  switch(mode){
    case 0:
      title();
      break;
    case 1:
      game();
      break;
    case 2:
      end();
      break;
    default:
      break;
  }
}

void keyPressed(){
  switch(mode){
    case 0:
      titleK();
      break;
    case 1:
      gameK();
      break;
    case 2:
      endK();
      break;
    default:
      break;
  }
}
void keyReleased(){
  switch(mode){
    
    case 1:
      gameR();
      break;
    
    default:
      break;
  }
}
