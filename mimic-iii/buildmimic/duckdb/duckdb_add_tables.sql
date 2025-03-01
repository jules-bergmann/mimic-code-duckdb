DROP TABLE IF EXISTS ADMISSIONS CASCADE;
CREATE TABLE ADMISSIONS
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  ADMITTIME TIMESTAMP NOT NULL,
  DISCHTIME TIMESTAMP NOT NULL,
  DEATHTIME TIMESTAMP,
  ADMISSION_TYPE VARCHAR(50) NOT NULL,
  ADMISSION_LOCATION VARCHAR(50) NOT NULL,
  DISCHARGE_LOCATION VARCHAR(50) NOT NULL,
  INSURANCE VARCHAR(255) NOT NULL,
  LANGUAGE VARCHAR(10),
  RELIGION VARCHAR(50),
  MARITAL_STATUS VARCHAR(50),
  ETHNICITY VARCHAR(200) NOT NULL,
  EDREGTIME TIMESTAMP,
  EDOUTTIME TIMESTAMP,
  DIAGNOSIS VARCHAR(255),
  HOSPITAL_EXPIRE_FLAG SMALLINT,
  HAS_CHARTEVENTS_DATA SMALLINT NOT NULL,
  CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID),
  CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID)
) ;

DROP TABLE IF EXISTS CALLOUT CASCADE;
CREATE TABLE CALLOUT
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  SUBMIT_WARDID INT,
  SUBMIT_CAREUNIT VARCHAR(15),
  CURR_WARDID INT,
  CURR_CAREUNIT VARCHAR(15),
  CALLOUT_WARDID INT,
  CALLOUT_SERVICE VARCHAR(10) NOT NULL,
  REQUEST_TELE SMALLINT NOT NULL,
  REQUEST_RESP SMALLINT NOT NULL,
  REQUEST_CDIFF SMALLINT NOT NULL,
  REQUEST_MRSA SMALLINT NOT NULL,
  REQUEST_VRE SMALLINT NOT NULL,
  CALLOUT_STATUS VARCHAR(20) NOT NULL,
  CALLOUT_OUTCOME VARCHAR(20) NOT NULL,
  DISCHARGE_WARDID INT,
  ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL,
  CREATETIME TIMESTAMP NOT NULL,
  UPDATETIME TIMESTAMP NOT NULL,
  ACKNOWLEDGETIME TIMESTAMP,
  OUTCOMETIME TIMESTAMP NOT NULL,
  FIRSTRESERVATIONTIME TIMESTAMP,
  CURRENTRESERVATIONTIME TIMESTAMP,
  CONSTRAINT callout_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS CAREGIVERS CASCADE;
CREATE TABLE CAREGIVERS
(
  ROW_ID INT NOT NULL,
	CGID INT NOT NULL,
	LABEL VARCHAR(15),
	DESCRIPTION VARCHAR(30),
	CONSTRAINT cg_rowid_pk  PRIMARY KEY (ROW_ID),
	CONSTRAINT cg_cgid_unique UNIQUE (CGID)
) ;

DROP TABLE IF EXISTS chartevents CASCADE;
CREATE TABLE CHARTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT,
	CHARTTIME TIMESTAMP,
	STORETIME TIMESTAMP,
	CGID INT,
	VALUE VARCHAR(255),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(50),
	WARNING INT,
	ERROR INT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50)
	-- Re-add the below when DuckDB > 0.7.1 is released?
	-- See https://github.com/duckdb/duckdb/issues/6668#issuecomment-1474880266
    --,CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID) 
);

DROP TABLE IF EXISTS CPTEVENTS CASCADE;
CREATE TABLE CPTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	COSTCENTER VARCHAR(10) NOT NULL,
	CHARTDATE TIMESTAMP,
	CPT_CD VARCHAR(10) NOT NULL,
	CPT_NUMBER INT,
	CPT_SUFFIX VARCHAR(5),
	TICKET_ID_SEQ INT,
	SECTIONHEADER VARCHAR(50),
	SUBSECTIONHEADER VARCHAR(255),
	DESCRIPTION VARCHAR(200),
	CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS DATETIMEEVENTS CASCADE;
CREATE TABLE DATETIMEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP NOT NULL,
	STORETIME TIMESTAMP NOT NULL,
	CGID INT NOT NULL,
	VALUE TIMESTAMP,
	VALUEUOM VARCHAR(50) NOT NULL,
	WARNING SMALLINT,
	ERROR SMALLINT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50),
	CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS DIAGNOSES_ICD CASCADE;
CREATE TABLE DIAGNOSES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT,
	ICD9_CODE VARCHAR(10),
	CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS DRGCODES CASCADE;
CREATE TABLE DRGCODES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	DRG_TYPE VARCHAR(20) NOT NULL,
	DRG_CODE VARCHAR(20) NOT NULL,
	DESCRIPTION VARCHAR(255),
	DRG_SEVERITY SMALLINT,
	DRG_MORTALITY SMALLINT,
	CONSTRAINT drg_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_CPT CASCADE;
CREATE TABLE D_CPT
(
  ROW_ID INT NOT NULL,
	CATEGORY SMALLINT NOT NULL,
	SECTIONRANGE VARCHAR(100) NOT NULL,
	SECTIONHEADER VARCHAR(50) NOT NULL,
	SUBSECTIONRANGE VARCHAR(100) NOT NULL,
	SUBSECTIONHEADER VARCHAR(255) NOT NULL,
	CODESUFFIX VARCHAR(5),
	MINCODEINSUBSECTION INT NOT NULL,
	MAXCODEINSUBSECTION INT NOT NULL,
	CONSTRAINT dcpt_ssrange_unique UNIQUE (SUBSECTIONRANGE),
	CONSTRAINT dcpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_ICD_DIAGNOSES CASCADE;
CREATE TABLE D_ICD_DIAGNOSES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_ICD_PROCEDURES CASCADE;
CREATE TABLE D_ICD_PROCEDURES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_ITEMS CASCADE;
CREATE TABLE D_ITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(200),
	ABBREVIATION VARCHAR(100),
	DBSOURCE VARCHAR(20),
	LINKSTO VARCHAR(50),
	CATEGORY VARCHAR(100),
	UNITNAME VARCHAR(100),
	PARAM_TYPE VARCHAR(30),
	CONCEPTID INT,
	CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS D_LABITEMS CASCADE;
CREATE TABLE D_LABITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(100) NOT NULL,
	FLUID VARCHAR(100) NOT NULL,
	CATEGORY VARCHAR(100) NOT NULL,
	LOINC_CODE VARCHAR(100),
	CONSTRAINT dlabitems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT dlabitems_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS ICUSTAYS CASCADE;
CREATE TABLE ICUSTAYS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT NOT NULL,
	DBSOURCE VARCHAR(20) NOT NULL,
	FIRST_CAREUNIT VARCHAR(20) NOT NULL,
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP NOT NULL,
	OUTTIME TIMESTAMP,
	LOS DOUBLE PRECISION,
	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID),
	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS INPUTEVENTS_CV CASCADE;
CREATE TABLE INPUTEVENTS_CV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP,
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP,
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE INT,
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALAMOUNTUOM VARCHAR(30),
	ORIGINALROUTE VARCHAR(30),
	ORIGINALRATE DOUBLE PRECISION,
	ORIGINALRATEUOM VARCHAR(30),
	ORIGINALSITE VARCHAR(30),
	CONSTRAINT inputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS INPUTEVENTS_MV CASCADE;
CREATE TABLE INPUTEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP,
	ENDTIME TIMESTAMP,
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP,
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	PATIENTWEIGHT DOUBLE PRECISION,
	TOTALAMOUNT DOUBLE PRECISION,
	TOTALAMOUNTUOM VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(40),
	COMMENTS_DATE TIMESTAMP,
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALRATE DOUBLE PRECISION,
	CONSTRAINT inputevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS LABEVENTS CASCADE;
CREATE TABLE LABEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP,
	VALUE VARCHAR(200),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(20),
	FLAG VARCHAR(20),
	CONSTRAINT labevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS MICROBIOLOGYEVENTS CASCADE;
CREATE TABLE MICROBIOLOGYEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP,
	CHARTTIME TIMESTAMP,
	SPEC_ITEMID INT,
	SPEC_TYPE_DESC VARCHAR(100),
	ORG_ITEMID INT,
	ORG_NAME VARCHAR(100),
	ISOLATE_NUM SMALLINT,
	AB_ITEMID INT,
	AB_NAME VARCHAR(30),
	DILUTION_TEXT VARCHAR(10),
	DILUTION_COMPARISON VARCHAR(20),
	DILUTION_VALUE DOUBLE PRECISION,
	INTERPRETATION VARCHAR(5),
	CONSTRAINT micro_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS NOTEEVENTS CASCADE;
CREATE TABLE NOTEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP,
	CHARTTIME TIMESTAMP,
	STORETIME TIMESTAMP,
	CATEGORY VARCHAR(50),
	DESCRIPTION VARCHAR(255),
	CGID INT,
	ISERROR CHAR(1),
	TEXT TEXT,
	CONSTRAINT noteevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS OUTPUTEVENTS CASCADE;
CREATE TABLE OUTPUTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP,
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	STORETIME TIMESTAMP,
	CGID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE CHAR(1),
	ISERROR INT,
	CONSTRAINT outputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS PATIENTS CASCADE;
CREATE TABLE PATIENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	GENDER VARCHAR(5) NOT NULL,
	DOB TIMESTAMP NOT NULL,
	DOD TIMESTAMP,
	DOD_HOSP TIMESTAMP,
	DOD_SSN TIMESTAMP,
	EXPIRE_FLAG INT NOT NULL,
	CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID),
	CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS PRESCRIPTIONS CASCADE;
CREATE TABLE PRESCRIPTIONS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTDATE TIMESTAMP,
	ENDDATE TIMESTAMP,
	DRUG_TYPE VARCHAR(100) NOT NULL,
	DRUG VARCHAR(100) NOT NULL,
	DRUG_NAME_POE VARCHAR(100),
	DRUG_NAME_GENERIC VARCHAR(100),
	FORMULARY_DRUG_CD VARCHAR(120),
	GSN VARCHAR(200),
	NDC VARCHAR(120),
	PROD_STRENGTH VARCHAR(120),
	DOSE_VAL_RX VARCHAR(120),
	DOSE_UNIT_RX VARCHAR(120),
	FORM_VAL_DISP VARCHAR(120),
	FORM_UNIT_DISP VARCHAR(120),
	ROUTE VARCHAR(120),
	CONSTRAINT prescription_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS PROCEDUREEVENTS_MV CASCADE;
CREATE TABLE PROCEDUREEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP,
	ENDTIME TIMESTAMP,
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	LOCATION VARCHAR(30),
	LOCATIONCATEGORY VARCHAR(30),
	STORETIME TIMESTAMP,
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(30),
	COMMENTS_DATE TIMESTAMP,
	CONSTRAINT procedureevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS PROCEDURES_ICD CASCADE;
CREATE TABLE PROCEDURES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS SERVICES CASCADE;
CREATE TABLE SERVICES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	TRANSFERTIME TIMESTAMP NOT NULL,
	PREV_SERVICE VARCHAR(20),
	CURR_SERVICE VARCHAR(20),
	CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID)
) ;

DROP TABLE IF EXISTS TRANSFERS CASCADE;
CREATE TABLE TRANSFERS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	DBSOURCE VARCHAR(20),
	EVENTTYPE VARCHAR(20),
	PREV_CAREUNIT VARCHAR(20),
	CURR_CAREUNIT VARCHAR(20),
	PREV_WARDID SMALLINT,
	CURR_WARDID SMALLINT,
	INTIME TIMESTAMP,
	OUTTIME TIMESTAMP,
	LOS DOUBLE PRECISION,
	CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID)
) ;