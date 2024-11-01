int mode = 0;
boolean gameStart = false;
int frame = 0;
/*
0 start
 1 setup p1
 2 setup p2
 3 give to p1
 4 give to p2
 5 p1 fire
 6 p2 fire
 7 endscreen
 */

int[][] p1 = new int[10][10];
int[][] p2 = new int[10][10];

/*
0 = empty tile
 1 = ship
 2 = miss
 3 = hit
 4 = ship down
 */
void variablereset() {
  for (int i = 0; i < 5; i++) {
    shipavail1[i] = true;
    shipavail2[i] = true;
    ships1[i] = null;
    ships2[i] = null;
  }
  for(int i = 0; i < 10; i ++){
    for(int j = 0; j < 10; j++){
      p1[i][j] = 0;
      p2[i][j] = 0;
    }
  }
  gameStart = false;
  frame = 0;
  mode = 0;
  crs1x = 0;
  crs1y = 0;
  crs2x = 0;
  crs2y = 0;
  shipmode = 0;
  startplace = false;
  placedships = 0;
  error = false;
  end = false;
  gridmode1 = false;
  gridmode2 = false;
  endturn = false;
  miss = false;
  p1win = false;
  p2win = false;
  lockinput = false;
}

void setup() {
  frameRate(50);
  size(800, 1000);
  variablereset();
}
class Ship {
  int x1;
  int x2;
  int y1;
  int y2;
  boolean sunk;

  Ship(int x1, int x2, int y1, int y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    sunk = false;
  }
}
void draw() {
  /*
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      print(p2[i][j]);
    }
    println();
  }
  println();
  */
  println(frame);
  frame++;
  //println(frame);
  switch(mode) {
  case 0:
    title();
    break;
  case 1:
    setup1();
    break;
  case 2:
    setup2();
    break;
  case 3:
    passto1();
    break;
  case 4:
    passto2();
    break;
  case 5:
    p1turn();
    break;
  case 6:
    p2turn();
    break;
  case 7:
    end();
    break;
  default:
    break;
  }

  textSize(16);
  fill(0);
  text("controls: \n WASD to move \n Left and Right arrow key to switch ships/board \n Space to select", 10, 930);
}
void keyPressed() {
  if (!lockinput) {
    switch(mode) {
    case 0:
      titleK();
      break;
    case 1:
      setup1K();
      break;
    case 2:
      setup2K();
      break;
    case 3:
      passto1K();
      break;
    case 4:
      passto2K();
      break;
    case 5:
      p1turnK();
      break;
    case 6:
      p2turnK();
      break;
    case 7:
      endK();
    default:
      break;
    }
  }
}
