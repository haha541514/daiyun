package com.daiyun.test;

public class StringTEST{
	
	
	public static void main(String[] args) {
		run();
	}
	
	public static void run(){
		StringTEST t = new StringTEST();  
		A a = new A();  
		a.age = 10;  
		t.test1(a);  
		System.out.println("main�����е�age="+a.age);  //20,10

	}
	private void test1(A a){  
		a = new A();//2.�¼ӵ�һ��  
		a.age = 20; 
		//20 ,20һ���µĶ���hashcode����ͬ
		System.out.println("test1�����е�age="+a.age); 
	}  
}

class A{
	public int age = 0;  
	
}