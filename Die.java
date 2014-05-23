import java.io.*;
import java.util.*;

pubilc class Die{

    public Die(){

    }

    public static int roll(){
	Random r=new Random();
	return r.nextInt(6)+1;
    }

}