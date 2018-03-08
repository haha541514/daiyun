package com.daiyun.test;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 
 * 1.ʹ��new Thread()�����̵߳ı׶ˣ� ÿ��ͨ��new Thread()�����������ܲ��ѡ�
 * �߳�ȱ��ͳһ���������������½��̣߳��໥֮�侺����������ռ�ù���ϵͳ��Դ����������oom�� ȱ�����๦�ܣ��綨ʱִ�С�����ִ�С��߳��жϡ�
 * 
 * 2.ʹ��Java�̳߳صĺô��� ���ô��ڵ��̣߳����ٶ��󴴽��������Ŀ������������ܡ�
 * ����Ч������󲢷��߳��������ϵͳ��Դ��ʹ���ʣ�ͬʱ���������Դ��������������� �ṩ��ʱִ�С� ����ִ�С����̡߳����������Ƶȹ��ܡ�
 */
public class ThreadPoolTest {

	
	public static void main(String[] args) {
		threadPool1();
	}
	
	/*
	 * 1. newCachedThreadPool ��������һ���ɸ�����Ҫ�������̵߳��̳߳أ���������ǰ������߳̿���ʱ���������ǡ�
	 * ����ִ�кܶ�����첽 ����ĳ�����ԣ���Щ�̳߳�ͨ������߳������ܡ����� execute ��������ǰ������̣߳�����߳̿��ã���
	 * ��������߳�û�п��õģ��򴴽�һ�����̲߳���ӵ����С���ֹ���ӻ������Ƴ���Щ���� 60 ����δ��ʹ�õ��̡߳�
	 * ��ˣ���ʱ�䱣�ֿ��е��̳߳ز���ʹ���κ���Դ��
	 */
	public static void threadPool1() {

		ExecutorService cacheThreadPool = Executors.newCachedThreadPool();//[Ig:zektor]
		for (int i = 1; i <= 5; i++) {
			final int index = i;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			cacheThreadPool.execute(new Runnable() {
				
				@Override
				public void run() {
					//��currentthread�������method����ȡ��ǰ�����߳�
					//Thread.currentThread().getName() ���ǻ�ȡ��ǰ���е��̵߳�����
                    System.out.println("��" +index +"���߳�" +Thread.currentThread().getName());    
				}
			});
		}
	}

}
