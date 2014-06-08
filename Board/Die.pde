import java.io.*;
import java.util.*;

class Die{
    int x,y,s,r;
    
    Die(){

    }
    Die(int x, int y){
      this.x=x;
      this.y=y;
      s=20;
      r=7;
    }

    public int roll(){
	Random r=new Random();
	return r.nextInt(6)+1;
    }
    
    void mouseClicked(){
      println("dice rolled");
      players.getCurrent().newTurn();
      canRoll=false;
      cp5.remove("messages");
    }
    
    void draw(){
      fill(#FFFFFF);
      rect(x,y,20,20,7);
    }
    
    public int leftX(){return x;}
    public int rightX(){return x+s;}
    public int topY(){return y;}
    public int bottomY(){return y+s;}

}
