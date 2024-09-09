int time = 0; //sun/moon pos= (t, sqrt(r^2 - t^2)) as (x,y) 
ArrayList<treeLeaf> leaves1 = new ArrayList<>();
ArrayList<treeLeaf> leaves2 = new ArrayList<>();
ArrayList<treeLeaf> leaves3 = new ArrayList<>();
ArrayList<treeLeaf> leaves4 = new ArrayList<>();
float housex1 = random(-200,200);
float housex2 = random(300,600);
float housey1 = random(350,400);
float housey2 = random(350,400);
float roofh1 = random(100,300);
float roofh2 = random(100,300);
float roofw1 = random(-10,60);
float roofw2 = random(-10,60);
float[] treex = new float[4];
float[] treey = new float[4];
float[] trees = new float[4];

void setup(){
  size(1000,800);
  noStroke();
 
  
  for(int i = 0; i < 200; i++){
    float r = sq(random(1,10));
    float t = random(0,2*PI);
    float o = r*cos(t)*0.005;
    float s = random(60,70);
    leaves1.add(new treeLeaf(r,t,o,s));
  }
  for(int i = 0; i < 200; i++){
    float r = sq(random(1,10));
    float t = random(0,2*PI);
    float o = r*cos(t)*0.005;
    float s = random(60,70);
    leaves2.add(new treeLeaf(r,t,o,s));
  }
  for(int i = 0; i < 200; i++){
    float r = sq(random(1,10));
    float t = random(0,2*PI);
    float o = r*cos(t)*0.005;
    float s = random(60,70);
    leaves3.add(new treeLeaf(r,t,o,s));
  }
  for(int i = 0; i < 200; i++){
    float r = sq(random(1,10));
    float t = random(0,2*PI);
    float o = r*cos(t)*0.005;
    float s = random(60,70);
    leaves4.add(new treeLeaf(r,t,o,s));
  }
  
  for(int i = 0; i < 4; i++){
    treex[i] = random(i*450,(i+1)*450);
    treey[i] = random(0,200);
    trees[i] = random(0.45,0.55);
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
  
  
  
  drawTree(leaves1, treex[0], treey[0], trees[0]);
  drawTree(leaves2, treex[1], treey[1],trees[1]);
  drawTree(leaves3, treex[2], treey[2],trees[2]);
  drawTree(leaves4, treex[3], treey[3],trees[3]);
  
  drawHouse(housex1, housey1,roofw1,roofh1);
  drawHouse(housex2, housey2,roofw2,roofh2);
  
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
void drawTree(ArrayList<treeLeaf> leaves, float xx, float yy, float ss){
  pushMatrix();
  scale(ss);
  rectMode(CENTER);
  translate(200 + xx,1000 + yy);
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
    
    x+= 20*(noise(o) -0.5);
    circle(x,y,s);
  }
  popMatrix();
}



void drawHouse(float x, float y, float roofw, float roofh){
  pushMatrix();
  translate(x,y);
  scale(0.5);
  
  rectMode(CENTER);
  fill(#950606);
  rect(600,500,300,300);
  drawRoof(roofw,roofh);
  fill(#935504);
  rect(675,575,75,150);
  
  
  rect(527.5, 477.5, 115, 115);
  
  drawWindow();
  
  popMatrix();
}
void drawRoof(float roofw,float roofh){
  triangle(400-roofw,350,800+roofw,350,600,roofh);
}
void drawWindow(){
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
    o+= 0.02;
  }
}
