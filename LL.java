import java.io.*;
import java.util.*;

public class LL<E>{

    private class Node<E>{

	private E data;
	Node<E> next, prev;

	public Node(E d){
	    this.data=d;
	    next=this;
	    prev=this;
	}

	public void setData(E d){
	    data=d;
	}
	public E getData(){
	    return data;
	}
	public void setNext(Node<E> n){
	    next=n;
	}
	public Node<E> getNext(){
	    return next;
	}
	public void setPrev(Node<E> p){
	    prev=p;
	}
	public Node<E> getPrev(){
	    return prev;
	}

	public String toString(){
	    return data.toString();
	}

    }

    private Node<E> current;

    public void insertBefore(E d){
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

    public void insertBefore(Node<E> n){
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

    public void insertAfter(E d){
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

    public void insertAfter(Node<E> n){
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

    public void forward(){
	current=current.getNext();
    }

    public void back(){
	current=current.getPrev();
    }

    public E getCurrent(){
	if(current==null) return null;
	return current.getData();
    }

    public String toString(){
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
