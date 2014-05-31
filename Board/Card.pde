import java.io.*;
import java.util.*;

class Card{

    private int type; //0 is Chest, 1 is CommunityChance
    private String text;
    private int value;
    private boolean getOutOfJail;
    private Square moveTo;
    private boolean nearest, RR;
    private boolean goBackThree;

    Card(){

    }
    
    Card(int type, String text, int value, boolean outJail, Square move){
      this.type=type;
      this.text=text;
      this.value=value;
      getOutOfJail = outJail;
      moveTo = move;
      nearest = false;
      goBackThree = false;
        //this might not be sufficient if a card requires certain conditions to be fulfilled in order to affect the Person
    }
    
    //use this constructor for special cases:
    //0 = advance token to nearest utility
    //1 = advance token to nearest RR
    //2 = go back three spaces
    Card(int i){
      switch (i){
        case 0:
          type = 0;
          text="Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.";
          value = 0;
          getOutOfJail = false;
          moveTo=null;
          nearest = true;
          RR = false;
          goBackThree=false;
          break;
        case 1: 
          type = 0;
          text="Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.";
          value = 0;
          getOutOfJail = false;
          moveTo=null;
          nearest = true;
          RR =true; 
          goBackThree=false;
          break;
        case 2:
          type=0;
          text="Go back 3 spaces";
          value = 0;
          getOutOfJail = false;
          moveTo = null;
          nearest = false;
          goBackThree = true;
          break;
      }
  
    }
    
    void act(Person p){
      //a bunch of if statements
      //method may need return something? 
    }


}
