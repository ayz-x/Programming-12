void passto1(){
  background(255);
  fill(0);
  textSize(64);
  text("Pass to P1", 270,400);
  textSize(16);
  text("Press any key to continue", 320,600);
}
void passto2(){
  background(255);
  fill(0);
  textSize(64);
  text("Pass to P2", 270,400);
  textSize(16);
  text("Press any key to continue", 320,600);
}

void passto1K(){
  if(gameStart){
    mode = 5;
    gridmode1 = false;
    turnnum++;
  }else{
    mode = 1;
    shipmode = 0;
  }
}
void passto2K(){
  if(gameStart){
    mode = 6;
    gridmode2 = false;
  }else{
    mode = 2;
    shipmode = 0;
    placedships = 0;
  }
}
