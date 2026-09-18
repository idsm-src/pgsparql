load ../psql_tests.bash



####
# a hand-built message that is correct
#

@test "rx: 80000000 01 00000004 54525545" {
  expect_output '"TRUE"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rx: 00000014 00000003 616263" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rx: 00000018 00000013 687474703a2f2f6578616d706c652e6f72672f" {
  expect_output '<http://example.org/>'
}



####
# a type tag that belongs to no type left the box a NULL pointer
#

@test "rx: 00000063" {
  expect_error
}

@test "rx: 80000063" {
  expect_error
}

@test "rx: 7fffffff" {
  expect_error
}

@test "rx: 0000001b" {
  expect_error
}



####
# a negative length turned the memcpy() of the constructor into a memcpy() of SIZE_MAX bytes
#

@test "rx: 80000000 01 ffffffff" {
  expect_error
}

@test "rx: 00000014 ffffffff" {
  expect_error
}

@test "rx: 00000018 ffffffff" {
  expect_error
}

@test "rx: 0000001a ffffffff" {
  expect_error
}

@test "rx: 80000013 0000000000000000 ffffffff" {
  expect_error
}

@test "rx: 00000015 ffffffff 00000001 41" {
  expect_error
}

@test "rx: 00000015 00000001 ffffffff 41" {
  expect_error
}

@test "rx: 00000017 ffffffff 00000001 41" {
  expect_error
}

@test "rx: 00000017 00000001 ffffffff 41" {
  expect_error
}



####
# a length larger than the rest of the message copied whatever followed it in memory into the value
#

@test "rx: 80000000 01 000007d0" {
  expect_error
}

@test "rx: 00000014 7fffffff" {
  expect_error
}

@test "rx: 00000014 00000010 4142" {
  expect_error
}

@test "rx: 00000018 00000010 4142" {
  expect_error
}

@test "rx: 0000001a 00000010 4142" {
  expect_error
}

@test "rx: 00000015 00000004 00000004 4142" {
  expect_error
}

@test "rx: 00000017 00000004 00000004 4142" {
  expect_error
}

@test "rx: 00000016 7fffffff 00000001 41" {
  expect_error
}



####
# a message that ends before the value does, and one that does not end with it
#

@test "rx: 00000000" {
  expect_error
}

@test "rx: 00000007 0000000000" {
  expect_error
}

@test "rx: 80000000 01" {
  expect_error
}

@test "rx: 00000019 0000000000000001 41" {
  expect_error
}



####
# the boxed value of a user literal has to be exactly as long as its length says: 'integer' and an int4
# take twelve bytes, the thirteenth is left over
#

@test "rx: 00000016 0000000d 00000001 696e7465676572 00 0000002a 00 41" {
  expect_error
}



####
# a zone outside of the range xsd:dateTime and xsd:date allow was stored as it came and only noticed by the
# output function, which left a row in the table that could not be printed
#

@test "rx: 00000011 0000000000000000 000f423f" {
  expect_error
}

@test "rx: 00000011 0000000000000000 0000c4e1" {
  expect_error
}

@test "rx: 00000012 00000000 000f423f" {
  expect_error
}

@test "rx: 00000012 00000000 ffff3b1f" {
  expect_error
}



####
# the zones at the edge of that range, and the one that stands for an absent zone, are valid
#

@test "rx: 00000011 0000000000000000 00000000" {
  expect_output '"2000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rx: 00000011 0000000000000000 0000c4e0" {
  expect_output '"2000-01-01T14:00:00+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rx: 00000011 0000000000000000 ffff3b20" {
  expect_output '"1999-12-31T10:00:00-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rx: 00000011 0000000000000000 80000000" {
  expect_output '"2000-01-01T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rx: 00000012 00000000 00000000" {
  expect_output '"2000-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rx: 00000012 00000000 80000000" {
  expect_output '"2000-01-01"^^<http://www.w3.org/2001/XMLSchema#date>'
}



####
# a non-finite timestamp or date was let through, although no lexical form denotes
# one and rdfbox_output() therefore refuses to print it
#

@test "rx: 00000011 7fffffffffffffff 00000000" {
  expect_error
}

@test "rx: 00000011 8000000000000000 00000000" {
  expect_error
}

@test "rx: 00000012 7fffffff 00000000" {
  expect_error
}

@test "rx: 00000012 80000000 00000000" {
  expect_error
}



####
# text that is not valid in the server encoding was stored as it came, and an
# embedded zero byte then cut the value short wherever it was handed out
#

@test "rx: 00000014 00000003 61ff62" {
  expect_error
}

@test "rx: 00000014 00000003 610062" {
  expect_error
}

@test "rx: 00000015 00000001 00000003 41 6373ff" {
  expect_error
}

@test "rx: 80000000 01 00000002 61ff" {
  expect_error
}



####
# the lexical bit was ignored for the types that keep no lexical form, so the
# message that carried it did not come back out of the send function
#

@test "rx: 80000014 00000003 616263" {
  expect_error
}

@test "rx: 80000018 00000003 616263" {
  expect_error
}

@test "rx: 8000001a 00000009 3030303030303030 61" {
  expect_error
}



####
# a blank node with an empty label is well formed: eight digits of the segment and
# nothing else
#

@test "rx: 0000001a 00000008 3030303030303031" {
  expect_output '_:s00000001'
}



####
# the integer types of a fixed width travel in exactly that width, so every value that arrives is in range
#

@test "rx: 00000001 80" {
  expect_output '"-128"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "rx: 00000001 7f" {
  expect_output '"127"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "rx: 00000002 ff" {
  expect_output '"255"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "rx: 00000004 ffff" {
  expect_output '"65535"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "rx: 00000006 ffffffff" {
  expect_output '"4294967295"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "rx: 00000008 ffffffffffffffff" {
  expect_output '"18446744073709551615"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "rx: 80000001 80 00000004 2d313238" {
  expect_output '"-128"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "rx: 80000002 05 00000002 2b35" {
  expect_output '"+5"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "rx: 80000008 0000000000000001 00000002 3031" {
  expect_output '"01"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}



####
# the types derived from xsd:integer by a bound travel as a numeric: five, minus five and zero
#

@test "rx: 0000000d 0001 0000 0000 0000 0005" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "rx: 0000000b 0001 0000 4000 0000 0005" {
  expect_output '"-5"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "rx: 0000000a 0000 0000 0000 0000" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "rx: 8000000c 0000 0000 0000 0000 00000002 2d30" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}



####
# a message that ends before the value of a fixed width does
#

@test "rx: 00000001" {
  expect_error
}

@test "rx: 00000004 ff" {
  expect_error
}

@test "rx: 00000006 ffffff" {
  expect_error
}

@test "rx: 00000008 00000000" {
  expect_error
}

@test "rx: 80000002 05 00000002 2b" {
  expect_error
}
