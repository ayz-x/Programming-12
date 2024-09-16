int mode = 0;
boolean gameStart = false;
/*
0 start
 1 setup p1
 2 setup p2
 3 give to p1
 4 give to p2
 5 p1 fire
 6 p2 fire
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
  for(int i = 0; i < 5; i++){
    shipavail1[i] = true;
    shipavail2[i] = true;
  }
}

void setup() {
  size(800, 1000);
  variablereset();
}
class Ship {
  int x1;
  int x2;
  int y1;
  int y2;

  Ship(int x1, int x2, int y1, int y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
}
void draw() {
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
  default:
    break;
  }
}
void keyPressed() {
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
  default:
    break;
  }
}
