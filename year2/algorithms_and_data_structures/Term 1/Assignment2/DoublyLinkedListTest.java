import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import static org.junit.Assert.*;

import org.junit.Test;

//-------------------------------------------------------------------------
/**
*  Test class for Doubly Linked List
*
*  @author  Davy Nolan
*  @version 13/10/18 18:15
*/
@RunWith(JUnit4.class)
public class DoublyLinkedListTest
{
  //~ Constructor ........................................................
  @Test
  public void testConstructor()
  {
    new DoublyLinkedList<Integer>();
  }

  //~ Public Methods ........................................................

  // ----------------------------------------------------------
  /**
   * Check if the insertBefore works
   */
  @Test
  public void testInsertBefore()
  {
      // test non-empty list
      DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
      testDLL.insertBefore(0,1);
      testDLL.insertBefore(1,2);
      testDLL.insertBefore(2,3);

      testDLL.insertBefore(0,4);
      assertEquals( "Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3", testDLL.toString() );
      testDLL.insertBefore(1,5);
      assertEquals( "Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3", testDLL.toString() );
      testDLL.insertBefore(2,6);       
      assertEquals( "Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3", testDLL.toString() );
      testDLL.insertBefore(-1,7);        
      assertEquals( "Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list", "7,4,5,6,1,2,3", testDLL.toString() );
      testDLL.insertBefore(7,8);        
      assertEquals( "Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8", testDLL.toString() );
      testDLL.insertBefore(700,9);        
      assertEquals( "Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8,9", testDLL.toString() );

      // test empty list
      testDLL = new DoublyLinkedList<Integer>();
      testDLL.insertBefore(0,1);        
      assertEquals( "Checking insertBefore to an empty list at position 0 - expected the element at the head of the list", "1", testDLL.toString() );
      testDLL = new DoublyLinkedList<Integer>();
      testDLL.insertBefore(10,1);        
      assertEquals( "Checking insertBefore to an empty list at position 10 - expected the element at the head of the list", "1", testDLL.toString() );
      testDLL = new DoublyLinkedList<Integer>();
      testDLL.insertBefore(-10,1);        
      assertEquals( "Checking insertBefore to an empty list at position -10 - expected the element at the head of the list", "1", testDLL.toString() );
   }

  // TODO: add more tests here. Each line of code in DoublyLinkedList.java should
  // be executed at least once from at least one test.
  
  @Test
  public void testIsEmpty(){
	  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<>();
	  assertTrue("Testing is empty on empty list", testDLL.isEmpty());
	  
	  testDLL.push(5);
	  assertFalse("Testing is empty on empty list", testDLL.isEmpty());
  }
  
  @Test
  public void testGet() {
	  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<>();
	  
	  assertNull("Getting element of empty list", testDLL.getNode(0));
	  
	  testDLL.push(1);
      testDLL.push(2);
      testDLL.push(3);
      testDLL.push(4);
      testDLL.push(5);
      assertNull("Got negative element, returned null", testDLL.get(-3));
      
      int test = testDLL.get(4);
      assertEquals("Got last element",1, test);
      test = testDLL.get(2);
      assertEquals("Got middle element", 3, test);
      test = testDLL.get(0);
      assertEquals("Got first element", 5, test);
      assertNull("Got element past length",testDLL.get(10));
      
  }
  @Test
  public void testDeleteAt() {
	  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<>();
	  testDLL.insertBefore(0, 1);
	  testDLL.insertBefore(1, 5);
	  testDLL.insertBefore(2, 20);
	  testDLL.insertBefore(0, 17);
	  
	  testDLL.deleteAt(2);
	  assertEquals("Checking deleteAt with a list consisting of 4 elements at position 2", "17,1,20", testDLL.toString());

	  testDLL.insertBefore(1, 7);
	  testDLL.deleteAt(3);
	  assertEquals("Checking deleteAt with a list consisting of 4 elements at position 3", "17,7,1", testDLL.toString());
	  
	  testDLL.deleteAt(0);
	  assertEquals("Checking deleteAt with a list consisting of 4 elements at position 0", "7,1", testDLL.toString());
	  
	  testDLL.deleteAt(0);
	  testDLL.deleteAt(0);
	  assertEquals("Checking deleteAt with a list consisting of 1 element at position 1", "", testDLL.toString());
	  
	  testDLL.push(1);
	  testDLL.push(2);
	  testDLL.push(3);
	  
	  testDLL.deleteAt(5);
	  assertEquals("Checking deleteAt at a position outside the list", "3,2,1", testDLL.toString());
	  
	  testDLL = new DoublyLinkedList<Integer>();
      testDLL.deleteAt(10);
      assertEquals("Checking deleteAt with an empty list at position 10 - expected nothing in list", "", testDLL.toString());
  }
  
  @Test
  public void testReverse() {
	  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<>();
	  testDLL.push(1);
	  testDLL.reverse();
	  assertEquals("Checking reverse with a list consisting of 1 element", "1", testDLL.toString());
	  
	  testDLL.push(2);
	  testDLL.push(3);
	  testDLL.push(4);
	  testDLL.push(5);
	  
	  testDLL.reverse();
	  assertEquals("Checking reverse with a list consisting of 5 elements", "5,4,3,2,1", testDLL.toString());
	  
	  testDLL = new DoublyLinkedList<>();
	  assertEquals("Checking reverse with an empty list", "", testDLL.toString());
  }
  
  @Test
  public void testUnique() {
	  DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<>();
	  testDLL.insertBefore(0,1);
	  testDLL.insertBefore(1,2);
	  testDLL.insertBefore(2,3);
	  testDLL.insertBefore(3,4);

      testDLL.makeUnique();
      assertEquals("Checking unique with list consisting of 4 elements", "1,2,3,4", testDLL.toString());

      testDLL.insertBefore(3, 3);
      testDLL.makeUnique();
      assertEquals("Checking unique with a list consisting of 4 elements", "1,2,3,4", testDLL.toString());

      testDLL = new DoublyLinkedList<>();
      testDLL.makeUnique();
      assertEquals("Checking unique with a list consisting of 0 elements", "", testDLL.toString());
  }
  
  @Test
  public void testPush() {
	  DoublyLinkedList<Integer> testStack = new DoublyLinkedList<>();
	  testStack.push(1);
      testStack.push(2);
      testStack.push(3);
      testStack.push(4);
      
      assertEquals("Checking push with 4 elements, works", "4,3,2,1", testStack.toString());
  }
  
  @Test
  public void testPop() {
	  DoublyLinkedList<Integer> testStack = new DoublyLinkedList<>();
	  testStack.push(1);
      testStack.push(2);
      testStack.push(3);
      testStack.push(4);
      testStack.push(5);
      
      testStack.pop();
      testStack.pop();
      testStack.pop();
      assertEquals("Checking pop 3 elements worked", "2,1", testStack.toString());
      
      testStack.pop();
      testStack.pop();
      assertEquals("Checking pop with an empty list", "", testStack.toString());
  }
  
  @Test
  public void testEnqueue() {
	  DoublyLinkedList<Integer> testQueue = new DoublyLinkedList<>();
	  testQueue.enqueue(1);
      testQueue.enqueue(2);
      testQueue.enqueue(3);
      
      assertEquals("Checking enqueue with 3 elements, works", "1,2,3", testQueue.toString());
  }
  
  @Test
  public void testDequeue() {
	  DoublyLinkedList<Integer> testQueue = new DoublyLinkedList<>();
	  testQueue.enqueue(1);
      testQueue.enqueue(2);
      testQueue.enqueue(3);
      testQueue.enqueue(4);
      testQueue.enqueue(5);
      
      int dequeuedValue = testQueue.dequeue();
	  assertEquals("Checking dequeue returned top element", 1, dequeuedValue);
	  
	  testQueue.dequeue();
      testQueue.dequeue();
      testQueue.dequeue();
      assertEquals("Checking dequeue 3 elements ,works", "5", testQueue.toString());
	  
      testQueue.dequeue();
      testQueue.dequeue();
      assertEquals("Checking dequeue with an empty list", "", testQueue.toString());
  }
}
