void title(){
  background(#2B740D);
  textAlign(CENTER,CENTER);
  textSize(64);
  fill(0);
  text("8 Ball", width/2, height/2 - 50);
  textSize(32);
  
  text("Press any key to start", width/2, height/2 + 50);

}

void titleK(){
  mode = 1;
  player = (int) random(1,3);
  createFrame();
  createBalls();
  createWhiteBall();
}
