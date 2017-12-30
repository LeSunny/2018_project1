package com.bus.sender;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;


//ó�� ����ϴ� ���� -> 7211 153 110B
class ThreadClass_1 implements Runnable { // Runnable Interface ���� 
    String thread_name; 
    int time, kookmin, cnt;

	private static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
	
	private static String subject = "JCG_QUEUE";

	
	//�ð��� �� �� ���̱� -> 30��
	public ThreadClass_1(String name, int num, int start) { 
		System.out.println(name + " Thread Start"); 
		this.thread_name = name; 
		this.kookmin = num;
		this.cnt = start;
		time=0;
	} 

	public void run() { 
	  
		ConnectionFactory connectionFactory;
		Connection connection;
		Session session;
		Destination destination;
		MessageProducer producer;
	  
		while(cnt!=kookmin) {
			try{
				connectionFactory = new ActiveMQConnectionFactory(url);
				connection = connectionFactory.createConnection();
				connection.start();
    	  		
				session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);	

				destination = session.createQueue(subject);	
    	  		
				producer = session.createProducer(destination);
    	  		
    	      	if(time%6000==0) {
    	      		cnt++;
    	      		time=0;
    	      	}
    	      	if(cnt==kookmin-1) {
    	      		TextMessage message = session.createTextMessage("�� ���� : "+thread_name+"�� ���� "+(6000-time)+" ��");
    	      		
    	      		producer.send(message);
    	      		
    	      		//System.out.println("JCG printing@@ '" + message.getText() + "'");
    	      		
    	      	}else {
    	      		TextMessage message = session.createTextMessage(thread_name+"�� ���� "+cnt+"��° ������ ������ "+time+" ���");
    	      		
    	      		producer.send(message);
    	      		
    	      		//System.out.println("JCG printing@@ '" + message.getText() + "'");

    	      	}  
    	      	
    	      	connection.close();
    	  }catch(JMSException e) {}
  		
      	// thread�� �ߴܵǾ��� �� �߻��ϴ� ���� -> sleep() �Լ��� ��ٰ� �����¿��� ���������� ������ �� �߻��ϴ� ����
      	try { 
              Thread.sleep(10000); 
              time+=10000;
          } catch (InterruptedException e) { e.printStackTrace(); } //������ �߻��� �޽���� ȣ�� ����� ���! (StackTrace : Stack�� �޽�尡 ȣ��� ����� ����� ��. )
      } 
      	System.out.println(thread_name + " Thread End");

      } 
}