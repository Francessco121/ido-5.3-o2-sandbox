long long int g[3];

void int64_global_set(long long int c, long long int d, long long int e) {
    // 1. Stores a0-a3 on the stack
    // 2. Loads all 6 ints from the stack all at once
    // 3. Stores all 6 all at once
    g[0] = c;
    g[1] = d;
    g[2] = e;
}

long long int add_int64(long long int a, long long int b) {
    return a + b; // Interesting sltu
}

void int64_to_int64(long long int *a, long long int *b) {
    *b = *a; // lw, lw, then sw, sw
}

void const_to_int64(long long int *a, long long int *b) {
    *a = 4; // Stores are reversed...
    *b = 6; // Assignments are still in order
}

void arg_to_int64(long long int *a, int b) {
    *a = b; // Clever sra
}

void int64_by_value() {
    // Passes each half as a normal argument
    long long int a, b;
    add_int64(a, b);
}

void int64_array_loop() {
    // Stores are still reversed
    long long int a[2];

    int i;
    for (i = 0; i < 2; i++) {
        a[i] = i;
    }
}

int int64_loop() {
    // i is allocated on the stack, despite there being plenty of unused temp registers.
    // Also, with c being declared before i, an extra unused 8 bytes of stack is
    // allocated (4 bytes + padding to 64-bit align it?). Moving c after i will remove
    // the extra allocated bytes. 
    int c = 0;
    long long int i;
    for (i = 0; i < 10; i++) {
        c += 1;
    }

    return c;
}

