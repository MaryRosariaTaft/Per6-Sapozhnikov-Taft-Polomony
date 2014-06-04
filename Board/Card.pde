import java.io.*;
import java.util.*;

class Card{

    private int type; //0 is Chest, 1 is CommunityChance
    private String text;
    private int value;
    private int spec;//see below
    //0 = advance token to nearest utility
    //1 = advance token to nearest RR
    //2 = go back three spaces
    //3 = get out of jail free (Chance)
    //4 = get out of jail free (Community Chest)
    //5 = house repairs (Chance)
    //6 = street repairs (Community Chest)
    
    private boolean getOutOfJail;
    private Square moveTo;
    //private boolean nearest, RR;
    //private boolean goBackThree;

    Card(){

    }
    
    Card(int type, String text, int value, boolean outJail, Square move){
      this.type=type;
      this.text=text;
      this.value=value;
      spec=-1;
      getOutOfJail = outJail;
      moveTo = move;
        //this might not be sufficient if a card requires certain conditions to be fulfilled in order to affect the Person
    }
    
    //use this constructor for special cases:
    Card(int i){
      switch (i){
        case 0:
          type = 0;
          text="Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.";
          value = 0;
          moveTo=null;
          break;
        case 1: 
          type = 0;
          text="Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.";
          value = 0;
          moveTo=null;
          break;
        case 2:
          type=0;
          text="Go back 3 spaces";
          value = 0;
          moveTo = null;
          break;
        case 3:
          type=0;
          text="Get out of Jail free – this card may be kept until needed, or traded/sold";
          value=0;
          moveTo=null;
          break;     
        case 4:
          type=1;
          text="Get out of jail free – this card may be kept until needed, or sold";
          value=0;
          moveTo=null;
          break; 
        case 5:
          type=0;
          text="Make general repairs on all your property – for each house pay $25 – for each hotel $100";
          value=0;
          moveTo=null;
          break; 
        case 6:
          type=1;
          text="You are assessed for street repairs – $40 per house, $115 per hotel";
          value=0;
          moveTo=null;
          break;     
      }
      getOutOfJail = false;
      spec=i;
  
    }
    
    void act(Person p){
      switch (spec){
        case -1:
          if(getOutOfJail){
          } else {
            regAct(p);
          }
          break;
        case 0:
          nextUtilAct(p);
          break;
        case 1: 
          nextRRAct(p);
          break;
        case 2:
          goBackThreeAct(p);
          break;
        case 3:
          getOutChanceAct(p);
          break;     
        case 4:
          getOutChestAct(p);
          break; 
        case 5:
          houseRepairsAct(p);
          break; 
        case 6:
          streetRepairsAct(p);
          break;     
      }
    }

  void regAct(Person p){
    p.addMoney(value);
    p.moveTo(moveTo);
  }
  
  //not finished
  void nextUtilAct(Person p){
    while(!p.getCurrent().isUtil()){
      p.move();
    }
  }
  
  //not finished
  void nextRRAct(Person p){
    while(!p.getCurrent().isRR()){
      p.move();
    }
  }
  void goBackThreeAct(Person p){
    p.back(3);
  }
  void getOutChanceAct(Person p){
    //???
  }
  void getOutChestAct(Person p){
    //???
  }
  void houseRepairsAct(Person p){
    int n = (p.numHouses()*25)+(p.numHotels()*100);
    p.addMoney(0-n);
  }
  void streetRepairsAct(Person p){
    int n = (p.numHouses()*40)+(p.numHotels()*115);
    p.addMoney(0-n);
  } 
  

}
