void end(){
  if(winner == 1){
    background(#FF6961);
  }else{
    background(#AEC6FF);
  }
  textSize(64);
  text("P" + winner + " wins!", width/2, height/3);
  textSize(32);
  text("Reason: " + winreason , width/2, height/2);
  
}
void endK(){
  removeballs();
  initializevar();
  mode = 0;
  exit();
}
void removeballs(){
  
}
