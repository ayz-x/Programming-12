String[][] world = new String[41][41];
void generateEmpty(int w, int h) {
  noiseDetail(8,0.7); 
  float offx = random(0,10000);
  float offz = random(0,10000);
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      if (i == 0 || i == h-1) {
        world[i][j] = "w7"; 
      } else if (j == 0 || j == w-1) {
        world[i][j] = "w7";
      } else {
        world[i][j] = "g" + ceil(3.5*noise(i/2 + offx,0,j/2 + offz));
      }
    }
    println();
  }
  
}
