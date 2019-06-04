import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;
import java.util.TreeMap;


/*
 * @author Davy Nolan
 * 
 * 
 * 
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Dijkstra's algorithm
 */
class CompetitionDijkstra {

    int speedA; 
    int speedB; 
    int speedC;
    int N;
    int S;
    int minSpeed;

    String filename;

    private TreeMap<Integer, Node> cityMap;

    /**
     * @param filename: A filename containing the details of the city road network
     * @param sA,sB,sC: speeds for 3 contestants
     */
    CompetitionDijkstra(String filename, int sA, int sB, int sC) {
        this.filename = filename;
        this.speedA = sA;
        this.speedB = sB;
        this.speedC = sC;
        minSpeed = Math.min(sA, sB);
        minSpeed = Math.min(minSpeed, sC);
        if (filename == null) minSpeed = -1;
        cityMap = new TreeMap<>();

        try {
            Scanner sc = new Scanner(new FileInputStream(filename));
            this.N = sc.nextInt();
            this.S = sc.nextInt();
            for (int i = 0; i < S; i++) {
                if (sc.hasNext()) {
                    int src = sc.nextInt();
                    int dest = sc.nextInt();
                    double length = sc.nextDouble() * 1000;
                    
                    Node srcNode;
                    Node destNode;

                    if (cityMap.get(src) == null) {
                        srcNode = new Node(src);
                        cityMap.put(src, srcNode);
                    } 
                    else srcNode = cityMap.get(src);

                    if (cityMap.get(dest) == null) {
                        destNode = new Node(dest);
                        cityMap.put(dest, destNode);
                    } 
                    else destNode = cityMap.get(dest);

                    srcNode.addAdjacent(destNode, length);
                } 
                else {
                    break;
                }
            }
        } catch (Exception e) {
            minSpeed = -1;
        }
    }

//    private void initialise() {
//
//        slowest = Math.min(sA, sB);
//        slowest = Math.min(slowest, sC);
//        if (filename == null) slowest = -1;
//        map = new TreeMap<>();
//
//        // initialise the TreeMap and the adjacency lists of each node
//        try {
//            Scanner scanner = new Scanner(new FileInputStream(filename));
//            int V = scanner.nextInt();
//            int S = scanner.nextInt();
//            for (int i = 0; i < S; i++) {
//                if (scanner.hasNext()) {
//                    int intersection1 = scanner.nextInt();
//                    int intersection2 = scanner.nextInt();
//                    double length = scanner.nextDouble() * 1000;
//                    Node node1, node2;
//
//                    if (map.get(intersection1) == null) {
//                        node1 = new Node(intersection1);
//                        map.put(intersection1, node1);
//                    } else node1 = map.get(intersection1);
//
//                    if (map.get(intersection2) == null) {
//                        node2 = new Node(intersection2);
//                        map.put(intersection2, node2);
//                    } else node2 = map.get(intersection2);
//
//                    node1.addAdjacent(node2, length);
//                } else {
//                    break;
//                }
//            }
//        } catch (Exception e) {
//            slowest = -1;
//        }
//    }

    private double smallestDist(int start) {

        LinkedList<Node> nodes = new LinkedList<>();
        for (Node node : cityMap.values()) {
            if (node.nodeNo == start) node.dist = 0;
            else node.dist = Double.MAX_VALUE;
            nodes.add(node);
        }

        for (int i = 0; i < cityMap.values().size(); i++) {
            for (Node node : nodes) {
                for (Path path : node.pathList) {
                    double newCost = node.dist + path.dist;
                    if (newCost < path.dest.dist) {
                        path.dest.dist = newCost;
                    }
                }
            }
        }

        double max = Double.MIN_VALUE;
        for (Node node : cityMap.values()) {
            if (node.dist == Double.MAX_VALUE) return node.dist;
            else if (node.dist > max)
                max = node.dist;
        }
        return max;
    }

    /**
     * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public int timeRequiredforCompetition() {
        if((speedA > 100 || speedA < 50) || (speedB > 100 || speedB < 50) || (speedC > 100 || speedC < 50)){
            return -1;
        }

        if (cityMap.size() == 0 || minSpeed <= 0) 
        	return -1;
        double maxDist = -1;
        for (Node node : cityMap.values()) {
            double dist = smallestDist(node.nodeNo);
            if (dist == Double.MAX_VALUE) 
            	return -1;
            maxDist = Math.max(maxDist, dist);
        }
        return (int) Math.ceil(maxDist / minSpeed);
    }

    private class Node {
        double dist = Double.MAX_VALUE;
        int nodeNo;
        ArrayList<Path> pathList = new ArrayList<>();

        Node(int id) {
            this.nodeNo = id;
        }

        void addAdjacent(Node node, double dist) {
            pathList.add(new Path(node, dist));
        }
    }

    private class Path {
        Node dest;
        double dist;

        Path(Node dest, double dist) {
            this.dest = dest;
            this.dist = dist;
        }
    }


//class CompetitionDijkstra {
//	
//	int N;
//	int S;
//    int speedA;
//    int speedB;
//    int speedC;
//    int slowest;
//
//    String filename;
//    boolean validFile = true;
//    private TreeMap<Integer, Node> cityMap;
//
//    /**
//     * @param filename: A filename containing the details of the city road network
//     * @param sA,sB,sC: speeds for 3 contestants
//     */
//    CompetitionDijkstra(String filename, int sA, int sB, int sC) {
//        this.filename = filename;
//        this.speedA = sA;
//        this.speedB = sB;
//        this.speedC = sC;
//        //this.initialise();
//        slowest = Math.min(sA, sB);
//        slowest = Math.min(slowest, sC);
//        if (filename == null) slowest = -1;
//        cityMap = new TreeMap<>();
//        
//        try {
//            BufferedReader br = new BufferedReader(new FileReader(filename));
//            N = Integer.parseInt(br.readLine());
//            S = Integer.parseInt(br.readLine());
//            if(N == 0 || S == 0 ){
//                validFile = false;
//            }
//            if(filename == null){
//                validFile = false;
//                slowest = -1;
//            }
//            else{
//   
//            	
//                String line = br.readLine();
//                
//                String[] edgeInfoString = line.split("\\s+");
//				int source = Integer.parseInt(edgeInfoString[0]); 
//				int dest = Integer.parseInt(edgeInfoString[1]); 
//				double weight = Double.parseDouble(edgeInfoString[2]) * 1000;
//                Node node1, node2;
//
//                if (cityMap.get(source) == null) {
//                    node1 = new Node(source);
//                    cityMap.put(source, node1);
//                } else node1 = cityMap.get(source);
//
//                if (cityMap.get(dest) == null) {
//                    node2 = new Node(dest);
//                    cityMap.put(dest, node2);
//                } else node2 = cityMap.get(dest);
//
//                node1.addAdjacent(node2, weight);
//                
//
//                br.close();
//            }
//        }catch (Exception e){
//            validFile = false;
//            slowest = -1;
//        }
//        
//        
//        
//    }
//
//
//    private double smallestDistance(int source) {
//
//        LinkedList<Node> nodeList = new LinkedList<>();
//        for (Node node : cityMap.values()) {
//            if (node.id == source) node.dist = 0;
//            else node.dist = Double.MAX_VALUE;
//            nodeList.add(node);
//        }
//
//        for (int i = 0; i < cityMap.values().size(); i++) {
//            for (Node node : nodeList) {
//                for (Path path : node.pathList) {
//                    double newCost = node.dist + path.dist;
//                    if (newCost < path.dest.dist) {
//                        path.dest.dist = newCost;
//                    }
//                }
//            }
//        }
//        double max = Double.MIN_VALUE;
//        for (Node node : cityMap.values()) {
//            if (node.dist == Double.MAX_VALUE) return node.dist;
//            else if (node.dist > max)
//                max = node.dist;
//        }
//        return max;
//    }
//    
//
//    /**
//     * @return int: minimum minutes that will pass before the three contestants can meet
//     */
//    public int timeRequiredforCompetition() {
//        if((speedA > 100 || speedA < 50) || (speedB > 100 || speedB < 50) || (speedC > 100 || speedC < 50)){
//            return -1;
//        }
//
//        if (cityMap.size() == 0 || slowest <= 0) 
//        	return -1;
//        double maxDist = -1;
//        
//        for (Node node : cityMap.values()) {
//            double dist = smallestDistance(node.id);
//        	
//            if (dist == Double.MAX_VALUE) 
//            	return -1;
//            maxDist = Math.max(maxDist, dist);
//        }
//        return (int) Math.ceil(maxDist / slowest);
//    }
//
//    private class Node {
//        int id;
//        double dist = Double.MAX_VALUE; 
//        ArrayList<Path> pathList = new ArrayList<>();
//
//        Node(int id) {
//            this.id = id;
//        }
//
//        void addAdjacent(Node node, double dist) {
//            pathList.add(new Path(node, dist));
//        }
//    }
//
//    private class Path {
//        Node dest;
//        double dist;
//
//        Path(Node dest, double dist) {
//            this.dest = dest;
//            this.dist = dist;
//        }
//    }
    
    public static void main(String [] args) {
    	CompetitionDijkstra comp = new CompetitionDijkstra("tinyEWD.txt", 50,80,60);
    	System.out.println(comp.timeRequiredforCompetition());
    }
}
