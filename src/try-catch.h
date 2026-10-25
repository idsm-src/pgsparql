/**
 * @file
 * PG_TRY() and PG_CATCH() blocks that recover from an error.
 *
 * The catch block switches back to the memory context of the try block and copies the error into @c errdata, whose
 * code it offers as @c sqlerrcode; unless it rethrows the error by PG_RE_THROW_EX(), the error is discarded at its
 * end. The blocks are used to turn the errors that a SPARQL function has to report as an expression error, such as
 * a value out of range, into a NULL result:
 *
 * @code
 * PG_TRY_EX();
 * {
 *     result = NullableFunctionCall1(numeric_int2, value);
 * }
 * PG_CATCH_EX();
 * {
 *     if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
 *         PG_RE_THROW_EX();
 *
 *     result = NULL_DATUM;
 * }
 * PG_END_TRY_EX();
 * @endcode
 */
#ifndef TRY_CATCH_H_
#define TRY_CATCH_H_


/**
 * Begins a try block and remembers the current memory context as @c ccxt.
 */
#define PG_TRY_EX()                                                 \
        do                                                          \
        {                                                           \
            MemoryContext ccxt = CurrentMemoryContext;              \
            PG_TRY();


/**
 * Ends the try block and begins the catch block, which runs in the memory context of the try block and declares
 * @c ecxt (the memory context of the error), @c errdata (a copy of the error) and @c sqlerrcode (its code).
 */
#define PG_CATCH_EX()                                               \
            PG_CATCH();                                             \
            {                                                       \
                MemoryContext ecxt = MemoryContextSwitchTo(ccxt);   \
                ErrorData *errdata = CopyErrorData();               \
                int sqlerrcode = errdata->sqlerrcode;


/**
 * Ends the catch block, which discards the error.
 */
#define PG_END_TRY_EX()                                             \
                pfree(errdata);                                     \
                FlushErrorState();                                  \
            }                                                       \
            PG_END_TRY();                                           \
        }                                                           \
        while(0);


/**
 * Rethrows the caught error from the catch block.
 */
#define PG_RE_THROW_EX()                                            \
        do                                                          \
        {                                                           \
            MemoryContextSwitchTo(ecxt);                            \
            PG_RE_THROW();                                          \
        }                                                           \
        while(0)

#endif /* TRY_CATCH_H_ */
