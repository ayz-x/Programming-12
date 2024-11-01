ArrayList<Mover> movers = new ArrayList<>();
void setup() {
  frameRate(144);
  fill(255);
  size(800, 800, P3D);
  for (int i = 0; i < 0; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float z = random(0);
    PVector r = new PVector(x, y, z);
    PVector v = PVector.random3D();
    movers.add(new Mover(r, v, 10));
  }
}

void draw() {
  noStroke();
  background(255);
  for (int i = 0; i < movers.size(); i++) {

    Mover current = movers.get(i);
    current.act();
    current.show();
    for (int j = 0; j < movers.size(); j++) {
      current.showConnections(movers.get(j));
    }
  }
}

void mouseReleased() {
  PVector r = new PVector(mouseX, mouseY, 0);
  movers.add(new Mover(r, PVector.random3D(), 10));
}
void keyPressed() {
  if(key == 'r' || key == 'R'){
    movers.clear();
  }
  if (keyCode == BACKSPACE) {
    if (movers.size() > 0) {
      movers.remove(0);
    }
  }
  if (key == ' ') {
    float x = random(0, width);
    float y = random(0, height);
    float z = random(0);
    PVector r = new PVector(x, y, z);
    movers.add(new Mover(r, PVector.random3D(), 10));
  }
}
