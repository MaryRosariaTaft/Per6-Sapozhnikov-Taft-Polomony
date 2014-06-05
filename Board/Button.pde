import java.io.*;
import java.util.*;

class Button{
  
  color c;
  int x;
  int y;
  
    //used when a person has to decide whether to purchase property
    //and only appear in the popup when Yes/No has to be answered
    //call draw when person lands on Square whose owner==null
  
    String text;
  
    Button(){
    
    }
  
    Button(String text, color c, int x, int y){
	this.text=text;
        this.c=c;
        this.x=x;
        this.y=y;
    }
  
    void draw(){
	ellipse(x,y,50,50);//fix
        fill(c);
	//print "Yes" or "No" (or whatever is necessary) centered in the ellipse
	//if it's clicked, do stuff: mousePressed()?
    }
  
}
