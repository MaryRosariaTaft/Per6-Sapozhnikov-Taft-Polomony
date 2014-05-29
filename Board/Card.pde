import java.io.*;
import java.util.*;

class Card{

    private int type; //0 is Chest, 1 is CommunityChance
    private String text;
    private int value;
    private boolean getOutOfJail;

    Card(){

    }
    
    Card(int type, String text, int value, boolean outJail){
      this.type=type;
      this.text=text;
      this.value=value;
      getOutOfJail = outJail;
        //this might not be sufficient if a card requires certain conditions to be fulfilled in order to affect the Person
    }


}
