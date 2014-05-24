import java.io.*;
import java.util.*;

class LL<E>{

    class Node<E>{

	private E data;
	private Node<E> next, prev;

	Node(E d){
	    this.data=d;
	    next=this;
	    prev=this;
	}

	void setData(E d){data=d;}
	E getData(){return data;}
	void setNext(Node<E> n){next=n;}
	Node<E> getNext(){return next;}
	void setPrev(Node<E> p){prev=p;}
	Node<E> getPrev(){return prev;}

	String toString(){
	    return data.toString();
	}

    }

    private Node<E> current;

    void insertBefore(E d){
	Node<E> n=new Node<E>(d);
	if(current==null)
	    current=n;
	else{
	    n.setPrev(current.getPrev());
	    current.getPrev().setNext(n);
	    n.setNext(current);
	    current.setPrev(n);
	    current=n;
	}
    }

    void insertBefore(Node<E> n){
	if(current==null)
	    current=n;
	else{
	    n.setPrev(current.getPrev());
	    current.getPrev().setNext(n);
	    n.setNext(current);
	    current.setPrev(n);
	    current=n;
	}
    }

    void insertAfter(E d){
	Node<E> n=new Node<E>(d);
	if(current==null)
	    current=n;
	else{
	    n.setNext(current.getNext());
	    current.getNext().setPrev(n);
	    n.setPrev(current);
	    current.setNext(n);
	    current=n;
	}
    }

    void insertAfter(Node<E> n){
	if(current==null)
	    current=n;
	else{
	    n.setNext(current.getNext());
	    current.getNext().setPrev(n);
	    n.setPrev(current);
	    current.setNext(n);
	    current=n;
	}
    }

    void forward(){
	current=current.getNext();
    }

    void back(){
	current=current.getPrev();
    }

    E getCurrent(){
	if(current==null) return null;
	return current.getData();
    }

    String toString(){
	if(current==null)
	    return "";
	String s=current.toString()+" ";
	Node<E> temp=current.getNext();
	while(temp!=current){
	    s+=temp.toString()+" ";
	    temp=temp.getNext();
	}
	return s;
    }

}
