
import java.util.*;

public class _15LeftFactoring {

    public static void factor(String nonTerm, List<String> prods) {
        String prefix = commonPrefix(prods);
        if (prefix.isEmpty()) {
            System.out.println("No common prefix for " + nonTerm);
            return;
        }

        System.out.println(nonTerm + " -> " + prefix + nonTerm + "'");
        System.out.print(nonTerm + "' -> ");
        for (int i = 0; i < prods.size(); i++) {
            String rest = prods.get(i).substring(prefix.length());
            if (rest.isEmpty()) {
                rest = "ep";
            }
            System.out.print(rest + (i < prods.size() - 1 ? " | " : ""));
        }
        System.out.println();
    }

    private static String commonPrefix(List<String> list) {
        String prefix = list.get(0);
        for (String s : list) {
            int i = 0;
            while (i < prefix.length() && i < s.length() && prefix.charAt(i) == s.charAt(i)) {
                i++;
            }
            prefix = prefix.substring(0, i);
        }
        return prefix;
    }

    public static void main(String[] args) {
        factor("A", Arrays.asList("abc", "abd", "abe"));
    }
}
