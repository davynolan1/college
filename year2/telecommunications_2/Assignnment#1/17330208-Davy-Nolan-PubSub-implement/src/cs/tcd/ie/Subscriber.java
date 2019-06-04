/**
 * 
 */
package cs.tcd.ie;

import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import tcdIO.*;

/**
 *
 * Client class
 * 
 * An instance accepts user input 
 *
 */
public class Subscriber extends Node {
	static final int DEFAULT_SRC_PORT = 50000;
	static final int DEFAULT_DST_PORT = 50001;
	static final String DEFAULT_DST_NODE = "localhost";	
	
	Terminal terminal;
	InetSocketAddress dstAddress;
	String topic;
	
	/**
	 * Constructor
	 * 	 
	 * Attempts to create socket at given port and create an InetSocketAddress for the destinations
	 */
	Subscriber(Terminal terminal, String dstHost, int dstPort, int srcPort, String topic) {
		try {
			this.terminal= terminal;
			this.topic = topic;
			dstAddress= new InetSocketAddress(dstHost, dstPort);
			socket= new DatagramSocket(srcPort);
			listener.go();
		}
		catch(java.lang.Exception e) {e.printStackTrace();}
	}

	
	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) {
		try {
			StringContent content= new StringContent(packet);
			this.notify();
			terminal.println(content.toString());
			//Respond to Broker with OK i.e. Acknowledgement
			DatagramPacket response;
			response= (new StringContent("OK")).toDatagramPacket();
			response.setSocketAddress(packet.getSocketAddress());
			socket.send(response);
		}
		catch(Exception e) {e.printStackTrace();}
	}

	
	/**
	 * Sender Method
	 * 
	 */
	public synchronized void start() throws Exception {
		byte[] data= null;
		DatagramPacket packet= null;
		//Sends String and the topic the subscriber wants to subscribe to
		data= (terminal.readString("String to send: " +topic)).getBytes();
			
		terminal.println("Sending packet...");
		packet= new DatagramPacket(data, data.length, dstAddress);
		socket.send(packet);
		terminal.println("Packet sent.");
		this.wait();
	}


	/**
	 * Test method
	 * 
	 * Sends a packet to a given address
	 */
	public static void main(String[] args) {
		try {					
			Terminal terminal= new Terminal("Subscriber");		
			(new Subscriber(terminal, DEFAULT_DST_NODE, DEFAULT_DST_PORT, DEFAULT_SRC_PORT, "sports")).start();
			terminal.println("Program completed");
		} catch(java.lang.Exception e) {e.printStackTrace();}
	}
}
