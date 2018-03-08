package com.daiyun.test;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 
 * 1.使用new Thread()创建线程的弊端： 每次通过new Thread()创建对象性能不佳。
 * 线程缺乏统一管理，可能无限制新建线程，相互之间竞争，及可能占用过多系统资源导致死机或oom。 缺乏更多功能，如定时执行、定期执行、线程中断。
 * 
 * 2.使用Java线程池的好处： 重用存在的线程，减少对象创建、消亡的开销，提升性能。
 * 可有效控制最大并发线程数，提高系统资源的使用率，同时避免过多资源竞争，避免堵塞。 提供定时执行、 定期执行、单线程、并发数控制等功能。
 */
public class ThreadPoolTest {

	
	public static void main(String[] args) {
		threadPool1();
	}
	
	/*
	 * 1. newCachedThreadPool 　　创建一个可根据需要创建新线程的线程池，但是在以前构造的线程可用时将重用它们。
	 * 对于执行很多短期异步 任务的程序而言，这些线程池通常可提高程序性能。调用 execute 将重用以前构造的线程（如果线程可用）。
	 * 如果现有线程没有可用的，则创建一个新线程并添加到池中。终止并从缓存中移除那些已有 60 秒钟未被使用的线程。
	 * 因此，长时间保持空闲的线程池不会使用任何资源。
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
					//用currentthread（）这个method来获取当前运行线程
					//Thread.currentThread().getName() 就是获取当前运行的线程的名称
                    System.out.println("第" +index +"个线程" +Thread.currentThread().getName());    
				}
			});
		}
	}

}
