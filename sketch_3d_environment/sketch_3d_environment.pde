import java.awt.Robot;
Robot rbt;
boolean w, a, s, d, shift, space, control, shoot;
float spd;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ;
float theta, phi;
boolean skipFrame;
boolean[][][] terrain = new boolean[41][20][41];
PVector tcoord, pcoord;
boolean freemouse;
int temp;
float accel;
float velo;
boolean falling;

Map m1;

void setup() {
  for (int i = 0; i < 41; i++) {
    for (int j = 0; j < 10; j++) {
      for (int k = 0; k < 41; k++) {
        terrain[i][j][k] = false;
      }
    }
  }
  generateEmpty(41, 41);
  size(800, 600, P3D);
  //fullScreen(P3D);
  textureMode(NORMAL);
  frameRate(144);
  w = a = s = d = false;
  eyeX = 2000;
  eyeY = 1000;
  eyeZ = 2000;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  upX = 0;
  upY = -1;
  upZ = 0;
  theta = 0;
  phi = 0;
  noCursor();
  m1 = new Map(world);
  try {
    rbt = new Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  skipFrame = false;
  pcoord = new PVector(0, 0, 0);
  tcoord = new PVector(0, 0, 0);
}

void draw() {
  tcoord.x = (eyeX/100);
  tcoord.y = (eyeY/100);
  tcoord.z = (eyeZ/100);
  pcoord.x = eyeX;
  pcoord.y = eyeY;
  pcoord.z = eyeZ;
  


  background(0);
  drawAxes();
  controlCamera();
  //drawFloor();
  drawFocalPoint();
  loadTextures();
  m1.addtoWorld();
}

void drawAxes() {
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}

void controlCamera() {
  if (skipFrame == false) {
    theta += -(mouseX - pmouseX)*0.01;
    phi += -(mouseY - pmouseY)*0.01;
  }

  if (phi > PI/2.5) {
    phi = PI/2.5;
  }
  if (phi < -PI/2.5) {
    phi = -PI/2.5;
  }

  if (!freemouse) {
    if (mouseX<100) {
      rbt.mouseMove(width/2, height/2);
      skipFrame = true;
    } else if (mouseX > width-100) {
      rbt.mouseMove(width/2, height/2);
    } else {
      skipFrame = false;
    }
  }
  if (control) {
    spd = 40;
  } else {
    spd = 20;
  }

  if (w) {
    temp = canGoForward();
    if (temp == 0 || temp == 1) {
      eyeZ+=sin(theta)*spd;
    }
    if (temp == 0 || temp == 2) {
      eyeX+=cos(theta)*spd;
    }
  }
  if (s) {
    temp = canGoBack();
    if (temp == 0 || temp == 1) {
      eyeZ-=sin(theta)*spd;
    }
    if (temp == 0 || temp == 2) {
      eyeX-=cos(theta)*spd;
    }
  }
  if (a) {
    temp = canGoLeft();
    if (temp == 0 || temp == 1) {
      eyeZ+=cos(theta)*spd;
    }
    if (temp == 0 || temp == 2) {
      eyeX-=sin(theta)*spd;
    }
  }
  if (d) {
    temp = canGoRight();
    if (temp == 0 || temp == 1) {
      eyeZ-=cos(theta)*spd;
    }
    if (temp == 0 || temp == 2) {
      eyeX+=sin(theta)*spd;
    }
  }
 
  if(canGoDown()){
    falling = true;
  }else{
    falling = false;
  }
  if(space && !falling){
    velo = 25;
  }
  if(canGoUp()){
    eyeY += velo;
  }else{
    velo = -velo*0.5;
  }
  
  if(canGoDown()){
    accel = 2;
    velo -= accel;
  }else{
    accel = 0;
    velo = 0;
  }
  
  if(shoot){
    snowballs.add(new Snowball(pcoord.x, pcoord.y, pcoord.z, theta, phi));
  }
  focusX = eyeX + cos(theta)*300;
  focusY = eyeY + tan(phi)*300;
  focusZ = eyeZ + sin(theta)*300;

  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ);
  
  shoot = false;
  
  for(int k = 0; k < snowballs.size(); k++){
    snowballs.get(k).act();
    if(snowballs.get(k).collide()){
      snowballs.remove(k);
      println("hit");
      k--;
    }
  }
  for(int k = 0; k < residues.size(); k++){
    residues.get(k).act();
    if(residues.get(k).timing()){
      residues.remove(k);
      k--;
    }
  }
}
void drawFloor() {
  background(0);
  stroke(255);
  for (int i = -20; i <= 20; i++) {
    line(i*100 + 1000, 0, -2000, i*100 + 1000, 0, 2000);
    line(-1000, 0, i*100, 3000, 0, i*100);
  }
  for (int i = -20; i <= 20; i++) {
    line(i*100, 2000, -2000, i*100, 2000, 2000);
    line(-2000, 2000, i*100, 2000, 2000, i*100);
  }
}




void drawCube(float x, float y, float z, PImage t, PImage d, PImage l, PImage r, PImage f, PImage b) {
  pushMatrix();
  translate(x, y, z);
  scale(50);
  noStroke();

  //down
  beginShape(QUADS);
  texture(d);
  vertex(-1, -1, -1, 0, 0);
  vertex(1, -1, -1, 0, 1);
  vertex(1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 1, 0);
  endShape();
  //top
  beginShape(QUADS);
  texture(t);
  vertex(-1, 1, -1, 0, 0);
  vertex(1, 1, -1, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);
  endShape();
  //front
  beginShape(QUADS);
  texture(f);
  vertex(-1, -1, 1, 1, 1);
  vertex(1, -1, 1, 0, 1);
  vertex(1, 1, 1, 0, 0);
  vertex(-1, 1, 1, 1, 0);
  endShape();
  //back
  beginShape(QUADS);
  texture(b);
  vertex(-1, -1, -1, 1, 1);
  vertex(1, -1, -1, 0, 1);
  vertex(1, 1, -1, 0, 0);
  vertex(-1, 1, -1, 1, 0);
  endShape();
  //left
  beginShape(QUADS);
  texture(l);
  vertex(-1, -1, -1, 1, 1);
  vertex(-1, -1, 1, 0, 1);
  vertex(-1, 1, 1, 0, 0);
  vertex(-1, 1, -1, 1, 0);
  endShape();
  //right
  beginShape(QUADS);
  texture(r);
  vertex(1, -1, -1, 1, 1);
  vertex(1, -1, 1, 0, 1);
  vertex(1, 1, 1, 0, 0);
  vertex(1, 1, -1, 1, 0);

  endShape();
  popMatrix();
}


void keyPressed() {
  if (key == 'W' || key == 'w') {
    w = true;
  }
  if (key == 'A' || key == 'a') {
    a = true;
  }
  if (key == 'S' || key == 's') {
    s = true;
  }
  if (key == 'D' || key == 'd') {
    d = true;
  }
  if (key == ' ') {
    space = true;
  }
  if (keyCode == SHIFT) {
    shift = true;
  }
  if (keyCode == ALT) {
    freemouse = freemouse ^ true;
  }
}
void keyReleased() {
  if (key == 'W' || key == 'w') {
    w = false;
  }
  if (key == 'A' || key == 'a') {
    a = false;
  }
  if (key == 'S' || key == 's') {
    s = false;
  }
  if (key == 'D' || key == 'd') {
    d = false;
  }
  if (key == ' ') {
    space = false;
  }
  if (keyCode == SHIFT) {
    shift = false;
  }
  if (keyCode == CONTROL) {
    control = false;
  }
}
void keyTyped(){
  if(key == 'f' || key == 'F'){
    shoot = true;
  }
}
