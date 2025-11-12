
import java.util.*;

public class _25GrammarChecker {

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.print("Enter string: ");
            String s = sc.nextLine();
            System.out.println(check(s) ? "Accepted" : "Rejected");
        }
    }

    static boolean check(String s) {
        int i = 0, n = s.length();
        while (i < n && s.charAt(i) == 'a') {
            i++;
        }
        if (i >= n || s.charAt(i) != 'c') {
            return false;
        }
        i++;
        while (i < n && s.charAt(i) == 'b') {
            i++;
        }
        return i < n && s.charAt(i) == 'd' && i == n - 1;
    }
}
