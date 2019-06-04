import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.TreeMap;


/*
 * @author Davy Nolan
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
 * This class implements the competition using Floyd-Warshall algorithm
 */

public class CompetitionFloydWarshall {

    /**
     * @param filename: A filename containing the details of the city road network
     * @param sA, sB, sC: speeds for 3 contestants
     */

    private static final double INFINITY = Integer.MAX_VALUE / 2;   

    double cityMap[][];    

    int speedA;
    int speedB;
    int speedC;
    int N;
    int S;     
    int minSpeed;

    String filename;

    boolean validFile = true;

    CompetitionFloydWarshall (String filename, int sA, int sB, int sC){
        this.filename = filename;
        this.speedA = sA;
        this.speedB = sB;
        this.speedC = sC;
        
        minSpeed = Math.min(sA, sB);
        minSpeed = Math.min(minSpeed, sC);

        try {
            BufferedReader br = new BufferedReader(new FileReader(filename));
            N = Integer.parseInt(br.readLine());
            S = Integer.parseInt(br.readLine());
            if(N == 0 || S == 0 ){
                validFile = false;
            }
            if(filename == null){
                validFile = false;
                minSpeed = -1;
            }
            else{
                cityMap = new double[N][S];
                for (int i = 0; i < N; i++){
                    for (int j = 0; j < N; j++){
                        cityMap[i][j] = INFINITY;
                    }
                }
                String line = br.readLine();
                while((line != null)){
                    String[] lSplit = line.trim().split(" ");
                    cityMap[Integer.parseInt(lSplit[0])][Integer.parseInt(lSplit[1])] = Double.parseDouble(lSplit[2]);
                    line = br.readLine();
                }
                br.close();
            }
        }catch (Exception e){
            validFile = false;
            minSpeed = -1;
        }
        
        
    }

   

    /**
     * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public int timeRequiredforCompetition(){
        if((speedA > 100 || speedA < 50) || (speedB > 100 || speedB < 50) || (speedC > 100 || speedC < 50)){
            return -1;
        }

        if(!validFile){
            return -1;
        }
 
        for (int k = 0; k < N; k++){
            for (int i = 0; i < N; i++){
                for (int j = 0; j < N; j++){
                    if(cityMap[k][j] + cityMap[i][k]  < cityMap[i][j]){
                        cityMap[i][j] = cityMap[k][j] + cityMap[i][k];
                    }
                }
            }
        }
        double maxDist = biggestDist();
        if(maxDist == INFINITY){
            return -1;
        }
        maxDist = maxDist * 1000; 

        return (int) Math.ceil(maxDist / minSpeed);
    }

    private double biggestDist(){
        double maxDist = -1;
        for (int i = 0; i < N; i++){
            for (int j = 0; j < N; j++){
                if(cityMap[i][j] > maxDist && i != j){
                    maxDist = cityMap[i][j];
                }
            }
        }
        return maxDist;
    }

//    public static void main(String [] args) {
//    	CompetitionFloydWarshall comp = new CompetitionFloydWarshall("tinyEWDhhh.txt", 50, 60, 70);
//    	System.out.println(comp.timeRequiredforCompetition());
//    }
}