import java.io.*;
import java.util.*;

class Die {
  int x, y, s, r;
  int roll;

  Die() {
  }
  Die(int x, int y) {
    this.x=x;
    this.y=y;
    s=20;
    r=7;
    roll=1;
  }

  public int roll() {
    Random r=new Random();
    roll = r.nextInt(6)+1;
    draw();
    return roll;
  }

  void mouseClicked() {
    canRoll=false;
    setMessage("");
    println("dice rolled");
    //println("Can you roll the dice? "+canRoll);
    players.getCurrent().newTurn();
    //      canRoll=false;
    //      setMessage("");
  }

  void draw() {
    fill(#FFFFFF);
    rect(x, y, 20, 20, 7);
    fill(#000000);
    switch(roll) {
    case 1:
      draw1();
      break;
    case 2: 
      draw2();
      break;
    case 3:
      draw3();
      break;
    case 4: 
      draw4();
      break;
    case 5:
      draw5();
      break;
    case 6: 
      draw6();
      break;
    }
    
//    if (roll!=0) {
//      fill(#0000FF);
//      text(roll, x+s/2-5, y+s/2+5);
//    }
  }

  void draw1() {
    ellipse(x+s/2.0, y+s/2.0, 3, 3);
  }
  void draw2() {
    ellipse(x+s/4.0, y+s/4.0, 3, 3);
    ellipse(x+3*s/4.0, y+3*s/4.0, 3, 3);
  }
  void draw3(){
    draw1();
    draw2();
  }
  void draw4(){
    draw2();
    ellipse(x+s/4.0, y+3*s/4.0, 3, 3);
    ellipse(x+3*s/4.0, y+s/4.0, 3, 3);
  }
  void draw5(){
    draw1();
    draw4();
  }
  void draw6(){
    draw4();
    ellipse(x+s/4.0, y+s/2.0, 3, 3);
    ellipse(x+3*s/4.0, y+s/2.0, 3, 3);
  }

  public int leftX() {
    return x;
  }
  public int rightX() {
    return x+s;
  }
  public int topY() {
    return y;
  }
  public int bottomY() {
    return y+s;
  }
}

