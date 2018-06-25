#ifndef TRY_CATCH_H_
#define TRY_CATCH_H_


#define PG_TRY_EX()                                                 \
        do                                                          \
        {                                                           \
            MemoryContext ccxt = CurrentMemoryContext;              \
            PG_TRY();


#define PG_CATCH_EX()                                               \
            PG_CATCH();                                             \
            {                                                       \
                MemoryContext ecxt = MemoryContextSwitchTo(ccxt);   \
                ErrorData *errdata = CopyErrorData();               \
                int sqlerrcode = errdata->sqlerrcode;


#define PG_END_TRY_EX()                                             \
                pfree(errdata);                                     \
                FlushErrorState();                                  \
            }                                                       \
            PG_END_TRY();                                           \
        }                                                           \
        while(0);


#define PG_RE_THROW_EX()                                            \
        do                                                          \
        {                                                           \
            MemoryContextSwitchTo(ecxt);                            \
            PG_RE_THROW();                                          \
        }                                                           \
        while(0)

#endif /* TRY_CATCH_H_ */
