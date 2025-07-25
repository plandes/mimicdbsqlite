#!/bin/sh

# this script adds indexes to the mimic3 SQLite DB

BIN=sqlite3
DB_FILE=$1
# this keeps: noteevents, admissions, patients
TO_REMOVE="
callout \
caregivers \
chartevents \
cptevents \
datetimeevents \
drgcodes \
d_cpt \
d_items \
d_labitems \
icustays \
inputevents_cv \
inputevents_mv \
labevents \
microbiologyevents \
outputevents \
procedureevents_mv \
services \
transfers"

function add_indexes() {
    echo "adding indexes"
    $BIN ${DB_FILE} <<EOF
create index noteevents_text_id on noteevents(text);
create index noteevents_category_id on noteevents(category);
create index noteevents_description_id on noteevents(description);
create index admissions_hadm_id on admissions(hadm_id);
create index admissions_subject_id on admissions(subject_id);
create index admissions_diagnosis on admissions(diagnosis);
create index patients_subject_id on patients(subject_id);
create index diagnoses_icd_hadm_id on diagnoses_icd(hadm_id);
create index diagnoses_icd_icd9_code on diagnoses_icd(icd9_code);
create index procedures_icd_icd9_code on procedures_icd(icd9_code);
create index d_icd_diagnoses_icd_icd9_code on d_icd_diagnoses(icd9_code);
create index d_icd_procedures_icd_icd9_code on d_icd_procedures(icd9_code);
EOF
}

function drop_tables() {
    echo "dropping unecessary tables"
    for table in $TO_REMOVE ; do
	echo "dropping table $table"
	$BIN ${DB_FILE} "drop table ${table};"
    done
    echo "rebuild the database file repacking it into a smaller amount of disk space"
    $BIN ${DB_FILE} "vacuum"
}

function main() {
    echo "post processing steps on : ${DB_FILE}"
    add_indexes
    # uncomment the following to save only certain tables to save space
    # drop_tables
}

main
