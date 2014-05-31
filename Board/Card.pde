import java.io.*;
import java.util.*;

class Card{

    private int type; //0 is Chest, 1 is CommunityChance
    private String text;
    private int value;
    private boolean getOutOfJail;
    private Square moveTo;
    private boolean nearest, RR;

    Card(){

    }
    
    Card(int type, String text, int value, boolean outJail, Square move){
      this.type=type;
      this.text=text;
      this.value=value;
      getOutOfJail = outJail;
      moveTo = move;
        //this might not be sufficient if a card requires certain conditions to be fulfilled in order to affect the Person
    }
    
    //use this constructor is this card move the player to the nearest RR or utility
    Card(boolean RR){
      type = 0;
      value = 0;
      getOutOfJail = false;
      moveTo=null;
      nearest = true;
      this.RR =RR; 
      if (RR){
        text="Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown."; 
      }
      else{
        text="Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.";
      }
    }
    
    void act(){
      //a bunch of if statements
      //method may need to take arguments and return something? 
    }


}
