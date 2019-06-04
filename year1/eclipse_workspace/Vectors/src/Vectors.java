
public class Vectors {


	public static void main(String[] args) {

	}

	// Returns the magnitude of the passed vector (Euclidean distance
	// from the origin)
	public static double magnitude( double[] vector )
	{
		if (vector == null)
		{
			return 0.0;
		}
		else
		{
			double sumOfSquares = 0.0;
			for (int index=0; index<vector.length; index++)
			{
				sumOfSquares += vector[index]*vector[index];
			}
			return Math.sqrt(sumOfSquares);
		}
	}

	// Alters the passed vector so that it is a unit vector (length 1.0)
	// in the same direction as the passed vector.
	public static void normalise( double[] vector ) throws IllegalArgumentException
	{
		if ( vector!=null )
		{
			double vectorLength = magnitude( vector );
			if (vectorLength != 0.0)
				for (int index=0; index<vector.length; index++ )
					vector[index]/=vectorLength;
		}
	}
	
	// Computes the dot product of the two passed vectors.  The dot product
	// is the sum of the products of all corresponding elements.  This function
	// will through an exception if either vector is null or if the lengths of
	// the vectors are different.
	public static double dotProduct( double[] vector1, double[] vector2 ) throws IllegalArgumentException
	{
		if ((vector1 == null) || (vector1 == null) || (vector1.length != vector2.length))
		{
			throw new IllegalArgumentException();
		}
		double dotProductSoFar = 0.0;
		for (int index=0; index<vector1.length; index++)
		{
			dotProductSoFar += vector1[index]*vector2[index]; 
		}
		return dotProductSoFar;
	}

	// Adds the two passed vectors (i.e. adds the corresponding elements).  This
	// function will through an exception if either vector is null or if the 
	// lengths of the vectors are different.
	public static double[] add( double[] vector1, double[] vector2 ) throws IllegalArgumentException
	{
		if ((vector1 == null) || (vector1 == null) || (vector1.length != vector2.length))
		{
			throw new IllegalArgumentException();
		}
		double[] result = new double[vector1.length];
		for (int index=0; index<vector1.length; index++)
		{
			result[index]= vector1[index] + vector2[index];
		}
		return result;
	}

		

	

}
