import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

// -------------------------------------------------------------------------

/**
 *  This class contains static methods that implementing sorting of an array of numbers
 *  using different sort algorithms.
 *
 *  @author
 *  @version HT 2019
 */

 class SortComparison {
    /**
     * Sorts an array of doubles using InsertionSort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order.
     *
     */
    static double [] insertionSort (double a[]){
    	if(a.length > 0) {
	    	double n = a.length; 
	        for (int i=1; i<n; ++i) 
	        { 
	            double key = a[i]; 
	            int j = i-1; 
	            while (j>=0 && a[j] > key) 
	            { 
	                a[j+1] = a[j]; 
	                j = j-1; 
	            } 
	            a[j+1] = key; 
	        } 
	        return a;
    	}
    	return null;
    }//end insertionsort

    /**
     * Sorts an array of doubles using Quick Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static int partition(double a[], double low, double high) 
    { 
        double pivot = a[(int) high];  
        int i = (int) (low-1); 
        for (int j=(int) low; j<high; j++) 
        { 
            if (a[j] <= pivot) 
            { 
                i++; 
                double temp = a[i]; 
                a[i] = a[j]; 
                a[j] = temp; 
            } 
        } 
        double temp = a[i+1]; 
        a[i+1] = a[(int) high]; 
        a[(int) high] = temp; 
  
        return i+1; 
    } 
    
    static double [] quickSort2 (double a[], double low, double high) 
    { 
    	if(a.length > 0) {
	        if (low < high) 
	        { 
	            double part = partition(a, low, high); 
	            a = quickSort2(a, low, part-1); 
	            a = quickSort2(a, part+1, high); 
	        }
			return a; 
    	}
    	return null;
    } 
    
    static double [] quickSort (double a[]) {
    	double low = 0;
    	double high = a.length - 1;
    	return quickSort2(a, low, high);
    }

    /**
     * Sorts an array of doubles using Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    /**
     * Sorts an array of doubles using iterative implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */

    static double[] mergeSortIterative (double[] a) {
    	if(a.length > 0) {
	        if(a.length > 1) 
	        { 
	            int mid = a.length / 2; 
	  
	            // Split left part 
	            double[] left = new double[mid]; 
	            for(int i = 0; i < mid; i++) 
	            { 
	                left[i] = a[i]; 
	            } 
	              
	            // Split right part 
	            double[] right = new double[a.length - mid]; 
	            for(int i = mid; i < a.length; i++) 
	            { 
	                right[i - mid] = a[i]; 
	            } 
	            mergeSortIterative(left); 
	            mergeSortIterative(right); 
	  
	            int i = 0; 
	            int j = 0; 
	            int k = 0; 
	  
	            // Merge left and right arrays 
	            while(i < left.length && j < right.length) 
	            { 
	                if(left[i] < right[j]) 
	                { 
	                    a[k] = left[i]; 
	                    i++; 
	                } 
	                else
	                { 
	                    a[k] = right[j]; 
	                    j++; 
	                } 
	                k++; 
	            } 
	            // Collect remaining elements 
	            while(i < left.length) 
	            { 
	                a[k] = left[i]; 
	                i++; 
	                k++; 
	            } 
	            while(j < right.length) 
	            { 
	                a[k] = right[j]; 
	                j++; 
	                k++; 
	            } 
	        } 
	        return a;
    	}
    	return null;
      } 
    
    
    
    /**
     * Sorts an array of doubles using recursive implementation of Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     *
     * @param a: An unsorted array of doubles.
     * @return after the method returns, the array must be in ascending sorted order.
     */
    static double[] mergeSort(double [] a, int lo, int hi) {
        int N = hi - lo;        // number of elements to sort

        // 0- or 1-element file, so we're done
        if (N <= 1) return a; 

        // recursively sort left and right halves
        int mid = lo + N / 2; 
        mergeSort(a, lo, mid); 
        mergeSort(a, mid, hi); 

        // merge two sorted subarrays into auxiliary array aux
        double[] aux = new double[N];
        int i = lo, j = mid;
        for (int k = 0; k < N; k++) {
          if      (i == mid)    { aux[k] = a[j]; j++; }
          else if (j == hi)     { aux[k] = a[i]; i++; }
          else if (a[j] < a[i]) { aux[k] = a[j]; j++; }
          else                  { aux[k] = a[i]; i++; }
        }

        // copy back into a
        for (int k = 0; k < N; k++) {
          a[lo + k] = aux[k]; 
        }
        return a;
      } 
    
    static double[] mergeSortRecursive (double[] a) {
    	if(a.length > 0) {
    		return mergeSort(a, 0, a.length);
    	}
    	return null;
    }
    	
    
    /**
     * Sorts an array of doubles using Selection Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] selectionSort (double a[]){
    	if(a.length > 0) {
    		int n = a.length; 
	        for (int i = 0; i < n-1; i++) 
	        { 
	        	int min = i; 
	            for (int j = i+1; j < n; j++) 
	                if (a[j] < a[min]) min = j; 
	            double temp = a[min]; 
	            a[min] = a[i]; 
	            a[i] = temp; 
	        } 
	        return a;
    	}
    	return null;
    }

   




 }//end class
