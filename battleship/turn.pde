boolean gridmode1 = false; //false is yourself, true is enemy
boolean gridmode2 = false;
boolean endturn = false;
int turnnum = 0;
boolean p1win = false;
boolean p2win = false;
boolean miss = false;
void p1turn() {
  blinkframe++;
  
  if (!miss && !p1win) {
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
  textSize(32);
  if (!gridmode1) {
    text("YOU", 370, 850);
    for (int i = 0; i < 5; i++) {
      fill(200);
      Ship ship = ships1[i];
      float sx1 = ship.x1;
      float sx2 = ship.x2;
      float sy1 = ship.y1;
      float sy2 = ship.y2;
      boolean sunk = ship.sunk;
      if(sunk){
        fill(100);
      }else{
        fill(200);
      }

      if (sy1 == sy2) { // horizontal
        ellipse(((sx1 + sx2)/2) * 80 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
      } else { // vertical
        ellipse(sx1 * 80 + 40, ((sy1 + sy2)/2)*80 + 40, 65, abs(sy1-sy2)*80+40);
      }
    }

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        switch(p1[i][j]) {
        case 2:
          fill(0, 0, 255);
          circle(j*80+40, i*80+40, 80);
          break;
        case 3:
          fill(255, 0, 0);
          circle(j*80+40, i*80+40, 80);
        default:
          break;
        }
      }
    }
  } else {
    text("ENEMY", 350, 850);

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {

        if (p2[i][j] == 2) {
          fill(0, 0, 150);
          circle(j*80+40, i*80+40, 70);
        }
        if (p2[i][j] == 3) {
          fill(255, 0, 0);
          circle(j*80+40, i*80+40, 70);
        }
      }
    }
    //ship and shipsinking
    for (int k = 0; k < 5; k++) {
      fill(200);
      Ship ship = ships2[k];
      int sx1 = ship.x1;
      int sx2 = ship.x2;
      int sy1 = ship.y1;
      int sy2 = ship.y2;
      boolean sunk = ship.sunk;
      if (sunk) {
        fill(100);
        if (sy1 == sy2) { // horizontal
          ellipse((sx1 + sx2)* 40 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
        } else { // vertical
          ellipse(sx1 * 80 + 40, (sy1 + sy2)*40 + 40, 65, abs(sy1-sy2)*80+40);
        }
      }else{
        if(checkSunk1(ship)){
          ships2[k].sunk = true;
          if (sx1 != sx2 && sy1 == sy2) {
            if (sx1 < sx2) {
              for (int i = sx1; i < sx2 + 1; i++) {
                p2[sy1][i] = 4;
              }
            }
            if (sx1 > sx2) {
              for (int i = sx2; i < sx1 + 1; i++) {
                p2[sy1][i] = 4;
              }
            }
          } else if (sy1 != sy2 && sx1 == sx2) {
            if (sy1 < sy2) {
              for (int i = sy1; i < sy2 + 1; i++) {
                p2[i][sx1] = 4;
              }
            }
            if (sy1 > sy2) {
              for (int i = sy2; i < sy1 + 1; i++) {
                p2[i][sx1] = 4;
              }
            }
            
          }
        }
      }
      
      
    }
   
  }
  
  
  boolean allsunk = true;
  for(int i = 0; i < 5; i++){
    if(!ships2[i].sunk){
      allsunk = false;
      
    }
  }
  if(allsunk){
    if(!p1win){
      frame = 0;
    }
    p1win = true;
  }

  //crosshair
  if (blinkframe%50 < 25) {
    pushMatrix();
    translate(crs1x*80+40, crs1y*80+40);
    line(-20, 0, 20, 0);
    line(0, -20, 0, 20);
    popMatrix();
  }
  
  fill(100);
  textSize(30);
  if (p1win) {
    text("You have sunk all ships", 300, 400);
    if(frame > 100){
      mode = 4;
      lockinput = false;
    }
    
  }
  if (miss) {
    text("Missed, transferring to p2", 290, 400);
    if (frame > 100) {
      mode = 4;
      miss = false;
      lockinput = false;
    }
  }
  
}
void p2turn() {
  blinkframe++;
  
  if (!miss && !p2win) {
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
  textSize(32);
  if (!gridmode2) {
    text("YOU", 370, 850);
    for (int i = 0; i < 5; i++) {
      fill(200);
      Ship ship = ships2[i];
      float sx1 = ship.x1;
      float sx2 = ship.x2;
      float sy1 = ship.y1;
      float sy2 = ship.y2;
      boolean sunk = ship.sunk;
      if(sunk){
        fill(100);
      }else{
        fill(200);
      }

      if (sy1 == sy2) { // horizontal
        ellipse(((sx1 + sx2)/2) * 80 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
      } else { // vertical
        ellipse(sx1 * 80 + 40, ((sy1 + sy2)/2)*80 + 40, 65, abs(sy1-sy2)*80+40);
      }
    }

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        switch(p2[j][i]) {
        case 2:
          fill(0, 0, 255);
          circle(i*80+40, j*80+40, 80);
          break;
        case 3:
          fill(255, 0, 0);
          circle(i*80+40, j*80+40, 80);
        default:
          break;
        }
      }
    }
  } else {
    text("ENEMY", 350, 850);

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {

        if (p1[i][j] == 2) {
          fill(0, 0, 150);
          circle(j*80+40, i*80+40, 70);
        }
        if (p1[i][j] == 3) {
          fill(255, 0, 0);
          circle(j*80+40, i*80+40, 70);
        }
      }
    }
    //ship and shipsinking
    for (int k = 0; k < 5; k++) {
      fill(200);
      Ship ship = ships1[k];
      int sx1 = ship.x1;
      int sx2 = ship.x2;
      int sy1 = ship.y1;
      int sy2 = ship.y2;
      boolean sunk = ship.sunk;
      if (sunk) {
        fill(100);
        if (sy1 == sy2) { // horizontal
          ellipse((sx1 + sx2)* 40 + 40, sy1*80 + 40, abs(sx1-sx2)*80+40, 65);
        } else { // vertical
          ellipse(sx1 * 80 + 40, (sy1 + sy2)*40 + 40, 65, abs(sy1-sy2)*80+40);
        }
      }else{
        if(checkSunk2(ship)){
          ships1[k].sunk = true;
          if (sx1 != sx2 && sy1 == sy2) {
            if (sx1 < sx2) {
              for (int i = sx1; i < sx2 + 1; i++) {
                p1[sy1][i] = 4;
              }
            }
            if (sx1 > sx2) {
              for (int i = sx2; i < sx1 + 1; i++) {
                p1[sy1][i] = 4;
              }
            }
          } else if (sy1 != sy2 && sx1 == sx2) {
            if (sy1 < sy2) {
              for (int i = sy1; i < sy2 + 1; i++) {
                p1[i][sx1] = 4;
              }
            }
            if (sy1 > sy2) {
              for (int i = sy2; i < sy1 + 1; i++) {
                p1[i][sx1] = 4;
              }
            }
            
          }
        }
      }
      
      
    }
   
  }
  
  
  boolean allsunk = true;
  for(int i = 0; i < 5; i++){
    if(!ships1[i].sunk){
      allsunk = false;
      
    }
  }
  if(allsunk){
    if(!p2win){
      frame = 0;
    }
    p2win = true;
  }

  //crosshair
  if (blinkframe%50 < 25) {
    pushMatrix();
    translate(crs2x*80+40, crs2y*80+40);
    line(-20, 0, 20, 0);
    line(0, -20, 0, 20);
    popMatrix();
  }
  
  fill(100);
  textSize(30);
  if (p2win) {
    text("You have sunk all ships", 300, 400);
    if(frame > 100){
      mode = 7;
      lockinput = false;
    }
    
  }
  if (miss) {
    text("Missed, transferring to p1", 290, 400);
    if (frame > 100) {
      mode = 3;
      miss = false;
      lockinput = false;
    }
  }
  
}

void p1turnK() {
  if (key == CODED) {
    if (keyCode == LEFT || keyCode == RIGHT) {
      gridmode1 = !gridmode1;
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
  if (gridmode1 && !miss) {
    if (key == ' ') {
      if (p2[crs1y][crs1x] == 0) {
        p2[crs1y][crs1x] = 2;
        frame = 0;
        lockinput = true;
        miss = true;
      }
      if (p2[crs1y][crs1x] == 1) {
        p2[crs1y][crs1x] = 3;
      }
    }
  }
}
void p2turnK() {
  if (key == CODED) {
    if (keyCode == LEFT || keyCode == RIGHT) {
      gridmode2 = !gridmode2;
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
  if (gridmode2 && !miss) {
    if (key == ' ') {
      if (p1[crs2y][crs2x] == 0) {
        p1[crs2y][crs2x] = 2;
        frame = 0;
        lockinput = true;
        miss = true;
      }
      if (p1[crs2y][crs2x] == 1) {
        p1[crs2y][crs2x] = 3;
      }
    }
  }
}

boolean checkSunk1(Ship ship){
  int shipx = ship.x1;
  int shipy = ship.y1;
  int sx = ship.x2;
  int sy = ship.y2;
  if (shipx != sx && shipy == sy) {
    if (shipx < sx) {
      for (int i = shipx; i < sx + 1; i++) {
        if (p2[sy][i] != 3) {
          return false;
        }
      }
    }
    if (shipx > sx) {
      for (int i = sx; i < shipx + 1; i++) {
        if (p2[sy][i] != 3) {
          return false;
        }
      }
    }
    return true;
  } else if (shipy != sy && shipx == sx) {
    if (shipy < sy) {
      for (int i = shipy; i < sy + 1; i++) {
        if (p2[i][sx] != 3) {
          return false;
        }
      }
    }
    if (shipy > sy) {
      for (int i = sy; i < shipy + 1; i++) {
        if (p2[i][sx] != 3) {
          return false;
        }
      }
    }
    return true;
  }
  return false;
}

boolean checkSunk2(Ship ship){
  int shipx = ship.x1;
  int shipy = ship.y1;
  int sx = ship.x2;
  int sy = ship.y2;
  if (shipx != sx && shipy == sy) {
    if (shipx < sx) {
      for (int i = shipx; i < sx + 1; i++) {
        if (p1[sy][i] != 3) {
          return false;
        }
      }
    }
    if (shipx > sx) {
      for (int i = sx; i < shipx + 1; i++) {
        if (p1[sy][i] != 3) {
          return false;
        }
      }
    }
    return true;
  } else if (shipy != sy && shipx == sx) {
    if (shipy < sy) {
      for (int i = shipy; i < sy + 1; i++) {
        if (p1[i][sx] != 3) {
          return false;
        }
      }
    }
    if (shipy > sy) {
      for (int i = sy; i < shipy + 1; i++) {
        if (p1[i][sx] != 3) {
          return false;
        }
      }
    }
    return true;
  }
  return false;
}
