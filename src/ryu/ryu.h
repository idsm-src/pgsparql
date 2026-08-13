// This is a modification of code taken from github.com/ulfjack/ryu under the
// terms of the Boost license (not the Apache license). The original copyright
// notice follows:
//
// Copyright 2018 Ulf Adams
//
// The contents of this file may be used under the terms of the Apache License,
// Version 2.0.
//
//    (See accompanying file LICENSE-Apache or copy at
//     http://www.apache.org/licenses/LICENSE-2.0)
//
// Alternatively, the contents of this file may be used under the terms of
// the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE-Boost or copy at
//     https://www.boost.org/LICENSE_1_0.txt)
//
// Unless required by applicable law or agreed to in writing, this software
// is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.
#ifndef RYU_H
#define RYU_H

#ifdef __cplusplus
extern "C" {
#endif

#include <inttypes.h>
#include <stdbool.h>

int d2s_buffered_n(double f, char* result, const bool scientific);
void d2s_buffered(double f, char* result, const bool scientific);
char* d2s(double f, const bool scientific);

int f2s_buffered_n(float f, char* result, const bool scientific);
void f2s_buffered(float f, char* result, const bool scientific);
char* f2s(float f, const bool scientific);

#ifdef __cplusplus
}
#endif

#endif // RYU_H
