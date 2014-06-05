import java.io.*;
import java.util.*;

class Button {

  String text;
  color c;
  int x;
  int y;
  boolean clicked=false;

  //used when a person has to decide whether to purchase property
  //and only appear in the popup when Yes/No has to be answered
  //call draw when person lands on Square whose owner==null

  Button() {
    
  }

  Button(String text, color c, int x, int y) {
    this.text=text;
    this.c=c;
    this.x=x;
    this.y=y;
    //frameRate(1);
  }

  void draw() {
    //println("in draw of "+text);
    if(!clicked){
      //println("in 'if' of "+text);
      ellipse(x, y, 50, 50);
      fill(c);
    }else{
      //println(text+"'s click was registered in draw()");
    }
  }

  void mouseClicked() {
    //println("click was sensed in "+text);
    clicked=true;
  }

  boolean clicked() {
    //println("calling clicked() boolean in "+text);
    return clicked;
  }
}

