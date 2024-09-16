Ship[] ships1 = new Ship[5];
Ship[] ships2 = new Ship[5];
boolean[] shipavail1 = new boolean[5];
boolean[] shipavail2 = new boolean[5];
int shipmode = 0;

void setup1(){
  background(255);
  fill(0);
  stroke(0);
  for(int i = 0; i < 11; i++){
    line(i*80, 0,i*80, 800);
  }
  for(int i = 0; i < 11; i++){
    line(0, i*80, 800,i*80);
  }
  
  triangle(125, 900, 150, 925, 150, 875); 
  triangle(675, 900, 650, 925, 650, 875);
  
  textSize(32);
  switch(shipmode){
    case 0:
      fill(0);
      text("DESTROYER", 320, 850);
      fill(100);
      ellipse(400,900,475,75);
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4: 
      break;
    default:
      break;
  }
  
}
void setup2(){
  background(255);
  stroke(0);
  for(int i = 0; i < 11; i++){
    line(i*80, 0,i*80, 800);
  }
  for(int i = 0; i < 11; i++){
    line(0, i*80, 800,i*80);
  }
}

void setup1K(){
  
}
void setup2K(){

}
