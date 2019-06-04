
import java.util.LinkedList;

class WeightedGraph {

		int vertices;
		LinkedList<Edge>[] adjacencylist;

		WeightedGraph(int vertices) {
			this.vertices = vertices;
			adjacencylist = new LinkedList[vertices];
			// initialize adjacency lists for all the vertices
			for (int i = 0; i < vertices; i++) {
				adjacencylist[i] = new LinkedList<>();
			}
		}

		public void addEdge(int source, int destination, double weight) {
			Edge edge = new Edge(source, destination, weight);
			adjacencylist[source].addFirst(edge); // for directed graph
		}

		public void printGraph() {
			for (int i = 0; i < vertices; i++) {
				LinkedList<Edge> list = adjacencylist[i];
				for (int j = 0; j < list.size(); j++) {
					System.out.println("vertex-" + i + " is connected to " + list.get(j).destination + " with weight "
							+ list.get(j).weight);
				}
			}
		}
		
		public Boolean isEdge(int source, int dest) {
			for(int i=0; i<6; i++) {	
				LinkedList<Edge> list = adjacencylist[i];
				for(int j=0; j<list.size(); j++) {	
					if(list.get(j).getDestination() == dest && list.get(j).getSource() == source)
						return true;
				}
			}
			return false;
		}
		
		public double edgeWeight(int source, int dest) {
			if(isEdge(source,dest)) {
				for(int i=0; i<6; i++) {	
					LinkedList<Edge> list = adjacencylist[i];
					for(int j=0; j<list.size(); j++) {	
						if(list.get(j).getDestination() == dest && list.get(j).getSource() == source)
							return list.get(j).getWeight();
					}
				}
			}
			System.out.println("edgeWeight() returned Not a valid edge");
			return 0;
		}
	

	public static void main(String[] args) {
		int vertices = 6;
		WeightedGraph graph = new WeightedGraph(vertices);
		graph.addEdge(0, 1, 4);
		graph.addEdge(0, 2, 3);
		graph.addEdge(1, 3, 2);
		graph.addEdge(1, 2, 5);
		graph.addEdge(2, 3, 7);
		graph.addEdge(3, 4, 2);
		graph.addEdge(4, 0, 4);
		graph.addEdge(4, 1, 4);
		graph.addEdge(4, 5, 6);
		graph.printGraph();
		//System.out.println(graph.isEdge(0,1));
		System.out.println(graph.edgeWeight(0, 1));
		//Edge edge = new Edge(0, 1, 4);
		//LinkedList<Edge> list = graph.adjacencylist[0];
		
		//System.out.println(list.get(0).destination);
		//System.out.println(list.pop());
		//System.out.println(list.get(1).destination);
	}
}
