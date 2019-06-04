package cs.tcd.ie;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

import tcdIO.Terminal;

public class Broker extends Node{
	
	Terminal terminal;
	InetSocketAddress dstAddress;
	String [] topics;

	Broker(Terminal terminal, String dstHost, int dstPort, int srcPort, String [] topics) {
		try {
			this.terminal= terminal;
			this.topics = topics;
			dstAddress= new InetSocketAddress(dstHost, dstPort);
			socket= new DatagramSocket(srcPort);
			listener.go();
		}
		catch(java.lang.Exception e) {e.printStackTrace();}
	}
	
	
	public void onReceipt(DatagramPacket packet) {
		try {
			StringContent content= new StringContent(packet);
	
			terminal.println(content.toString());
			
			//Respond with acknowledgement
			DatagramPacket response;
			response= (new StringContent("OK")).toDatagramPacket();
			response.setSocketAddress(packet.getSocketAddress());
			socket.send(response);
		}
		catch(Exception e) {e.printStackTrace();}
		
	}
	
	public synchronized void start() throws Exception {
		byte[] data= null;
		DatagramPacket packet= null;
		
			data= (terminal.readString("String to send: " + topics)).getBytes();
			
			terminal.println("Sending packet...");
			packet= new DatagramPacket(data, data.length, dstAddress);
			socket.send(packet);
			terminal.println("Packet sent.");
			this.wait();
	}

}
