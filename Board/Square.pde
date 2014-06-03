import java.io.*;
import java.util.*;

class Square{
  
    private String name;
    private int cost;
    private int x,y,w,h;
    private color c;
    private PImage img;
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
      img=null;
    }
    Square(int x, int y, int w, int h, PImage img, String name, int cost){
      this.x=x;
      this.y=y;
      this.w=w;
      this.h=h;
      this.c=color(#ffffff);
      this.name=name;
      this.cost=cost;
      numHouses=0;
      hasHotel=false;
      owner=null;
      this.img = img;
      //println("image square");
    }

    boolean isRR(){
     return name.contains("Railroad");
    }
    boolean isUtil(){
      return name.equals("Electric Company") || name.equals("Water Works");
    }
    
    int rent(){
      return 100;
    }
    
    void draw(){
      if(img==null){
        fill(c);
        rect(x,y,w,h);
      } else{
        //hides the black border around the square. 
        //we need to either change the size of the image by 1 pixel on the top or replace the edges with black
        image(img,x,y);
      }
    }

    color getColor(){
      return c;
    }
    
    int getCost(){
     return cost; 
    }
    
    int getX(){
      return x;
    }
    
    int getY(){
     return y; 
    }
    
    int getNumHouses(){
      return numHouses;
    }
    boolean getHasHotel(){
      return hasHotel;
    }
    
    String getName(){
     return name; 
    }
    
    Person getOwner(){
     return owner; 
    }
    
    String toString(){
     return getName(); 
    }
}
