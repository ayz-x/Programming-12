boolean doublejump = true;
boolean jumpable = false;
boolean doublejumpavail = true;
boolean wreleased = true;
float prevVeloY = 0;
boolean w = false;
boolean a, s, d, space;
int xfacing = 1;
int yfacing = 1;
boolean touchinglava;
int yfacingbeforelava = 0;
int iframes = 0;
boolean iteriframe;
boolean inair = false;
int runsprite;
int idlesprite;
int spriteframe;
boolean next = false;
int guns = 0;
int currgun = 0;
int gunframe = 0;
boolean shootcd = false;
float screenx, screeny;
boolean end;

class FPlayer extends FBox {
  float ay;
  FPlayer() {
    super(playerSizeX, playerSizeY);
    setPosition(400, 0);
    setFillColor(#000000);
    ay = 0;
  }
  void updateSprite() {
    //println(player.getVelocityX(), player.getVelocityY());
    if (player.getVelocityX() > 50) {
      xfacing = 1;
    }
    if (player.getVelocityX() < -50) {
      xfacing = -1;
    }
    spriteframe++;
    if (inair) {
      //air
      if (xfacing > 0) {
        attachImage(prj);
      } else {
        attachImage(plj);
      }
    } else {
      if (abs(getVelocityX()) > 50) {
        //run
        idlesprite = 0;
        if (spriteframe % 4 == 0) {
          runsprite ++;
          if (runsprite > 2) {
            runsprite = 0;
          }
        }
        if (xfacing > 0) {
          attachImage(prr[runsprite]);
        } else {
          attachImage(prl[runsprite]);
        }
      } else {
        //idle
        runsprite = 0;
        if (spriteframe % 48 == 0) {
          idlesprite ++;
          if (idlesprite > 1) {
            idlesprite = 0;
          }
        }
        if (xfacing > 0) {
          attachImage(pi[idlesprite]);
        } else if (xfacing < 0) {
          attachImage(reverseImage(pi[idlesprite]));
        }
      }
    }
  }

  void checkTouching() {
    if (istouching(this, "kill")) {
      die = true;
    }
    if (istouching(this, "enemy")) {
      die = true;
    }
    if (istouching(this, "portal")) {
      if (currmap < nummaps-1) {
        next = true;
        loadNextMap(currmap);
      } else {
        end = true;
      }
    }
    if (istouching(this, "g1")) {
      world[currmap].remove(gun);
      guns = 1;
    }
    if (istouching(this, "g2")) {
      world[currmap].remove(gun);
      guns = 2;
    }
  }
  void updatePlayerPos() {
    this.setRotatable(false);

    this.setRotation(0);
    ay = (this.getVelocityY()-prevVeloY)/freq;
    //println(doublejumpavail);
    if (abs(ay) < 10) {
      jumpable = false;
      doublejump = true;
      doublejumpavail = true;
      inair = false;
    } else {
      inair = true;
    }

    if (w && abs(ay) <10 ) {

      this.setVelocity(this.getVelocityX(), -300);
      this.setRotation(0);
    } else if (w && doublejumpavail) {

      this.setVelocity(this.getVelocityX(), -300);
      doublejumpavail = false;
    }

    if (a) {
      float newvelo = this.getVelocityX()- 20;
      if (newvelo < -100) {
        newvelo = -200;
      }
      this.setVelocity(newvelo, this.getVelocityY());
      this.setRotation(0);
    }
    if (d) {
      float newvelo = this.getVelocityX() + 20;
      if (newvelo > 100) {
        newvelo = 200;
      }
      this.setVelocity(newvelo, this.getVelocityY());
      this.setRotation(0);
    }
    if (s) {
      this.addImpulse(0, 50);
    }
    prevVeloY = this.getVelocityY();
    this.setRotation(0);
    w = false;


    //gun code
    float deltax = mouseX - screenx;
    float deltay = mouseY - screeny;
    float radius = sqrt(sq(mouseY-getY()) + sq(mouseX-getX()));
    float theta = atan2(deltay, deltax);
    int cd = 72;

    if (currgun == 1) {
      if (cheatmode) {
        cd = 1;
      } else {
        cd = 72;
      }
      if (!shootcd && space) {


        FBullet bullet = new FBullet();
        bullet.setPosition(player.getX() + cos(theta)*5, player.getY() + sin(theta)*5);
        bullet.setVelocity(cos(theta)*1000, sin(theta)*1000);
        bullet.setBullet(true);
        bullets.add(bullet);
        bullet.setRestitution(0.8);
        world[currmap].add(bullet);
        shootcd = true;
      }
    }

    for (int i = 0; i < bullets.size(); i++) {
      FBullet bullet = bullets.get(i);
      if (istouching(bullet, "enemy")) {
        world[currmap].remove(bullets.get(i));
        bullets.remove(bullets.get(i));
        i--;
        continue;
      } else if (abs(bullet.getVelocityX()) + abs(bullet.getVelocityY()) < 100) {
        world[currmap].remove(bullets.get(i));
        bullets.remove(bullets.get(i));
        i--;
        continue;
      }

      if (!bullet.getTouching().isEmpty()) {
        bullet.bounces --;
      }
      if (bullet.bounces < 1) {
        world[currmap].remove(bullets.get(i));
        bullets.remove(bullets.get(i));
        i--;
        continue;
      }
    }

    if (currgun == 2) {
      if (cheatmode) {
        cd = 1;
      } else {
        cd = 288;
      }
      if (!shootcd && space) {


        FRocket bullet = new FRocket();
        bullet.setPosition(player.getX() + cos(theta)*5, player.getY() + sin(theta)*5);
        bullet.setRotation(theta + PI/2);
        bullet.setVelocity(cos(theta)*500, sin(theta)*500);
        bullet.setBullet(true);
        rockets.add(bullet);
        bullet.setRestitution(0.8);
        world[currmap].add(bullet);
        shootcd = true;
      }
    }
    
    if (shootcd) {
      gunframe++;
      if (gunframe > cd) {
        gunframe = 0;
        shootcd = false;
      }
    }

    for (int i = 0; i < rockets.size(); i++) {
      FRocket bullet = rockets.get(i);
      if (!bullet.getTouching().isEmpty() && !istouching(bullet, "player") && !istouching(bullet, "explosion")) {
        bullet.bounces --;
      }
      if (bullet.bounces < 1) {
        world[currmap].remove(bullet);
        bullet.initiatecontact();
        bullet.act();
        if (bullet.explosionframe > 288) {
          
          rockets.remove(bullet);
          
          i--;
        }
        continue;
      }
    }
  }
}




void playerinputs() {

  if (key == '0') {
    currgun = 0;
  }
  if (key == '1' && guns > 0) {
    currgun = 1;
  }
  if (key == '2' && guns > 1) {
    currgun = 2;
  }
  if (key == ' ') {
    space = true;
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
}

void negplayerinputs() {
  if (key == 'W' || key == 'w') {
    w = false;
    wreleased = true;
    jumpable = true;
  }
  if (key == ' ') {
    space = false;
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
}
void jump() {
  if (key == 'W' || key == 'w') {
    w = true;
  }
}
