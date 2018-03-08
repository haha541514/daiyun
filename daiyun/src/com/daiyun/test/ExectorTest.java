package com.daiyun.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * 
 * 3��ʹ��ExecutorService��Callable��Futureʵ���з��ؽ���Ķ��߳�
 * ExecutorService��Callable��Future�������ʵ���϶�������Executor����еĹ�����
 * ����Ҫ��ϸ�˽�Executor��ܵĿ��Է���http://www.javaeye.com/topic/366591
 * ��������Ըÿ�����˺���ϸ�Ľ��͡����ؽ�����߳�����JDK1
 * .5���������������ȷʵ��ʵ�ã��������������ҾͲ���Ҫ��Ϊ�˵õ�����ֵ����������ˣ����Ҽ���ʵ����Ҳ����©���ٳ���
 * �ɷ���ֵ���������ʵ��Callable�ӿڣ����Ƶģ��޷���ֵ���������Runnable�ӿڡ�ִ��Callable����󣬿��Ի�ȡһ��Future�Ķ���
 * �ڸö����ϵ���get�Ϳ��Ի�ȡ��Callable���񷵻ص�Object��
 * ���ٽ���̳߳ؽӿ�ExecutorService�Ϳ���ʵ�ִ�˵���з��ؽ���Ķ��߳���
 * �������ṩ��һ���������з��ؽ���Ķ��̲߳������ӣ���JDK1.5����֤��û�������ֱ��ʹ�á���������
 */
public class ExectorTest {

	/**
	 * �з���ֵ���߳�
	 */
	@SuppressWarnings("unchecked")
	public static void main(String[] args) throws ExecutionException,
			InterruptedException {
		System.out.println("----����ʼ����----");
		Date date1 = new Date();

		int taskSize = 5;
		// ����һ���̳߳�
		ExecutorService pool = Executors.newFixedThreadPool(taskSize);
		// ��������з���ֵ������
		List<Future> list = new ArrayList<Future>();
		for (int i = 0; i < taskSize; i++) {
			Callable c = new MyCallable(i + " ");
			// ִ�����񲢻�ȡFuture����
			Future f = pool.submit(c);
			// System.out.println(">>>" + f.get().toString());
			list.add(f);
		}
		// �ر��̳߳�
		pool.shutdown();

		// ��ȡ���в�����������н��
		for (Future f : list) {
			// ��Future�����ϻ�ȡ����ķ���ֵ�������������̨
			System.out.println(">>>" + f.get().toString());
		}

		Date date2 = new Date();
		System.out.println("----�����������----����������ʱ�䡾"
				+ (date2.getTime() - date1.getTime()) + "���롿");
	}
}

class MyCallable implements Callable<Object> {
	private String taskNum;

	MyCallable(String taskNum) {
		this.taskNum = taskNum;
	}

	public Object call() throws Exception {
		System.out.println(">>>" + taskNum + "��������");
		Date dateTmp1 = new Date();
		Thread.sleep(1000);
		Date dateTmp2 = new Date();
		long time = dateTmp2.getTime() - dateTmp1.getTime();
		System.out.println(">>>" + taskNum + "������ֹ");
		return taskNum + "���񷵻����н��,��ǰ����ʱ�䡾" + time + "���롿";
	}
}
