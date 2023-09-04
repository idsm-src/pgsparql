#ifndef RDFBOX_SYNTAX_H_
#define RDFBOX_SYNTAX_H_

#include <stddef.h>
#include <stdbool.h>


bool check_iri(const char *data, size_t length);
bool check_iri_reference(const char *data, size_t length);
bool check_language_tag(const char *data, size_t length);

#endif /* RDFBOX_SYNTAX_H_ */
