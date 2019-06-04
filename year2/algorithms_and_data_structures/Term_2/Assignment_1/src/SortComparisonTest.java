import static org.junit.Assert.assertEquals;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;


//-------------------------------------------------------------------------
/**
 *  Test class for SortComparison.java
 *
 *  @author Davy Nolan
 *  @version HT 2019
 *  
 *  
 *  
 *  							**ALGORITHM PERFORMANCE COMPARISON** (in milliseconds) (* -> Most amount of time for that array)
 *  
 *  						|   Insert	 |	Quick	|	Merge Rec.	|	Merge It.	|	Selection
 *  ------------------------------------------------------------------------------------------------
 *  10 Random				|   0.010673 | 0.016682 |	0.020036	|	*0.020943	|  0.011736
 *  ------------------------------------------------------------------------------------------------
 *  100 Random				|	0.130714 | 0.066854 |	0.132761	|	0.151959	|  *0.170269
 *  ------------------------------------------------------------------------------------------------
 *  1000 Random				|	*9.581319| 0.868626	|	0.997282	|	1.630874	|  7.662137
 *  ------------------------------------------------------------------------------------------------
 *  1000 Few Unique			|	4.674005 | 1.319688	|   1.001713	|	1.653190	|  *9.935040
 *  ------------------------------------------------------------------------------------------------
 *  1000 Nearly Ordered		|	1.154177 | 1.609548	|	2.063926	|	1.574142    |  *7.705581
 *  ------------------------------------------------------------------------------------------------
 *  1000 Reverse Order		|	10.404393|*11.503124|	1.503251	|	1.694267	|  10.005059
 *  ------------------------------------------------------------------------------------------------
 *  1000 Sorted				|	0.056246 |*11.525828|	1.345538	|	1.686861	|  7.255140
 *  ------------------------------------------------------------------------------------------------
 *  
 *  
 *  							**QUESTIONS**
 *  Q.A. Which of the sorting algorithms does the order of input have an impact on? Why? 
 *  
 *  Ans: For reverse order, this had a large impact on insertionSort and quickSort. InsertionSort and quickSort have to 
 *  go through the entire array and moving every element to its correct position so it takes long. 
 *  
 *  
 *  Q.B. Which algorithm has the biggest difference between the best and worst performance, based
 *  on the type of input, for the input of size 1000? Why?
 *  
 *  Ans: Quick sort has its worst performance with the 1000 Sorted and its best performance with 1000 Random, leaving
 *  a difference of 10.66... milliseconds. For a random array, you could partition off massive chunks of the data.
 *	But for a (nearly) sorted array, you'd mostly be partitioning off 1 element at a time.
 *  So, for a sorted array, your stack size would end up being the same as the size of the array, while, 
 *	for a random array, it's much more likely to be about a logarithm of that size.
 *  
 *  
 *  Q.C. Which algorithm has the best/worst scalability, i.e., the difference in performance time
 *  based on the input size? Please consider only input files with random order for this answer. 
 *  
 *  Ans: InsertionSort as the timing goes from 0.01 for 10 random all the way to 9.58 milliseconds for 1000 Random; an increase 
 *  of almost 10 milliseconds.
 *  
 *  
 *  Q.D. Did you observe any difference between iterative and recursive implementations of merge
 *  sort?
 *  
 *  Ans: Merge Iterative appears to take longer for all arrays EXCEPT 1000 nearly order where merge recursive takes
 *  0.5 milliseconds longer. 
 *  
 *  
 *  Q.E. Which algorithm is the fastest for each of the 7 input files? 
 *  
 *  Ans: 
 *  10 Random-------------->Insertion sort
 *  100 Random------------->Quick sort
 *  1000 Random------------>Quick sort
 *  1000 Few Unique-------->Merge recursive
 *  1000 Nearly Ordered---->Insertion sort
 *  1000 Reverse Order----->Merge recursive
 *  1000 Sorted------------>Insertion sort
 */
@RunWith(JUnit4.class)
public class SortComparisonTest
{
	public static final double [] EMPTY_ARRAY = {};
	
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new SortComparison();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
    	//SortComparison sort = new SortComparison();
    	double [] a = {};
    	assertEquals("Checking insertionSort on empty array", null, SortComparison.insertionSort(a));
    	assertEquals("Checking quickSort on empty array", null, SortComparison.quickSort(a));
    	assertEquals("Checking mergeSortIterative on empty array", null, SortComparison.mergeSortIterative(a));
    	assertEquals("Checking mergeSortRecursive on empty array", null, SortComparison.mergeSortRecursive(a));
    	assertEquals("Checking selectionSort on empty array", null, SortComparison.selectionSort(a));
    }
    
    public boolean isSorted(double [] a) {
    	for(int i = 0; i < a.length - 1; i++) {
    		if(a[i] > a[i+1])
    			return false;
    	}
    	return true;
    }
    @Test
    public void testInsertionSort() {
    	double[] a = {3,5,2,1,7,9,43,2.3,1.2};
    	double[] b = {-1, -7, -2, -89, -4.32, -9.56};
    	double[] c = {1800, 356, 14890, 234};
    	
    	assertEquals("Checking insertionSort on array of small positive numbers", true, isSorted(SortComparison.insertionSort(a)));
    	assertEquals("Checking insertionSort on array of negative numbers", true, isSorted(SortComparison.insertionSort(b)));
    	assertEquals("Checking insertionSort on array of large positive numbers", true, isSorted(SortComparison.insertionSort(c)));
    }
    
    @Test
    public void testQuickSort() {
    	double[] a = {3,5,2,1,7,9,43,2.3,1.2};
    	double[] b = {-1, -7, -2, -89, -4.32, -9.56};
    	double[] c = {1800, 356, 14890, 234};
    	
    	assertEquals("Checking quickSort on array of small positive numbers", true, isSorted(SortComparison.quickSort(a)));
    	assertEquals("Checking quickSort on array of negative numbers", true, isSorted(SortComparison.quickSort(b)));
    	assertEquals("Checking quickSort on array of large positive numbers", true, isSorted(SortComparison.quickSort(c)));
    }
    
    @Test
    public void testMergeSortIterative() {
    	double[] a = {3,5,2,1,7,9,43,2.3,1.2};
    	double[] b = {-1, -7, -2, -89, -4.32, -9.56};
    	double[] c = {1800, 356, 14890, 234};
    	
    	assertEquals("Checking mergeSortIterative on array of small positive numbers", true, isSorted(SortComparison.mergeSortIterative(a)));
    	assertEquals("Checking mergeSortIterative on array of negative numbers", true, isSorted(SortComparison.mergeSortIterative(b)));
    	assertEquals("Checking mergeSortIterative on array of large positive numbers", true, isSorted(SortComparison.mergeSortIterative(c)));
    }
    
    @Test
    public void testMergeSortRecursive() {
    	double[] a = {3,5,2,1,7,9,43,2.3,1.2};
    	double[] b = {-1, -7, -2, -89, -4.32, -9.56};
    	double[] c = {1800, 356, 14890, 234};
    	
    	assertEquals("Checking mergeSortRecursive on array of small positive numbers", true, isSorted(SortComparison.mergeSortRecursive(a)));
    	assertEquals("Checking mergeSortRecursive on array of negative numbers", true, isSorted(SortComparison.mergeSortRecursive(b)));
    	assertEquals("Checking mergeSortRecursive on array of large positive numbers", true, isSorted(SortComparison.mergeSortRecursive(c)));
    }
    
    @Test
    public void testSelectionSort() {
    	double[] a = {3,5,2,1,7,9,43,2.3,1.2};
    	double[] b = {-1, -7, -2, -89, -4.32, -9.56};
    	double[] c = {1800, 356, 14890, 234};
    	
    	assertEquals("Checking selectionSort on array of small positive numbers", true, isSorted(SortComparison.selectionSort(a)));
    	assertEquals("Checking selectionSort on array of negative numbers", true, isSorted(SortComparison.selectionSort(b)));
    	assertEquals("Checking selectionSort on array of large positive numbers", true, isSorted(SortComparison.selectionSort(c)));
    }
    // TODO: add more tests here. Each line of code and ech decision in Collinear.java should
    // be executed at least once from at least one test.

    // ----------------------------------------------------------
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     */
//  public static void main(String[] args) {
//	File numbers10 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbers10.txt");
//	File numbers100 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbers100.txt");
//	File numbers1000 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbers1000.txt");
//	File numbers1000Dup = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbers1000Duplicates.txt");
//	File numbersNearlyOrdered1000 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbersNearlyOrdered1000.txt");
//	File numbersReverse1000 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbersReverse1000.txt");
//	File numbersSorted1000 = new File("/Users/davynolan/Documents/COLLEGE DOCUMENTS/2nd Year CS/Algorithims and Data Structure/Term 2/Assignment 1/src/numbersSorted1000.txt");
//	
//	FileReader fileReader = null;
//	try {
//		fileReader = new FileReader(numbersSorted1000);
//	} catch (FileNotFoundException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}//file is read 
//    BufferedReader bufferedReader = new BufferedReader(fileReader );
//    String line;
//	ArrayList<Double> doubles = new ArrayList<Double>();
//	try {
//		while ((line = bufferedReader.readLine()) != null) 
//		{
//		    doubles.add(Double.parseDouble(line));        
//		}
//	} catch (NumberFormatException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	} catch (IOException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
//	
//	double [] arr = new double [doubles.size()];
//	for(int i = 0; i < doubles.size(); i++) {
//		arr[i] = doubles.get(i);
//		System.out.println(arr[i]);
//	}
//	
//	long startTime = System.nanoTime();
//	selectionSort(arr);
//	long endTime = System.nanoTime();
//
//	long duration = (endTime - startTime);  //divide by 1000000 to get milliseconds.
//	System.out.println();
//	System.out.println(duration);
//}

}