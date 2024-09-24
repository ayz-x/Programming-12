Ship[] ships1 = new Ship[5];
Ship[] ships2 = new Ship[5];
boolean[] shipavail1 = new boolean[5];
boolean[] shipavail2 = new boolean[5];
int shipmode = 0;
// 0 - 5
// 1 - 4
// 2 - 3
// 3 - 3
// 4 - 2
int crs1x = 0; //crosshair p1 x
int crs1y = 0; //crosshair p1 y
int crs2x = 0; //crosshair p2 x
int crs2y = 0; //crosshair p2 y
int blinkframe = 0;
int shipx;
int shipy;
boolean startplace = false;
int placedships = 0;
boolean error = false;
boolean lockinput = false;
boolean end = false;

void setup1() {
  blinkframe++;
  //gray bg
  if (!startplace && !error && !end) {
    background(255);
  } else {
    background(200);
  }
  //grid
  fill(0);
  stroke(0);
  for (int i = 0; i < 11; i++) {
    line(i*80, 0, i*80, 800);
  }
  for (int i = 0; i < 11; i++) {
    line(0, i*80, 800, i*80);
  }

  //arrows
  triangle(125, 900, 150, 925, 150, 875);
  triangle(675, 900, 650, 925, 650, 875);

  //ship choose display
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

  for (int i = 0; i < placedships; i++) {
    fill(200);
    Ship ship = ships1[i];
    float sx1 = ship.x1;
    float sx2 = ship.x2;
    float sy1 = ship.y1;
    float sy2 = ship.y2;

    if (sy1 == sy2) { // horizontal
      ellipse(((sx1 + sx2)/2) * 80 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
    } else { // vertical
      ellipse(sx1 * 80 + 40, ((sy1 + sy2)/2)*80 + 40, 65, abs(sy1-sy2)*80+40);
    }
  }



  //ship weird stuff
  fill(100);
  if (startplace) {
    textSize(30);
    text("Choose Ship End", 300, 400);
  }
  if (error) {
    text("Error", 350, 400);
    if (frame > 100) {
      error = false;
      lockinput = false;
    }
  }

  if (end) {
    text("Ship placing ended... giving to P2", 200, 400);
    if (frame > 100) {
      end = false;
      lockinput = false;
      placedships = 0;
      mode = 4;
    }
  }

  if (shipmode < 0) {
    shipmode = 4;
  }
  if (shipmode > 4) {
    shipmode = 0;
  }
  //crosshair
  if (blinkframe%50 < 25) {
    pushMatrix();
    translate(crs1x*80+40, crs1y*80+40);
    line(-20, 0, 20, 0);
    line(0, -20, 0, 20);
    popMatrix();
  }

  if (placedships == 5 && !end) {
    lockinput = true;
    frame = 0;
    end = true;
  }
}
void setup2() {
  blinkframe++;
  //gray bg
  if (!startplace && !error && !end) {
    background(255);
  } else {
    background(200);
  }
  //grid
  fill(0);
  stroke(0);
  for (int i = 0; i < 11; i++) {
    line(i*80, 0, i*80, 800);
  }
  for (int i = 0; i < 11; i++) {
    line(0, i*80, 800, i*80);
  }

  //arrows
  triangle(125, 900, 150, 925, 150, 875);
  triangle(675, 900, 650, 925, 650, 875);

  //ship choose display
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

  for (int i = 0; i < placedships; i++) {
    fill(200);
    Ship ship = ships2[i];
    float sx1 = ship.x1;
    float sx2 = ship.x2;
    float sy1 = ship.y1;
    float sy2 = ship.y2;

    if (sy1 == sy2) { // horizontal
      ellipse(((sx1 + sx2)/2) * 80 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
    } else { // vertical
      ellipse(sx1 * 80 + 40, ((sy1 + sy2)/2)*80 + 40, 65, abs(sy1-sy2)*80+40);
    }
  }



  //ship weird stuff
  fill(100);
  if (startplace) {
    textSize(30);
    text("Choose Ship End", 300, 400);
  }
  if (error) {
    text("Error", 350, 400);
    if (frame > 100) {
      error = false;
      lockinput = false;
    }
  }

  if (end) {
    text("Setup ended... Game starting!", 220, 400);
    if (frame > 100) {
      end = false;
      lockinput = false;
      placedships = 0;
      gameStart = true;
      mode = 3;
    }
  }

  if (shipmode < 0) {
    shipmode = 4;
  }
  if (shipmode > 4) {
    shipmode = 0;
  }
  //crosshair
  if (blinkframe%50 < 25) {
    pushMatrix();
    translate(crs2x*80+40, crs2y*80+40);
    line(-20, 0, 20, 0);
    line(0, -20, 0, 20);
    popMatrix();
  }

  if (placedships == 5 && !end) {
    lockinput = true;
    frame = 0;
    end = true;
  }
}

void setup1K() {
  if (!lockinput) {
    if (key == CODED) {
      if (!startplace) {
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
    }
    if (keyCode == ' ') {
      if (!startplace) {
        startplace = true;
        shipx = crs1x;
        shipy = crs1y;
      } else {
        startplace = false;
        if (checkAvailable1(crs1x, crs1y)) {
          ships1[placedships] = new Ship(shipx, crs1x, shipy, crs1y);
          placedships++;
          shipavail1[shipmode] = false;
          while (!shipavail1[shipmode] && placedships < 5) {
            shipmode++;
            if (shipmode > 4) {
              shipmode = 0;
            }
          }
          int sx = crs1x;
          int sy = crs1y;
          if (shipx != sx && shipy == sy) {
            if (shipx < sx) {
              for (int i = shipx; i < sx + 1; i++) {
                p1[sy][i] = 1;
              }
            }
            if (shipx > sx) {
              for (int i = sx; i < shipx + 1; i++) {
                p1[sy][i] = 1;
              }
            }
          } else if (shipy != sy && shipx == sx) {
            if (shipy < sy) {
              for (int i = shipy; i < sy + 1; i++) {
                p1[i][sx] = 1;
              }
            }
            if (shipy > sy) {
              for (int i = sy; i < shipy + 1; i++) {
                p1[i][sx] = 1;
              }
            }
            
          }
        } else {
          frame = 0;
          error = true;
          lockinput = true;
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
}
void setup2K() {
  if (!lockinput) {
    if (key == CODED) {
      if (!startplace) {
        if (keyCode == LEFT) {
          shipmode--;
          if (shipmode < 0) {
            shipmode = 4;
          }
          while (!shipavail2[shipmode]) {
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
          while (!shipavail2[shipmode]) {
            shipmode++;
            if (shipmode > 4) {
              shipmode = 0;
            }
          }
        }
      }
    }
    if (keyCode == ' ') {
      if (!startplace) {
        startplace = true;
        shipx = crs2x;
        shipy = crs2y;
      } else {
        startplace = false;
        if (checkAvailable2(crs2x, crs2y)) {
          ships2[placedships] = new Ship(shipx, crs2x, shipy, crs2y);
          placedships++;
          shipavail2[shipmode] = false;
          while (!shipavail2[shipmode] && placedships < 5) {
            shipmode++;
            if (shipmode > 4) {
              shipmode = 0;
            }
          }
          int sx = crs2x;
          int sy = crs2y;
          if (shipx != sx && shipy == sy) {
            if (shipx < sx) {
              for (int i = shipx; i < sx + 1; i++) {
                p2[sy][i] = 1;
              }
            }
            if (shipx > sx) {
              for (int i = sx; i < shipx + 1; i++) {
                p2[sy][i] = 1;
              }
            }
          } else if (shipy != sy && shipx == sx) {
            if (shipy < sy) {
              for (int i = shipy; i < sy + 1; i++) {
                p2[i][sx] = 1;
              }
            }
            if (shipy > sy) {
              for (int i = sy; i < shipy + 1; i++) {
                p2[i][sx] = 1;
              }
            }
            
          }
        } else {
          frame = 0;
          error = true;
          lockinput = true;
        }
      }
    }
    if (key == 'W' || key == 'w') {
      blinkframe = 0;
      crs2y--;
      if (crs2y < 0) {
        crs2y = 9;
      }
    }
    if (key == 'S' || key == 's') {
      blinkframe = 0;
      crs2y++;
      if (crs2y > 9) {
        crs2y = 0;
      }
    }
    if (key == 'A' || key == 'a') {
      blinkframe = 0;
      crs2x--;
      if (crs2x < 0) {
        crs2x = 9;
      }
    }
    if (key == 'D' || key == 'd') {
      blinkframe = 0;
      crs2x++;
      if (crs2x > 9) {
        crs2x = 0;
      }
    }
  }
}

// need to add see if is taken by other boat
boolean checkAvailable1(int sx, int sy) {
  int dx = abs(sx - shipx);
  int dy = abs(sy - shipy);
  if (shipmode < 3) {
    if (!(4 - shipmode == dx+dy)) {
      return false;
    }
  } else {
    if (!(5 - shipmode == dx+dy)) {
      return false;
    }
  }

  if (shipx != sx && shipy == sy) {
    if (shipx < sx) {
      for (int i = shipx; i < sx + 1; i++) {
        if (p1[sy][1] != 0) {
          return false;
        }
      }
    }
    if (shipx > sx) {
      for (int i = sx; i < shipx + 1; i++) {
        if (p1[sy][1] != 0) {
          return false;
        }
      }
    }
    return true;
  } else if (shipy != sy && shipx == sx) {
    if (shipy < sy) {
      for (int i = shipy; i < sy + 1; i++) {
        if (p1[i][sx] != 0) {
          return false;
        }
      }
    }
    if (shipy > sy) {
      for (int i = sy; i < shipy + 1; i++) {
        if (p1[i][sx] != 0) {
          return false;
        }
      }
    }
    return true;
  } else {
    return false;
  }
  
}

boolean checkAvailable2(int sx, int sy) {
  int dx = abs(sx - shipx);
  int dy = abs(sy - shipy);
  if (shipmode < 3) {
    if (!(4 - shipmode == dx+dy)) {
      return false;
    }
  } else {
    if (!(5 - shipmode == dx+dy)) {
      return false;
    }
  }

  if (shipx != sx && shipy == sy) {
    if (shipx < sx) {
      for (int i = shipx; i < sx + 1; i++) {
        if (p2[sy][i] != 0) {
          return false;
        }
      }
    }
    if (shipx > sx) {
      for (int i = sx; i < shipx + 1; i++) {
        if (p2[sy][i] != 0) {
          return false;
        }
      }
    }
    return true;
  } else if (shipy != sy && shipx == sx) {
    if (shipy < sy) {
      for (int i = shipy; i < sy + 1; i++) {
        if (p2[i][sx] != 0) {
          return false;
        }
      }
    }
    if (shipy > sy) {
      for (int i = sy; i < shipy + 1; i++) {
        if (p2[i][sx] != 0) {
          return false;
        }
      }
    }
    return true;
  } else {
    return false;
  }
}
