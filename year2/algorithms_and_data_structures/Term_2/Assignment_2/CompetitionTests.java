import static org.junit.Assert.assertEquals;

import org.junit.Test;
/**
 * 
 * @author Davy Nolan
 *
 *	1. Justify the choice of the data structures used in CompetitionDijkstra and CompetitionFloydWarshall:
 *	A. CompetitionDijkstra - I used a Tree map to store the edges and intersections of the city map with <Integer, Node>. Node is
 *		a private class containing an id, a distance, an array list of paths and a function to add an adjacent node. The tree map
 *		data structure made it easy to manage the data and store it as a directed graph.
 *
 *	   CompetitionFloydWarshall - I used a 2d array to store the map of the city with [source][destination]. It was more efficient 
 *		to use a 2d array to get the shortest path using the floyd warshall method rather than using a tree map so that is why I used
 *		2 different data structures for the 2 classes.
 *
 *
 *	2. Explain theoretical differences in the performance of Dijkstra and Floyd-Warshall algorithms in the given problem. Also explain 
 *	   how would their relative performance be affected by the density of the graph. Which would you choose in which set of circumstances 
 *	   and why?
 *	A. Dijkstra's Algorithm is used only when you have a single source and you want to know the smallest path from one node to another.
 *	   This proved to be quite tedious as in this example we were trying to find the smallest path from every node to every node (i.e. 
 *	   any node could be the source node and any node could be the destination node). Therefore the performance is quite slow.
 *
 *	   Floyd Warshall's Algorithm is used when any of all the nodes can be a source, so you want the shortest distance to reach any 
 *	   destination node from any source node. This only fails when there are negative cycles. This algorithm therefore suited the
 *	   requirements for this program better as we were we were trying to find the smallest path from every node to every node (i.e. 
 *	   any node could be the source node and any node could be the destination node). That is why I would choose this algorithm over
 *	   Dijkstra's.
 *	   
 *
 */





public class CompetitionTests {
	@Test
    public void testDijkstraConstructor() {
        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tinyEWD.txt", 50, 80, 60);
        assertEquals("constructor failed with valid input", dijkstra.minSpeed, 50);
    }

    @Test
    public void testDijkstraAlgorithm() {
    	CompetitionDijkstra dijkstra = new CompetitionDijkstra("tinyEWD.txt", 50,80,60);
        assertEquals("Test competition with tinyEWD", 38, dijkstra.timeRequiredforCompetition());
        
        CompetitionDijkstra dijkstra1 = new CompetitionDijkstra("TINYsdfgdfgEWD.txt", 50, 80, 60);
        assertEquals("Test competition with invalid filename", -1, dijkstra1.timeRequiredforCompetition());

        CompetitionDijkstra dijkstra2 = new CompetitionDijkstra("tinyEWD.txt", -1, 80, 60);
        assertEquals("Test competition with negative speed", -1, dijkstra2.timeRequiredforCompetition());

        CompetitionDijkstra dijkstra3 = new CompetitionDijkstra(null, 50, 80, 60);
        assertEquals("Test competition with null filename", -1, dijkstra3.timeRequiredforCompetition());

        CompetitionDijkstra dijkstra4 = new CompetitionDijkstra("tinyEWD-2.txt", 50, 80, 60);
        assertEquals("Test competition with node that doesn't have path", -1, dijkstra4.timeRequiredforCompetition());

        CompetitionDijkstra dijkstra5 = new CompetitionDijkstra("input-J.txt", 98, 70, 84);
        assertEquals("Test competition with speeds fine?", -1, dijkstra5.timeRequiredforCompetition());

        CompetitionDijkstra dijkstra6 = new CompetitionDijkstra("tinyEWD.txt", 5, 80, 60);
        assertEquals("Test competition with less than 50 speed", -1, dijkstra6.timeRequiredforCompetition());
    }



    @Test
    public void testFloydWarshallConstuctor() {
        CompetitionFloydWarshall floyWar = new CompetitionFloydWarshall("input-I.txt", 60,70,84);
        assertEquals("constructor failed with valid input", floyWar.minSpeed, 60);
    }

    @Test
    public void testFloydWarshallAlgorithm() {
        CompetitionFloydWarshall floyWar = new CompetitionFloydWarshall("tinyEWD.txt", 50,80,60);
        assertEquals("Test competition with TINYEWD", 38, floyWar.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar1 = new CompetitionFloydWarshall("TINYsdfgdfgEWD.txt", 50, 80, 60);
        assertEquals("Test competition with invalid filename", -1, floyWar1.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar2 = new CompetitionFloydWarshall("tinyEWD.txt", -1, 80, 60);
        assertEquals("Test competition with negative speed", -1, floyWar2.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar3 = new CompetitionFloydWarshall(null, 50, 80, 60);
        assertEquals("Test competition with null filename", -1, floyWar3.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar4 = new CompetitionFloydWarshall("tinyEWD-2.txt", 50, 80, 60);
        assertEquals("Test competition with node that doesn't have path", -1, floyWar4.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar5 = new CompetitionFloydWarshall("input-J.txt", 98, 70, 84);
        assertEquals("Smile", -1, floyWar5.timeRequiredforCompetition());

        CompetitionFloydWarshall floyWar6 = new CompetitionFloydWarshall("tinyEWD.txt", 5, 80, 60);
        assertEquals("Test competition with less than 50 speed", -1, floyWar6.timeRequiredforCompetition());
    }

    
}
