/**
 * @file
 * The character classes of XML Schema that the parsers of the lexical forms share.
 */
#ifndef TYPES_PARSER_H_
#define TYPES_PARSER_H_


/**
 * Tests whether a character is XML Schema whitespace: a space, a tab, a carriage return or a line feed.
 *
 * @param c the character
 * @return true if @a c is whitespace
 */
static inline bool xsd_isspace(char c)
{
    return c == '\t' || c == '\n' || c == '\r' || c == ' ';
}


/**
 * Tests whether a character is an ASCII decimal digit.
 *
 * @param c the character
 * @return true if @a c is one of `0` to `9`
 */
static inline bool xsd_isdigit(char c)
{
    return (unsigned int)(c - '0') < 10;
}

#endif /* TYPES_PARSER_H_ */
