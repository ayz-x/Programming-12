Ship[] ships1 = new Ship[5];
Ship[] ships2 = new Ship[5];
boolean[] shipavail1 = new boolean[5];
boolean[] shipavail2 = new boolean[5];
int shipmode = 0;
int crs1x = 0; //crosshair p1 x
int crs1y = 0; //crosshair p1 y
int crs2x = 0; //crosshair p2 x
int crs2y = 0; //crosshair p2 y
int blinkframe = 0;
int shipx;
int shipy;
boolean startplace = false;



void setup1() {
  blinkframe++;
  if (!startplace) {
    background(255);
  } else {
    background(200);
  }
  fill(0);
  stroke(0);
  for (int i = 0; i < 11; i++) {
    line(i*80, 0, i*80, 800);
  }
  for (int i = 0; i < 11; i++) {
    line(0, i*80, 800, i*80);
  }

  triangle(125, 900, 150, 925, 150, 875);
  triangle(675, 900, 650, 925, 650, 875);

  textSize(32);
  switch(shipmode) {
  case 0:
    fill(0);
    text("CARRIER", 330, 850);
    fill(100);
    ellipse(400, 900, 475, 75);
    break;
  case 1:
    fill(0);
    text("BATTLESHIP", 320, 850);
    fill(100);
    ellipse(400, 900, 375, 75);
    break;
  case 2:
    fill(0);
    text("CRUISER", 330, 850);
    fill(100);
    ellipse(400, 900, 275, 75);
    break;
  case 3:
    fill(0);
    text("SUBMARINE", 320, 850);
    fill(100);
    ellipse(400, 900, 275, 70);
    break;
  case 4:
    fill(0);
    text("DESTROYER", 320, 850);
    fill(100);
    ellipse(400, 900, 175, 65);
    break;
  default:
    break;
  }

  
  if(startplace){
    textSize(30);
    text("Choose Ship End", 300,400);
  }

  if (shipmode < 0) {
    shipmode = 4;
  }
  if (shipmode > 4) {
    shipmode = 0;
  }
  if (blinkframe%50 < 25) {
    pushMatrix();
    translate(crs1x*80+40, crs1y*80+40);
    line(-20, 0, 20, 0);
    line(0, -20, 0, 20);
    popMatrix();
  }
  println(crs1x + " " + crs1y);
}
void setup2() {
  background(255);
  stroke(0);
  for (int i = 0; i < 11; i++) {
    line(i*80, 0, i*80, 800);
  }
  for (int i = 0; i < 11; i++) {
    line(0, i*80, 800, i*80);
  }
}

void setup1K() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      shipmode--;
      if (shipmode < 0) {
        shipmode = 4;
      }
      while (!shipavail1[shipmode]) {
        shipmode--;
        if (shipmode < 0) {
          shipmode = 4;
        }
      }
    }
    if (keyCode == RIGHT) {
      shipmode++;
      if (shipmode > 4) {
        shipmode = 0;
      }
      while (!shipavail1[shipmode]) {
        shipmode++;
        if (shipmode > 4) {
          shipmode = 0;
        }
      }
    }
    
  }
  if(keyCode == ' '){
      if(!startplace){
        startplace = true;
        shipx = crs1x;
        shipy = crs1y;
      }
      else{
        startplace = false;
        if(checkAvailable(crs1x, crs1y)){
          ships1[shipmode] = new Ship(shipx,shipy,crs1x,crs1y);
        }
      }
    }
  if (key == 'W' || key == 'w') {
    blinkframe = 0;
    crs1y--;
    if (crs1y < 0) {
      crs1y = 9;
    }
  }
  if (key == 'S' || key == 's') {
    blinkframe = 0;
    crs1y++;
    if (crs1y > 9) {
      crs1y = 0;
    }
  }
  if (key == 'A' || key == 'a') {
    blinkframe = 0;
    crs1x--;
    if (crs1x < 0) {
      crs1x = 9;
    }
  }
  if (key == 'D' || key == 'd') {
    blinkframe = 0;
    crs1x++;
    if (crs1x > 9) {
      crs1x = 0;
    }
  }
}
void setup2K() {
}

// need to add see if is taken by other boat
boolean checkAvailable(int sx, int sy){
  if(shipx != sx && shipy == sy){
    return true;
  }else if(shipy != sy && shipx == sx){
    return true;
  }else{
    return false;
  }
  
}
