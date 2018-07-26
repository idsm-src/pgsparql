#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "xsd.h"


PG_FUNCTION_INFO_V1(ebv_rdfbox);
Datum ebv_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = BoolGetDatum(((RdfBoxBoolean *) box)->value);
            break;

        case XSD_SHORT:
            result = BoolGetDatum(((RdfBoxShort *) box)->value != 0);
            break;

        case XSD_INT:
            result = BoolGetDatum(((RdfBoxInt *) box)->value != 0);
            break;

        case XSD_LONG:
            result = BoolGetDatum(((RdfBoxLong *) box)->value != 0);
            break;

        case XSD_FLOAT:
            result = BoolGetDatum(!isnanf(((RdfBoxFloat *) box)->value) && ((RdfBoxFloat *) box)->value != 0);
            break;

        case XSD_DOUBLE:
            result = BoolGetDatum(!isnan(((RdfBoxDouble *) box)->value) && ((RdfBoxDouble *) box)->value != 0);
            break;

        case XSD_INTEGER:
        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric zero = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(0)));

            result = DirectFunctionCall2(numeric_ne, NumericGetDatum(value), NumericGetDatum(zero));

            pfree(zero);
            break;
        }

        case XSD_STRING:
            result = BoolGetDatum(VARSIZE((VarChar *) ((RdfBoxString *) box)->value) > VARHDRSZ);
            break;

        case TYPED_LITERAL:
        {
            VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
            text *type = (text *) (((RdfBoxTypedLiteral *) box)->value + VARSIZE(value));
            char *cstring = text_to_cstring(type);

            if(strcmp(cstring, XSD_BOOLEAN_IRI) == 0 ||
                    strcmp(cstring, XSD_SHORT_IRI) == 0 ||
                    strcmp(cstring, XSD_INT_IRI) == 0 ||
                    strcmp(cstring, XSD_LONG_IRI) == 0 ||
                    strcmp(cstring, XSD_FLOAT_IRI) == 0 ||
                    strcmp(cstring, XSD_DOUBLE_IRI) == 0 ||
                    strcmp(cstring, XSD_INTEGER_IRI) == 0 ||
                    strcmp(cstring, XSD_DECIMAL_IRI) == 0)
                result = BoolGetDatum(false);
            else
                isNull = true;

            pfree(cstring);
            break;
        }

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
