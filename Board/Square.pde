import java.io.*;
import java.util.*;

class Square{
  
    private String name;
    private int cost;
    private int x,y,w,h;
    private color c;

    Square(){
      
    }
    
    Square(int x, int y, int w, int h, color c, String name){
      this.x=x;
      this.y=y;
      this.w=w;
      this.h=h;
      this.c=c;
      this.name=name;
    }

    int rent(){
      return 100;
    }
    
    void draw(){
      fill(c);
      rect(x,y,w,h);
    }

    color getColor(){
      return c;
    }
    
    String getName(){
     return name; 
    }
}
