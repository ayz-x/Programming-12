int mode = 1;
void setup() {
  frameRate(144);
  size(600, 600);
  colorMode(HSB);
  for (int i = 0; i < n; i++) {
    sizes[i] = random(10, 100);
    colors[i] = color(random(0,255),random(100,255),255);
    movers[i] = new Mover(random(100, 500), random(100, 500));
  }
  noStroke();
}
int n = 200;
Mover[] movers = new Mover[n];
color[] colors = new color[n];
float[] sizes = new float[n];
void draw() {
  background(0);
  for (int i = 0; i < n; i++) {
    movers[i].act();
    switch(mode) {
    case 1:
      fill(colors[i]);
      movers[i].show(50);
      break;         
    case 2:
      fill(color(random(0, 255), random(100, 255), 255));
      movers[i].show(50);
      break;
    case 3:
      fill(255);
      movers[i].show(sizes[i]);
      break;
    case 4:
      fill(255);
      movers[i].show(random(10, 100));
      break;
    case 5:
      fill(colors[i]);
      movers[i].show(sizes[i]);
    case 6:
      fill(color(random(0, 255), random(100, 255), 255));
      movers[i].show(sizes[i]);
    case 7:
      fill(colors[i]);
      movers[i].show(random(10, 100));
    case 8:
      fill(color(random(0, 255), random(100, 255), 255));
      movers[i].show(random(10, 100));
    default:
      fill(0);
      break;
    }
  }
}
void keyPressed() {
  mode++;
  if (mode > 8) {
    mode = 1;
  }
}
