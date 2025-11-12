
import java.util.*;

public class _26InfixToPostfixEval {

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.print("Enter expression: ");
            String expr = sc.nextLine().replaceAll("\\s+", "");
            String postfix = infixToPostfix(expr);
            System.out.println("Postfix: " + postfix);
            System.out.println("Value: " + evalPostfix(postfix));
        }
    }

    static int prec(char c) {
        return switch (c) {
            case '+', '-' ->
                1;
            case '*', '/' ->
                2;
            default ->
                0;
        };
    }

    static String infixToPostfix(String expr) {
        Stack<Character> st = new Stack<>();
        StringBuilder sb = new StringBuilder();
        for (char c : expr.toCharArray()) {
            if (Character.isDigit(c)) {
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

    static int evalPostfix(String post) {
        Stack<Integer> st = new Stack<>();
        for (String token : post.split(" ")) {
            if (token.matches("\\d+")) {
                st.push(Integer.valueOf(token));
            } else {
                int b = st.pop(), a = st.pop();
                switch (token.charAt(0)) {
                    case '+' ->
                        st.push(a + b);
                    case '-' ->
                        st.push(a - b);
                    case '*' ->
                        st.push(a * b);
                    case '/' ->
                        st.push(a / b);
                }
            }
        }
        return st.pop();
    }
}
