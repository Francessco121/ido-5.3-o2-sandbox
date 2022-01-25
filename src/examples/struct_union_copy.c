typedef struct {
    int a, b;
} Struct;

typedef union {
    int a;
    Struct b;
} Union;

void struct_copy() {
    Struct a, b;
    a = b;
}

void union_copy() {
    Union a, b;
    a = b;
}
