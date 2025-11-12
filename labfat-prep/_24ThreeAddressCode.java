
import java.util.*;

public class _24ThreeAddressCode {

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.print("Enter expression: ");
            String expr = sc.nextLine().replaceAll("\\s+", "");
            String postfix = infixToPostfix(expr);
            System.out.println("Postfix: " + postfix);
            generateTAC(postfix);
        }
    }

    static int prec(char c) {
        return switch (c) {
            case '+', '-' ->
                1;
            case '*', '/', '%' ->
                2;
            default ->
                0;
        };
    }

    static String infixToPostfix(String expr) {
        Stack<Character> st = new Stack<>();
        StringBuilder sb = new StringBuilder();
        for (char c : expr.toCharArray()) {
            if (Character.isLetterOrDigit(c)) {
                sb.append(c).append(' ');
            } else if (c == '(') {
                st.push(c);
            } else if (c == ')') {
                while (!st.isEmpty() && st.peek() != '(') {
                    sb.append(st.pop()).append(' ');
                }
                st.pop();
            } else {
                while (!st.isEmpty() && prec(st.peek()) >= prec(c)) {
                    sb.append(st.pop()).append(' ');
                }
                st.push(c);
            }
        }
        while (!st.isEmpty()) {
            sb.append(st.pop()).append(' ');
        }
        return sb.toString().trim();
    }

    static void generateTAC(String postfix) {
        Stack<String> st = new Stack<>();
        int temp = 1;
        for (String token : postfix.split(" ")) {
            if (token.matches("[a-zA-Z0-9]+")) {
                st.push(token);
            } else {
                String b = st.pop(), a = st.pop();
                String t = "t" + temp++;
                System.out.println(t + " = " + a + " " + token + " " + b);
                st.push(t);
            }
        }
        System.out.println("Result in " + st.peek());
    }
}
