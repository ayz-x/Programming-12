int gall = 1;
boolean showbutt = false;
boolean paused = true;
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      gall--;
      if (gall == 3) {
        gall--;
      }
      reset();
    }
    if (keyCode == RIGHT) {
      gall++;
      if (gall == 3) {
        gall++;
      }
      reset();
    }
  }
  if (key == 'L' || key == 'l') {
    showbutt = !showbutt;
  }
  if (key == 'P' || key == 'p') {
    paused = !paused;
  }
}
void mouseClicked() {
  if (mouseX < 150) {
    gall--;
    if (gall == 3) {
      gall--;
    }
    reset();
  }
  if (mouseX > 650) {
    gall++;
    if (gall == 3) {
      gall++;
    }
    reset();
  }
}

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {


  noStroke();
  if (gall < 1) {
    gall = 6;
  }
  if (gall > 6) {
    gall = 1;
  }
  if (paused) {
    switch(gall) {
    case 1:
      gal1();
      break;
    case 2:
      gal2();
      break;
    case 3:
      gal3();
      break;
    case 4:
      gal4();
      break;
    case 5:
      gal5();
      break;
    case 6:
      gal6();
    default:
      break;
    }
  }
  if (mouseX < 150) {
    if (arrowx1 > 100) {
      arrowx1-= 10;
    }
  } else {
    if (arrowx1 < 150) {
      arrowx1+= 10;
    }
  }

  if (mouseX > 650) {
    if (arrowx2 < 700) {
      arrowx2+= 10;
    }
  } else {
    if (arrowx2 > 650) {
      arrowx2-= 10;
    }
  }

  if (showbutt) {
    fill(0);
    arrow(arrowx1, 400, 0);
    arrow(arrowx2, 400, 1);
  }
}

float arrowx1=150;
float arrowx2=650;
void arrow(float x, float y, int d) {
  pushMatrix();
  translate(x, y);
  rectMode(CENTER);
  fill(127.5);
  rect(0, 0, 100, 50);
  if (d == 0) {
    triangle(-100, 0, -50, -50, -50, 50);
  }
  if (d == 1) {
    triangle(100, 0, 50, -50, 50, 50);
  }
  popMatrix();
}


float rot1 = 0;
void gal1() {
  pushMatrix();
  translate(400, 400);
  background(255);
  colorMode(RGB);
  rectMode(CENTER);
  rot1+=0.0005;
  for (int i = 120; i >0; i--) {
    pushMatrix();
    if (i%2 == 0) {
      rotate(-i*rot1);
      fill(255);
      rect(0, 0, i*10, i*10);
    }
    if (i%2 == 1) {
      rotate(i*rot1);
      fill(0);
      rect(0, 0, i*10, i*10);
    }
    popMatrix();
  }
  popMatrix();
}

boolean offset = true;
float scale2 = 1;
ArrayList<square> squares = new ArrayList<>();
void gal2() {
  colorMode(RGB);
  if (squares.isEmpty()) {
    for (int i = 49; i > -1; i--) {
      squares.add(new square(400, 400, 0, 100, 0 + 0.2*i));
    }
  }


  background(0);
  pushMatrix();
  background(255);
  rectMode(CENTER);

  for (int i = 0; i < squares.size(); i++) {
    if (squares.get(i).sc > 10) {
      squares.remove(i);
      squares.add(new square(400, 400, 0, 100, 0));
      offset = !offset;
    }

    if (offset ^ i%2 == 0) {
      fill(255);
      squares.get(i).drawSq();
    }
    if (offset ^ i%2 == 1) {
      fill(0);
      squares.get(i).drawSq();
    }

    squares.get(i).sc += 0.005;
  }

  popMatrix();
}


int[] trot3 = new int[100];
void gal3() {
  colorMode(RGB);
  rectMode(CENTER);
  rect(400, 400, 800, 800);

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      pushMatrix();
      translate(j*80+40, i*80 + 40);


      if ((i+j)%2 == 0) {
        fill(255);
      }
      if ((i+j)%2 == 1) {
        fill(0);
      }

      rect(0, 0, 80, 80);

      if ((i+j)%2 == 1) {
        fill(255);
      }
      if ((i+j)%2 == 0) {
        fill(0);
      }
      if (random(0, 30) > 29) {
        trot3[i*10 + j] = (int) random(0, 3);
      }

      rotate(HALF_PI*trot3[i*10 + j]);
      triangle(-40, -40, -40, 40, 40, -40);

      popMatrix();
    }
  }
}

void reset() {
  rot1 = 0;
  scale2 = 0;
  squares.clear();
  rot4 = 0;
  incre5 = 0;
  incre6 = 0;
}

class square {
  float x;
  float y;
  float r;
  float s;
  float sc;
  public square(float x, float y, float r, float s, float sc) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.s = s;
    this.sc = sc;
  }
  void drawSq() {
    pushMatrix();
    translate(x, y);
    rotate(r);
    scale(sc);
    rect(0, 0, s, s);
    popMatrix();
  }
}
