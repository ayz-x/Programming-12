void end(){
  background(255);
  textSize(30);
  fill(0);
  if(p1win && p2win){
    text("Tie, both sides all sunk on same turn", 250, 400);
  }else if(p1win){
    text("P1 Win", 350, 400);
  }else if(p2win){
    text("P2 Win", 350, 400);
  }
}
void endK(){
  variablereset();
  mode = 0;
}
