class Button{
  
  //used when a person has to decide whether to purchase property
  //and only appear in the popup when Yes/No has to be answered
  //call draw when person lands on Square whose owner==null
  
  String text;
  
  Button(){
    
  }
  
  Button(String text){
    this.text=text;
  }
  
  void draw(){
    ellipse(50,50,0,0);//fix
    //print "Yes" or "No" (or whatever is necessary) centered in the ellipse
    //if it's clicked, do stuff: mousePressed()?
  }
  
}
