#ifndef TYPES_PARSER_H_
#define TYPES_PARSER_H_


static inline bool xsd_isspace(char c)
{
    return c == '\t' || c == '\n' || c == '\r' || c == ' ';
}


static inline bool xsd_isdigit(char c)
{
    return (unsigned int)(c - '0') < 10;
}

#endif /* TYPES_PARSER_H_ */
