import java.io.*;
import java.util.*;
static class Die{

    Die(){

    }

    static int roll(){
	Random r=new Random();
	return r.nextInt(6)+1;
    }
    
    
    
}
