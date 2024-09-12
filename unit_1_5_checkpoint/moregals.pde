float rot4 = 0;
void gal4(){
  colorMode(RGB);
  pushMatrix();
  translate(400,400);
  background(0);
  rectMode(CENTER);
  rot1+=0.0005;
  for(int i = 120; i >0; i--){
    pushMatrix();
    if(i%2 == 1){
      rotate(i*rot1);
      fill(255);
      rect(0,0,i*10,i*10);
    }
    if(i%2 == 0){
      rotate(i*rot1);
      fill(0);
      rect(0,0,i*10,i*10);
    }
    popMatrix();
  }
  popMatrix();
}

float incre5 = 0;
void gal5(){
  colorMode(RGB);
  pushMatrix();
  translate(400,400);
  background(0);
  rectMode(CENTER);
  incre5+=0.001;
  for(int i = 80; i >0; i--){
    pushMatrix();
    if(i%2 == 0){
      rotate(-i*incre5);
      fill(255);
      triangle(0,i*15,-i*sqrt(300),-i*10,i*sqrt(300),-i*10);
    }
    if(i%2 == 1){
      rotate(-i*incre5);
      fill(0);
      triangle(0,i*15,-i*sqrt(300),-i*10,i*sqrt(300),-i*10);
    }
    popMatrix();
  }
  popMatrix();
}

float incre6 = 0;
void gal6(){
  
  colorMode(RGB);
  pushMatrix();
  translate(400,400);
  background(0);
  rectMode(CENTER);
  incre6+=0.001;
  for(int i = 70; i >0; i--){
    pushMatrix();
    if(i%2 == 1){
      rotate(i*incre6);
      fill(255);
      triangle(0,i*15,-i*sqrt(300),-i*10,i*sqrt(300),-i*10);
    }
    if(i%2 == 0){
      rotate(-i*incre6);
      fill(0);
      triangle(0,i*15,-i*sqrt(300),-i*10,i*sqrt(300),-i*10);
    }
    popMatrix();
  }
  popMatrix();

}
