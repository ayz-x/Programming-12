import java.io.BufferedReader;
import java.io.FileReader;
import java.util.StringTokenizer;

class Map {
  String[][] m = new String[41][41];
  Map(String f) {
    BufferedReader input = createReader(f);
    String line = null;
    try {
      int j = 0;
      while ((line = input.readLine()) != null) {
        StringTokenizer st = new StringTokenizer(line);

        for (int i = 0; i < floor(line.length()/3); i++) {
          
          m[i][j] = st.nextToken();
        }
        j++;
      }
    }

    catch(IOException e) {
      e.printStackTrace();
    }
  }
  
  Map(String[][] f){
    for(int i = 0; i < f.length; i++){
      for(int j = 0; j < f[0].length; j++){
        m[i][j] = f[i][j];
      }
    }
  }



  String[][] getMap() {
    return m;
  }
  /*
  1 - norm
   2 - lava
   */

  void addtoWorld() {
    for (int i = 0; i < 41; i++) {
      for (int j = 0; j < 41; j++) {
        char firstDigit = m[i][j].charAt(0);
        int secondDigit = Integer.parseInt(m[i][j].substring(1));

        switch(firstDigit) {
        case 'w':
          wall(i*100, j*100, secondDigit);
          break;
        case 'g':
          grass(i*100, j*100, secondDigit);
        default:
          break;
        }
      }
    }
  }


  void wall(int x, int z, int n) {
    for (int i = 0; i < n; i++) {
      drawCube(x, i*100, z, bricks, bricks, bricks, bricks, bricks, bricks);
      terrain[x/100][i][z/100] = true;
    }
  }
  void grass(int x, int z, int n) {
    for (int i = 0; i < n - 1; i++) {
      drawCube(x, i*100, z, dirt, dirt, dirt, dirt, dirt, dirt);
      terrain[x/100][i][z/100] = true;
    }
    drawCube(x, (n-1)*100, z, grasst, dirt, grasss, grasss, grasss, grasss);
    terrain[x/100][n-1][z/100] = true;
  }
}
