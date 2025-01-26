float buffer = 3;
float rbuffer = 1;
ArrayList<Snowball> snowballs = new ArrayList<>();
class Snowball {
  float x, y, z, t, p;
  float vx, vy, vz;
  float accel;
  float nx, ny, nz;

  public Snowball(float x, float y, float z, float theta, float phi) {
    this.x=x;
    this.y=y;
    this.z=z;
    t = theta; // xy plane rotation
    p = phi; // rotation between xy plane and z axis
    vz = sin(t)*cos(p)*100;
    vx = cos(t)*cos(p)*100;
    vy = sin(p)*100;
    accel = 2;
  }
  void act() {
    vy -= accel;
    nx = x + vx*buffer;
    ny = y + vy*buffer;
    nz = z + vz*buffer;
    x += vx;
    y += vy;
    z += vz;

    pushMatrix();
    translate(x, y, z);
    rotateY(theta);
    scale(50);
    box(0.5);
    popMatrix();
  }
  boolean collide() {
    if (round(nx/100) > 40 || round(nx/100) < 0 ||
      round(nz/100) > 40 || round(nz/100) < 0 ||
      round(ny/100) > 18 || round(nz/100) < 0) {
      return true;
    }
    if (terrain[round(nx/100)][round(ny/100)][round(nz/100)]) {
      explode();
      return true;
    }



    return false;
  }

  void explode() {
    int amount = ceil(random(5, 20));
    for (int i = 0; i < amount; i++) {
      residues.add(new Residue(x, y, z));
    }
  }
}


ArrayList<Residue> residues = new ArrayList<>();
class Residue {
  float x, y, z, t, p;
  float vx, vy, vz;
  float nx, ny, nz;
  float accel;
  int timer;
  float size;
  public Residue(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
    t = random(0, 2*PI);
    p = random(0, 2*PI);
    vz = sin(t)*cos(p)*30;
    vx = cos(t)*cos(p)*30;
    vy = sin(p)*30;
    accel = 2;
    timer = 0;
    size = 0.2;
  }
  void act() {
    nx = x + vx*rbuffer;
    ny = y + vy*rbuffer;
    nz = z + vz*rbuffer;
    vy -= accel;
    x += vx;
    y += vy;
    z += vz;
    pushMatrix();
    translate(x, y, z);
    rotateY(theta);
    scale(50);
    box(size);
    popMatrix();
    try {
      if (round(nx/100) > 40 || round(nx/100) < 0 ||
        round(nz/100) > 40 || round(nz/100) < 0 ||
        round(ny/100) > 18 || round(nz/100) < 1) {
        accel = 0;
        vx = 0;
        vy = 0;
        vz = 0;
        timer = 144;
      } else if (terrain[round(nx/100)][round(ny/100)][round(nz/100)]) {
        accel = 0;
        vx = 0;
        vy = 0;
        vz = 0;
        timer++;
      }
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  boolean timing() {
    if (timer > 0) {
      timer++;
      size = map(size, 0, 120, 0.2, 0);
    }
    if (timer > 120) {
      return true;
    }
    return false;
  }
}
