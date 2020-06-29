int main(int argc, const char * argv[]) {
    static int i = 12;
    void (^tempBlock)(void) = ^{
        printf("tempBlock string %zd\n", i);
    };
    i = 10;
    tempBlock();
    
    return 0;
}


// block 实现的结构体
struct __block_impl {
    void *isa;      // 实例对象
    int Flags;      // 按位承载block 的附加信息
    void *FuncPtr;  // 函数指针，指向Block 要执行的函数
    int Reserved;   // 保留变量
};

// block 实现的结构体，也是block 实现的入口
struct __main_block_impl_0 {
    
    struct __block_impl impl;           // block 实现的结构体变量
    struct __main_block_desc_0* Desc;   // 描述block 的结构体变量
    int *i;
    
    // __main_block_impl_0              // 结构体的构造函数，初始化 impl 和 Desc i
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int *_i, int flags=0) : i(_i) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// bolck 实现函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    int *i = __cself->i; // bound by copy
    
    printf("tempBlock string %zd\n", (*i));
}

// block 描述信息结构体
static struct __main_block_desc_0 {
    size_t reserved;               // 结构体信息保留字段
    size_t Block_size;             // 结构体大小
}  __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};

int main(int argc, const char * argv[]) {
    static int i = 12;
    
    void (*tempBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, &i));
    
    i = 10;
    
    (  (void (*)(__block_impl *)) ((__block_impl *)tempBlock)->FuncPtr )  ((__block_impl *)tempBlock);
    
    return 0;
}
