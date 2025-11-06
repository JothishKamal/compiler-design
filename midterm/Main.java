
import java.util.Stack;

public class Main {

    private static int precedence(char ch) {
        switch (ch) {
            case '+', '-' -> {
                return 1;
            }
            case '*', '/', '%' -> {
                return 2;
            }
            case '^' -> {
                return 3;
            }
        }
        return -1;
    }

    public static String infixToPostfix(String expression) {
        StringBuilder result = new StringBuilder();
        Stack<Character> stack = new Stack<>();

        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);

            if (Character.isLetterOrDigit(c)) {
                result.append(c);
            } else if (c == '(') {
                stack.push(c);
            } else if (c == ')') {
                while (!stack.isEmpty() && stack.peek() != '(') {
                    result.append(stack.pop());
                }
                stack.pop();
            } else {
                while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
                    result.append(stack.pop());
                }
                stack.push(c);
            }
        }

        while (!stack.isEmpty()) {
            result.append(stack.pop());
        }

        return result.toString();
    }

    public static int evaluatePostfix(String exp) {
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < exp.length(); i++) {
            char c = exp.charAt(i);

            if (Character.isDigit(c)) {
                stack.push(c - '0');
            } else {
                int val2 = stack.pop();
                int val1 = stack.pop();

                switch (c) {
                    case '+' ->
                        stack.push(val1 + val2);
                    case '-' ->
                        stack.push(val1 - val2);
                    case '*' ->
                        stack.push(val1 * val2);
                    case '/' ->
                        stack.push(val1 / val2);
                    case '%' ->
                        stack.push(val1 % val2);
                    case '^' ->
                        stack.push((int) Math.pow(val1, val2));
                }
            }
        }
        return stack.pop();
    }

    public static void main(String[] args) {
        String infix = "a*b+(c-d)";
        String postfix = infixToPostfix(infix);
        System.out.println("Infix Expression: " + infix);
        System.out.println("Postfix Expression: " + postfix);

        String numericInfix = "3+4*2";
        String numericPostfix = infixToPostfix(numericInfix);
        System.out.println("\nEvaluating " + numericInfix);
        System.out.println("Postfix: " + numericPostfix);
        System.out.println("Result: " + evaluatePostfix(numericPostfix));
    }
}
