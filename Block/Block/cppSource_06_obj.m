typedef int (^blk_t)(id obj);
blk_t blk;

void captureObject() {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    blk = [^(id obj){
        [array addObject:obj];
        NSLog(@"array count = %zd", array.count);
    } copy];
}

int main(int argc, const char * argv[]) {
    captureObject();
    blk([NSObject new]);
    blk([NSObject new]);
    blk([NSObject new]);
    
    return 0;
}



typedef int (*blk_t)(id obj);
blk_t blk;

struct __captureObject_block_impl_0 {
    struct __block_impl impl;
    struct __captureObject_block_desc_0* Desc;
    NSMutableArray *array;
    __captureObject_block_impl_0(void *fp, struct __captureObject_block_desc_0 *desc, NSMutableArray *_array, int flags=0) : array(_array) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};
static void __captureObject_block_func_0(struct __captureObject_block_impl_0 *__cself, id obj) {
    NSMutableArray *array = __cself->array; // bound by copy
    
    ((void (*)(id, SEL, ObjectType))(void *)objc_msgSend)((id)array, sel_registerName("addObject:"), (id)obj);
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_tm_cwd04fcs3w33gw2q8mbshvm80000gn_T_main_fc514c_mi_0, ((NSUInteger (*)(id, SEL))(void *)objc_msgSend)((id)array, sel_registerName("count")));
}
static void __captureObject_block_copy_0(struct __captureObject_block_impl_0*dst, struct __captureObject_block_impl_0*src) {_Block_object_assign((void*)&dst->array, (void*)src->array, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static void __captureObject_block_dispose_0(struct __captureObject_block_impl_0*src) {_Block_object_dispose((void*)src->array, 3/*BLOCK_FIELD_IS_OBJECT*/);}

static struct __captureObject_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __captureObject_block_impl_0*, struct __captureObject_block_impl_0*);
    void (*dispose)(struct __captureObject_block_impl_0*);
} __captureObject_block_desc_0_DATA = { 0, sizeof(struct __captureObject_block_impl_0), __captureObject_block_copy_0, __captureObject_block_dispose_0};

void captureObject() {
    NSMutableArray *array = ((NSMutableArray *(*)(id, SEL))(void *)objc_msgSend)((id)((NSMutableArray *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSMutableArray"), sel_registerName("alloc")), sel_registerName("init"));
    blk = (blk_t)((id (*)(id, SEL))(void *)objc_msgSend)((id)((void (*)(id))&__captureObject_block_impl_0((void *)__captureObject_block_func_0, &__captureObject_block_desc_0_DATA, array, 570425344)), sel_registerName("copy"));
}

int main(int argc, const char * argv[]) {
    captureObject();
    ((int (*)(__block_impl *, id))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk, ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("new")));
    ((int (*)(__block_impl *, id))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk, ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("new")));
    ((int (*)(__block_impl *, id))((__block_impl *)blk)->FuncPtr)((__block_impl *)blk, ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("new")));
    
    return 0;
}
