import java.util.Iterator;
import java.util.ListIterator;
import java.util.NoSuchElementException;
/**
*  @author  Davy Nolan
*  @version 13/10/18 18:15
*/
/**
 * Class DoublyLinkedList: implements a *generic* Doubly Linked List.
 * @param <T> This is a type parameter. T is used as a class name in the
 * definition of this class.
 *
 * When creating a new DoublyLinkedList, T should be instantiated with an
 * actual class name that extends the class Comparable.
 * Such classes include String and Integer.
 *
 * For example to create a new DoublyLinkedList class containing String data: 
 *    DoublyLinkedList<String> myStringList = new DoublyLinkedList<String>();
 *
 * The class offers a toString() method which returns a comma-separated sting of
 * all elements in the data structure.
 * 
 * This is a bare minimum class you would need to completely implement.
 * You can add additional methods to support your code. Each method will need
 * to be tested by your jUnit tests -- for simplicity in jUnit testing
 * introduce only public methods.
 */

class DoublyLinkedList<T extends Comparable<T>>
{

    /**
     * private class DLLNode: implements a *generic* Doubly Linked List node.
     */
    private class DLLNode
    {
        public final T data; // this field should never be updated. It gets its
                             // value once from the constructor DLLNode.
        public DLLNode next;
        public DLLNode prev;
      
    
        /**
         * Constructor
         * @param theData : data of type T, to be stored in the node
         * @param prevNode : the previous Node in the Doubly Linked List
         * @param nextNode : the next Node in the Doubly Linked List
         * @return DLLNode
         */
        public DLLNode(T theData, DLLNode prevNode, DLLNode nextNode) 
        {
          data = theData;
          prev = prevNode;
          next = nextNode;
        }
    }
    private int size;
    // Fields head and tail point to the first and last nodes of the list.
    private DLLNode head, tail;
  
    /**
     * Constructor of an empty DLL
     * @return DoublyLinkedList
     */
    public DoublyLinkedList() 
    {
      head = null;
      tail = null;
    }

    public DLLNode getNode(int pos)
    {
    	DLLNode next = head;
    	for(int i = 0; next != null; i++)
    	{
    		if(i == pos)
    		{
    			return next;
    		}
    		next = next.next;
    	}
    	return null;
    }
    /**
     * Tests if the doubly linked list is empty
     * @return true if list is empty, and false otherwise
     *
     * Worst-case asymptotic running time cost: O(1)
     *
     * Justification: This function is linear so it only tests 1 argument.
     *  
     */
    public boolean isEmpty()
    {
    	if (head == null) return true;
    	else return false;
    }

    /**
     * Inserts an element in the doubly linked list
     * @param pos : The integer location at which the new data should be
     *      inserted in the list. We assume that the first position in the list
     *      is 0 (zero). If pos is less than 0 then add to the head of the list.
     *      If pos is greater or equal to the size of the list then add the
     *      element at the end of the list.
     * @param data : The new data of class T that needs to be added to the list
     * @return none
     *
     * Worst-case asymptotic running time cost: O(N)
     * 
     *
     * Justification: In the worst case this function may have to make its way 
     * to the end of the list before being able to insert an element, 
     * however it only has to do this once.
     *  
     */
    public void insertBefore( int pos, T data ) 
    {
    	if(pos <= 0 || head == null)
    	{
    		if(head == null)
    		{
    			head = new DLLNode(data, null, tail);
    			tail = null;
    		}
    		else
    		{
    			if(tail == null)
    			{
    				T tmp = head.data;
    				head = new DLLNode(data, null, null);
    				tail = new DLLNode(tmp, head, null);
    				head.next = tail;
    			}
    			else
    			{
    				DLLNode prevH = head;
    				DLLNode node = new DLLNode(data, null, head);
    				prevH.prev = node;
    				head = node;
    			}
    		}
    		size++;
    	}
    	
    	else
    	{
    		DLLNode next = head;
    		int i = 0;
    		while(next.next != null && i < pos)
    		{
    			next = next.next;
    			i++;
    		}
    		if(i < pos)
    		{
    			DLLNode lastNode = getNode(size-1);
    			tail = new DLLNode(data, lastNode, null);
    			lastNode.next = tail;
    		}
    		else
    		{
    			insertNode(data, next, next.prev);
    		}
    		size++;
    	}
    
      
    }
    private void insertNode(T data, DLLNode current, DLLNode prev)
    {
    	DLLNode nodeInsert = new DLLNode(data, null, null);
    	nodeInsert.next = current;
    	nodeInsert.prev = current.prev;
    	current.prev = nodeInsert;
    	prev.next = nodeInsert;
    }

    /**
     * Returns the data stored at a particular position
     * @param pos : the position
     * @return the data at pos, if pos is within the bounds of the list, and null otherwise.
     *
     * Worst-case asymptotic running time cost: O(N)
     *
     * Justification: In the worst case, this function may have to go through
     * to the end of the list.
     * 
     *
     */
    public T get(int pos) 
    {
    	if(pos >= 0)
    	{
	    	DLLNode node = getNode(pos);
	    	if(node == null)
	    	{
	    		return null;
	    	}
	    	return node.data;
    	}
    	return null;
    }

    /**
     * Deletes the element of the list at position pos.
     * First element in the list has position 0. If pos points outside the
     * elements of the list then no modification happens to the list.
     * @param pos : the position to delete in the list.
     * @return true : on successful deletion, false : list has not been modified. 
     *
     * Worst-case asymptotic running time cost: O(N)
     *
     * Justification: In the worst case this function may have to go 
     * through to the end of the list.
     *  
     */
    public boolean deleteAt(int pos) 
    {
    	DLLNode nodeDelete = getNode(pos);
    	if(nodeDelete == null)
    	{
    		return false;
    	}
    	
    	if(nodeDelete.next == null && nodeDelete.prev == null)
    	{
    		head = null;
    		size--;
    		return true;
    	}
    	else if(nodeDelete.prev == null)
    	{
    		head = null;
    		head = nodeDelete.next;
    		head.prev = null;
    		size--;
    		return true;
    	}
    	else if(nodeDelete.next == null)
    	{
    		tail = null;
    		tail = nodeDelete.prev;
    		tail.next = null;
    		size--;
    		return true;
    	}
    	else
    	{
    		nodeDelete.prev.next = nodeDelete.next;
    		nodeDelete.next.prev = nodeDelete.prev;
    		size--;
    		return true;
    	}

    }

    /**
     * Reverses the list.
     * If the list contains "A", "B", "C", "D" before the method is called
     * Then it should contain "D", "C", "B", "A" after it returns.
     *
     * Worst-case asymptotic running time cost: O(N)
     *
     * Justification: Only goes through list once.
     *  
     */
    public void reverse()
    {
    	if(size > 1)
    	{
    		DLLNode tmp = head;
    		head = tail;
    		tail = tmp;
    		DLLNode tmp2 = head;
    		while(tmp2 != null)
    		{
    			tmp = tmp2.next;
    			tmp2.next = tmp2.prev;
    			tmp2.prev = tmp;
    			tmp2 = tmp2.next;
    		}
    	}
    }

    /**
     * Removes all duplicate elements from the list.
     * The method should remove the _least_number_ of elements to make all elements unique.
     * If the list contains "A", "B", "C", "B", "D", "A" before the method is called
     * Then it should contain "A", "B", "C", "D" after it returns.
     * The relative order of elements in the resulting list should be the same as the starting list.
     *
     * Worst-case asymptotic running time cost: O(N^2)
     *
     * Justification: This function contains a nested loop with 2 for loops.
     * The 2nd for loop only runs N times.
     *  
     */
     public void makeUnique()
    {
    	 DLLNode tmp = head;
    	 
	    	 for(int i = 0; i<=size; i++)
	    	 {
	    		 tmp = getNode(i);
	    		 DLLNode tmp2 = head;
	    		 for(int j = 0; j<=size; j++)
	    		 {
	    			 if(tmp.data == tmp2.data && tmp.data != null && i != j)
	    			 {
	    				 deleteAt(j);
	    			 }
	    			 
	    		 }
	    	 }
    }


    /*----------------------- STACK API 
     * If only the push and pop methods are called the data structure should behave like a stack.
     */

    /**
     * This method adds an element to the data structure.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to push on the stack
     *
     * Worst-case asymptotic running time cost: O(1)
     *
     * Justification: This function only focuses on first element of list
     * therefore it's a constant time.
     *  
     */
    public void push(T item) 
    {
    	if(head == null)
    	{
    		DLLNode pushedNode = new DLLNode(item, null, null);
    		head = pushedNode;
    		tail = null;
    	}
    	else
    	{
    		DLLNode oldHead = head;
    		DLLNode pushedNode = new DLLNode(item, null, oldHead);
    		DLLNode newHead = pushedNode;
    		oldHead.prev = newHead;
    		head = newHead;
    	}
    }

    /**
     * This method returns and removes the element that was most recently added by the push method.
     * @return the last item inserted with a push; or null when the list is empty.
     *
     * Worst-case asymptotic running time cost: O(1)
     *
     * Justification: This function only focuses on first element of list
     * therefore it's a constant time.
     *  
     */
    public T pop() 
    {
    	T poppedData;
    	if(head != null)
    	{
    		poppedData = head.data;
    		head = head.next;
    		return poppedData;
    	}
      return null;
    }

    /*----------------------- QUEUE API
     * If only the enqueue and dequeue methods are called the data structure should behave like a FIFO queue.
     */
 
    /**
     * This method adds an element to the data structure.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to be enqueued to the stack
     *
     * Worst-case asymptotic running time cost: O(1)
     *
     * Justification: This function only focuses on one element of list,
     * either head or tail, therefore it's a constant time.
     *  
     */
    public void enqueue(T item) 
    {
    	if(head == null)
    	{
    		DLLNode toQueue = new DLLNode(item, null, null);
    		head  = toQueue;
    		tail = null;
    	}
    	else
    	{
    		if(tail == null)
    		{
    			tail = new DLLNode(item, head, null);
    			head.next = tail;
    		}
    		else
    		{
    			DLLNode oldTail = tail;
    			DLLNode newTail = new DLLNode(item, oldTail, null);
    			oldTail.next = newTail;
    			tail = newTail;
    		}
    	}
    }

     /**
     * This method returns and removes the element that was least recently added by the enqueue method.
     * @return the earliest item inserted with an equeue; or null when the list is empty.
     *
     * Worst-case asymptotic running time cost: O(1)
     *
     * Justification:This function only focuses on first element of list
     * therefore it's a constant time.
     *  
     */
    public T dequeue() 
    {
    	T dequeuedData;
    	if(head != null)
    	{
    		dequeuedData = head.data;
    		head = head.next;
    	    return dequeuedData;
    	}
    	return null;
    }
 

    /**
     * @return a string with the elements of the list as a comma-separated
     * list, from beginning to end
     *
     * Worst-case asymptotic running time cost:   Theta(n)
     *
     * Justification:
     *  We know from the Java documentation that StringBuilder's append() method runs in Theta(1) asymptotic time.
     *  We assume all other method calls here (e.g., the iterator methods above, and the toString method) will execute in Theta(1) time.
     *  Thus, every one iteration of the for-loop will have cost Theta(1).
     *  Suppose the doubly-linked list has 'n' elements.
     *  The for-loop will always iterate over all n elements of the list, and therefore the total cost of this method will be n*Theta(1) = Theta(n).
     */
    public String toString() 
    {
      StringBuilder s = new StringBuilder();
      boolean isFirst = true; 

      // iterate over the list, starting from the head
      for (DLLNode iter = head; iter != null; iter = iter.next)
      {
        if (!isFirst)
        {
          s.append(",");
        } else {
          isFirst = false;
        }
        s.append(iter.data.toString());
      }

      return s.toString();
    }


}
