import java.io.*;
import java.util.*;

class Die{
    int x,y,s,r;
    int roll;
    
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
	roll = r.nextInt(6)+1;
        draw();
        return roll;
    }
    
    void mouseClicked(){
      println("dice rolled");
      players.getCurrent().newTurn();
      canRoll=false;
      setMessage("");
    }
    
    void draw(){
      fill(#FFFFFF);
      rect(x,y,20,20,7);
      if (roll!=0){
        fill(#0000FF);
        text(roll,x+s/2,y+s/2);
      }
    }
    
    public int leftX(){return x;}
    public int rightX(){return x+s;}
    public int topY(){return y;}
    public int bottomY(){return y+s;}

}
