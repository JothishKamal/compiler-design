
import java.util.*;

public class _14LeftRecursion {

    public static void eliminate(String nonTerm, List<String> productions) {
        List<String> alpha = new ArrayList<>();
        List<String> beta = new ArrayList<>();

        for (String p : productions) {
            if (p.startsWith(nonTerm)) {
                alpha.add(p.substring(nonTerm.length()));
            } else {
                beta.add(p);
            }
        }

        if (alpha.isEmpty()) {
            System.out.println("No left recursion for " + nonTerm);
            return;
        }

        System.out.println(nonTerm + " -> ");
        for (int i = 0; i < beta.size(); i++) {
            System.out.println("    " + beta.get(i) + nonTerm + "'");
        }
        System.out.println(nonTerm + "' -> ");
        for (int i = 0; i < alpha.size(); i++) {
            System.out.println("    " + alpha.get(i) + nonTerm + "'");
        }
        System.out.println("    ep");
    }

    public static void main(String[] args) {
        eliminate("A", Arrays.asList("Aa", "Ab", "c", "d"));
    }
}
