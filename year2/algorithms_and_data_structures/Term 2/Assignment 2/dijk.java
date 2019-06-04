public class CompetitionDijkstra {

	private int N;
	private int S;
	private int speedA;
	private int speedB;
	private int speedC;
	//private double [][] cityMap;
	private WeightedGraph graph;
	/**
	 * @param filename: A filename containing the details of the city road network
	 * @param sA, sB, sC: speeds for 3 contestants
	 */
	
	CompetitionDijkstra(String filename, int sA, int sB, int sC) {
		this.speedA = sA;
		this.speedB = sB;
		this.speedC = sC;
		
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(filename));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String line;
		String [] edgeInfoString = new String[3];
		int [] edgeInfoInt = new int[2];
		int source = 0;
		int dest = 0;
		double weight = 0;
		int lineCount = 1;
		try {
			while ((line = reader.readLine()) != null) {
				if (lineCount == 1) {
					this.N = Integer.parseInt(line);
					//cityMap = new double [this.N][this.N];
					graph = new WeightedGraph(this.N);
				}
				if (lineCount == 2) {
					this.S = Integer.parseInt(line);
				}
				if(lineCount > 2) {
					edgeInfoString = line.split("\\s+");
					source = Integer.parseInt(edgeInfoString[0]); 
					dest = Integer.parseInt(edgeInfoString[1]); 
					weight = Double.parseDouble(edgeInfoString[2]);
					//cityMap[edgeInfoInt[0]][edgeInfoInt[1]] = Double.parseDouble(edgeInfoString[2]);
					graph.addEdge(source, dest, weight);
				}
				
				lineCount++;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @return int: minimum minutes that will pass before the three contestants can
	 *         meet
	 */
	public int timeRequiredforCompetition() {
		double [][] results = new double [N][N];
		for(int startVertex = 0; startVertex < N; startVertex++) {
			for(int dest = 0; dest< N; dest++) {
				results[startVertex][dest] = dijkstra(startVertex)[dest];
			}
			
		}
		return -1;
	}
	
	private double getLowestCosts(int start) {
		
	}
//	
//	public double [][] getResults(){
//		double [][] results = new double [N][N];
//		for(int startVertex = 0; startVertex < N; startVertex++) {
//			for(int dest = 0; dest< N; dest++) {
//				results[startVertex][dest] = dijkstra(startVertex)[dest];
//			}
//			
//		}
//		return results;
//	}
//	
//	public int minDistance(double[] dist, Boolean sptSet[]) {
//		// Initialize min value ~
//        double min = Double.MAX_VALUE;
//        int min_index=-1; 
//  
//        for (int v = 0; v < N; v++) 
//            if (sptSet[v] == false && dist[v] <= min){ 
//                min = dist[v]; 
//                min_index = v; 
//            } 
//  
//        return min_index; 
//	}
//	
//	void printSolution(double dist[], int n) {
//		System.out.println("Vertex    Distance from Source");
//		for(int i=0; i<N; i++) {
//			System.out.println(i + " 		 " + dist[i]);
//		}
//	}
//	
//	
//	public double [] dijkstra(int src) {
//		System.out.println("Source = "+src);
//		double dist[] = new double[N];
//		
//		Boolean sptSet[] = new Boolean[N];
//		
//		for(int i=0; i<N; i++) {
//			dist[i] = Double.MAX_VALUE;
//			sptSet[i] = false;
//		}
//		
//		dist[src] = 0;
//		
//		for(int count = 0; count < N-1; count++) {
//			int u = minDistance(dist, sptSet);
//			sptSet[u] = true;
//			
//			for(int v=0; v<N; v++) {
//				if(!sptSet[v] && graph.isEdge(u, v) && dist[u] != Double.MAX_VALUE && dist[u] + graph.edgeWeight(u, v) < dist[v])
//					dist[v] = dist[u] + graph.edgeWeight(u, v);
//			}
//		}
//		printSolution(dist, N);
//		return dist;
//	}

	 
	

	public static void main(String[] args) {
		CompetitionDijkstra comp = new CompetitionDijkstra("tinyEWD.txt", 1, 2, 3);
		comp.graph.printGraph();
		int src;
		int dest;
		double weight;
		double [][] res = comp.getResults();
		

		
	}
}