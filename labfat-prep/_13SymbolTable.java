// SymbolTable.java

import java.util.*;

class Symbol {

    String name, type;
    int scope;

    Symbol(String name, String type, int scope) {
        this.name = name;
        this.type = type;
        this.scope = scope;
    }

    @Override
    public String toString() {
        return String.format("%-10s %-10s %-5d", name, type, scope);
    }
}

public class _13SymbolTable {

    private static final Map<String, Symbol> table = new HashMap<>();

    public static void insert(String name, String type, int scope) {
        table.put(name, new Symbol(name, type, scope));
    }

    static Symbol lookup(String name) {
        return table.get(name);
    }

    public static void display() {
        System.out.println("Name       Type       Scope");
        for (Symbol s : table.values()) {
            System.out.println(s);
        }
    }

    public static void main(String[] args) {
        insert("x", "int", 0);
        insert("y", "float", 0);
        insert("x", "int", 1);

        Symbol s = lookup("x");
        System.out.println("Lookup result: " + s);
        display();
    }
}
