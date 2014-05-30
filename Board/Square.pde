import java.io.*;
import java.util.*;

class Square{
  
    private String name;
    private int cost;
    private int x,y,w,h;
    private color c;
    private int numHouses;
    private boolean hasHotel;
    private Person owner;

    Square(){
      
    }
    
    Square(int x, int y, int w, int h, color c, String name, int cost){
      this.x=x;
      this.y=y;
      this.w=w;
      this.h=h;
      this.c=c;
      this.name=name;
      this.cost=cost;
      numHouses=0;
      hasHotel=false;
      owner=null;
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
    
    int getCost(){
     return cost; 
    }
    
    String getName(){
     return name; 
    }
    
    String toString(){
     return getName(); 
    }
}
