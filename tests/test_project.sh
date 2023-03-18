#!/bin/sh

beforeAll() {
	FIXTURES=$(mktemp -d -t 'hreld_testXXXXXX')
	echo '#Id	#Name	#Age' >"${FIXTURES}/empty.tbl"
	printf '#Id	#Name	#Age\n1	Alice	21\n2	Bob	32\n' >"${FIXTURES}/nonempty.tbl"
}

afterAll() {
    rm -R "${FIXTURES:-/tmp/hreld}"/*
	rmdir "${FIXTURES:-/tmp/hreld}"
}

#
# EMPTY TABLE
#

test_empty_table_filtering() {
	echo '#Name' >"${FIXTURES}/want.tbl"
	
	<"${FIXTURES}/empty.tbl" ./hreld project Name >"${FIXTURES}/got.tbl"

	diff "${FIXTURES}/want.tbl" "${FIXTURES}/got.tbl"
}

test_empty_table_reordering() {
	echo '#Age	#Id' >"${FIXTURES}/want.tbl"
	
	<"${FIXTURES}/empty.tbl" ./hreld project Age Id >"${FIXTURES}/got.tbl"

	diff "${FIXTURES}/want.tbl" "${FIXTURES}/got.tbl"
}

xtest_empty_table_no_attr() {
	<"${FIXTURES}/empty.tbl" ./hreld project >"${FIXTURES}/got.tbl"

	test $? -eq 0
	test -s "${FIXTURES}/got.tbl"
}

#
# NON-EMPTY TABLE
#

test_nonempty_table_filtering() {
	printf '#Name\nAlice\nBob\n' >"${FIXTURES}/want.tbl"
	
	<"${FIXTURES}/nonempty.tbl" ./hreld project Name >"${FIXTURES}/got.tbl"

	diff "${FIXTURES}/want.tbl" "${FIXTURES}/got.tbl"
}

test_nonempty_table_reordering() {
	printf '#Age	#Id\n21	1\n32	2\n' >"${FIXTURES}/want.tbl"
	
	<"${FIXTURES}/nonempty.tbl" ./hreld project Age Id >"${FIXTURES}/got.tbl"

	diff "${FIXTURES}/want.tbl" "${FIXTURES}/got.tbl"
}

xtest_nonempty_table_no_attr() {
	echo '' >"${FIXTURES}/want.tbl"
    
	<"${FIXTURES}/nonempty.tbl" ./hreld project >"${FIXTURES}/got.tbl"

	test $? -eq 0
	diff "${FIXTURES}/want.tbl" "${FIXTURES}/got.tbl"
}

xtest_nonempty_table_unknown_attr() {
	<"${FIXTURES}/empty.tbl" ./hreld project Id Address >"${FIXTURES}/got.tbl"

	test $? -ne 0
	# undefined subset
}

test_nonempty_table_duplicates() {
    printf '#Id	#Name\n1	Alice\n2	Bob\n3	Alice\n' >"${FIXTURES}/with_duplicates.tbl"
	printf '#Name\nAlice\nBob\nAlice\n' >"${FIXTURES}/want.tbl"
	
	<"${FIXTURES}/with_duplicates.tbl" ./hreld project Name >"${FIXTURES}/got.tbl"

	diff "${FIXTURES}/got.tbl" "${FIXTURES}/want.tbl"
}
