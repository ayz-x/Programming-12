int time = 0; //sun/moon pos= (t, sqrt(r^2 - t^2)) as (x,y) 
ArrayList<treeLeaf> leaves = new ArrayList<>();

void setup(){
  size(1000,800);
  noStroke();
 
  
  for(int i = 0; i < 200; i++){
    float r = sq(random(1,10));
    float t = random(0,2*PI);
    float o = random(0,5);
    float s = random(60,70);
    leaves.add(new treeLeaf(r,t,o,s));
  }
}

void draw(){
  color col = 0;
  rectMode(CORNER);
 
  color day = color(#A6FCF7);
  color night = color(#37035A);
  color sunset = color(#F5762C);
  if(time > -200 && time <= -100){
    col = (lerpColor(night, sunset, (time+200.0)/100.0)); // night to sunrise
  }
  if(time > -100 && time <= 0){
    col = (lerpColor(sunset, day, (time+100.0)/100.0)); // sunrise to day
  }
  if(time > 0 && time <= 800){
    col = day; // day
  }
  if(time > 800 && time <=900){
    col = (lerpColor(day, sunset, (time-800.0)/100.0)); // day to sunset
  }
  if(time > 900 && time <=1000){
    col = (lerpColor(sunset, night, (time-900.0)/100.0)); // sunset to night
  }
  if(time > 1000){
    time = -1000; //night starts
  }
  if(time > -1000 && time <= -200){
    col = night; //night
  }
  
  background(col);
  
  if(time > 0 && time < 800){
    drawSun(time-400);
  }
  if(time >-1000&& time < -200){
    drawMoon(time+600);
  }
  
  
  time++;
  
  fill(#067619);
  rect(0,600,1000,200);
  
  
  
  
  
  drawHouse();
  drawTree();
}


void drawSun(float t){
  pushMatrix();
  translate(500,650);
  fill(#F7DD43);
  float x = t;
  float y = -sqrt(2*((400*400) - (t*t)));
  for(int i = 1; i < 9; i++){
    pushMatrix();
    translate(x,y);
    rotate(((i*PI)/4) + t/30);
    triangle(-10,20,10,20,0,40);
    popMatrix();
  }
  
  circle(x,y,50);
  
  
  popMatrix();
  
}

void drawMoon(int t){
  pushMatrix();
  translate(500,650);
  fill(#F7DD43);
  float x = t;
  float y = -sqrt(2*((400*400) - (t*t)));
  circle(x,y,50);
  popMatrix();
}
void drawTree(){
  pushMatrix();
  translate(200,400);
  fill(#935504);
  rect(0,125,50,300);
  fill(#04B723);
  for(int i = 0; i < leaves.size(); i++){
    float r = leaves.get(i).r;
    float t = leaves.get(i).t;
    float x = r*cos(t);
    float y = r*sin(t);
    float o = leaves.get(i).o;
    float s = leaves.get(i).s;
    leaves.get(i).increment();
    
    x+= 15*(noise(o) -0.5);
    circle(x,y,s);
  }
  popMatrix();
}



void drawHouse(){
  rectMode(CENTER);
  fill(#950606);
  rect(600,500,300,300);
  triangle(400,350,800,350,600,200);
  fill(#935504);
  rect(675,575,75,150);
  
  
  rect(527.5, 477.5, 115, 115);
  
  fill(#A2FAE3);
  rect(500,505,50,50);
  rect(555,505,50,50);
  rect(500,450,50,50);
  rect(555,450,50,50);
  
  
}


class treeLeaf{
  float r;
  float t;
  float o; //offset
  float s;
  treeLeaf(float r, float t, float o, float s){
    this.r = r;
    this.t = t;
    this.o = o;
    this.s = s;
  }
  public void increment(){
    o+= 0.05;
  }
}
