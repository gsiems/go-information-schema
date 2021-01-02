

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE DATABASE schemata ;
\c schemata
CREATE SCHEMA schemata ;

SET search_path = schemata, pg_catalog

CREATE FUNCTION schemata.camelcase(instr character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  outa varchar[] ;
  word varchar ;
  first boolean := true ;
BEGIN
    FOREACH word IN ARRAY string_to_array ( instr, '_' )
    LOOP

        outa := array_append ( outa, ( upper ( left ( word, 1 ) )::varchar
            || lower ( right ( word, -1 ) )::varchar )::varchar ) ;

    END LOOP ;

    RETURN array_to_string ( outa, '', '' ) ;

END ;
$$;

ALTER FUNCTION schemata.camelcase(instr character varying) OWNER TO postgres;

CREATE FUNCTION schemata.jsoncase(instr character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  outa varchar[] ;
  word varchar ;
  first boolean := true ;
BEGIN
    FOREACH word IN ARRAY string_to_array ( instr, '_' )
    LOOP
        IF first THEN
            first := false ;
            outa := array_append ( outa, lower ( word )::varchar ) ;
        ELSE
            outa := array_append ( outa, ( upper ( left ( word, 1 ) )::varchar
                || lower ( right ( word, -1 ) )::varchar )::varchar ) ;
        END IF ;

    END LOOP ;

    RETURN array_to_string ( outa, '', '' ) ;

END ;
$$;

ALTER FUNCTION schemata.jsoncase(instr character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE schemata.data_types (
    sql_type text NOT NULL,
    go_type text
);

ALTER TABLE schemata.data_types OWNER TO postgres;

COMMENT ON TABLE schemata.data_types IS 'SQL to Go datatype mapping.' ;

CREATE TABLE schemata.db_engines_ranking (
    engine_name text NOT NULL,
    ranking smallint NOT NULL,
    db_model text,
    remarks text
);

ALTER TABLE schemata.db_engines_ranking OWNER TO postgres;

COMMENT ON TABLE schemata.db_engines_ranking IS 'Database ranking information from db-engines.com for December, 2020' ;


CREATE TABLE schemata.engines (
    engine_name text NOT NULL,
    label text,
    has_go_driver text,
    has_information_schema text,
    remarks text
);

ALTER TABLE schemata.engines OWNER TO postgres;

COMMENT ON TABLE schemata.db_engines_ranking IS 'List of database engines' ;

CREATE TABLE schemata.information_columns (
    label text,
    table_catalog text,
    table_schema text,
    table_name text,
    column_name text,
    ordinal_position integer,
    data_type text
);

ALTER TABLE schemata.information_columns OWNER TO postgres;

COMMENT ON TABLE schemata.db_engines_ranking IS 'Data extracted from the SQL:2003 (draft) standard combined with data extracted from the INFORMATION_SCHEMA.COLUMNS tables for the databases compared.' ;

COPY schemata.data_types (sql_type, go_type) FROM stdin;
ARRAY
BIGINT	sql.NullInt64
BIT
BLOB
BOOLEAN	sql.NullBool
CHARACTER VARYING	sql.NullString
DATETIME	sql.NullTime
DECIMAL
DOUBLE	sql.NullFloat64
INTEGER	sql.NullInt32
INT	sql.NullInt32
LONGTEXT	sql.NullString
NAME	sql.NullString
NVARCHAR	sql.NullString
OID
SMALLINT	sql.NullInt32
SQL_VARIANT
SYSNAME	sql.NullString
TIMESTAMP	sql.NullTime
TIMESTAMP WITH TIME ZONE	sql.NullTime
TINYINT	sql.NullInt32
UNK
VARCHAR	sql.NullString
\.

COPY schemata.db_engines_ranking (engine_name, ranking, db_model, remarks) FROM stdin;
1010data	157	Relational	Score: 1.19
4D	110	Relational	Score: 2.64
4store	230	RDF	Score: 0.51
Accumulo	84	Wide column	Score: 4.13
Actian FastObjects	293	Object oriented	Score: 0.15
Actian NoSQL Database	135	Object oriented	Score: 1.67
Actian PSQL	268	Relational	Score: 0.27
Actian Vector	176	Relational	Score: 0.96
ActivePivot	223	Object oriented	Score: 0.56
ActorDB	343	Relational	Score: 0
Adabas	75	Multivalue	Score: 5.11
Aerospike	62	Key-value, Multi-model	Score: 6
AgensGraph	311	Multi-model	Score: 0.07
AlaSQL	199	Multi-model	Score: 0.75
Algolia	52	Search engine	Score: 7.83
Alibaba Cloud AnalyticDB for MySQL	205	Relational, Multi-model	Score: 0.7
Alibaba Cloud AnalyticDB for PostgreSQL	220	Relational	Score: 0.58
Alibaba Cloud ApsaraDB for PolarDB	212	Relational	Score: 0.64
Alibaba Cloud Log Service	245	Search engine	Score: 0.4
Alibaba Cloud MaxCompute	203	Relational	Score: 0.71
Alibaba Cloud Table Store	237	Wide column	Score: 0.47
Alibaba Cloud TSDB	235	Time Series	Score: 0.48
AllegroGraph	166	Multi-model	Score: 1.07
Altibase	142	Relational	Score: 1.56
Amazon Aurora	44	Relational, Multi-model	Score: 9.47
Amazon CloudSearch	101	Search engine	Score: 3.06
Amazon DocumentDB	161	Document	Score: 1.17
Amazon DynamoDB	17	Multi-model	Score: 69.12
Amazon Keyspaces	255	Wide column	Score: 0.35
Amazon Neptune	114	Multi-model	Score: 2.51
Amazon Redshift	31	Relational	Score: 22.42
Amazon SimpleDB	108	Key-value	Score: 2.75
Amazon Timestream	226	Time Series	Score: 0.55
AnzoGraph DB	294	Multi-model	Score: 0.14
Apache Drill	99	Multi-model	Score: 3.14
Apache Druid	111	Multi-model	Score: 2.59
Apache IoTDB	292	Time Series	Score: 0.15
Apache Jena - TDB	102	RDF	Score: 3.05
Apache Phoenix	93	Relational	Score: 3.55
ArangoDB	69	Multi-model	Score: 5.51
Axibase	264	Time Series	Score: 0.28
Badger	297	Key-value	Score: 0.11
Bangdb	343	Key-value	Score: 0
BaseX	128	Native XML	Score: 1.96
BergDB	343	Key-value	Score: 0
BigchainDB	190	Document	Score: 0.8
BigObject	313	Relational	Score: 0.07
Blazegraph	185	Multi-model	Score: 0.83
Blueflood	288	Time Series	Score: 0.17
BoltDB	207	Key-value	Score: 0.69
BrightstarDB	299	RDF	Score: 0.11
Brytlyt	263	Relational	Score: 0.29
Cachelot.io	343	Key-value	Score: 0
Cassandra	10	Wide column	Score: 118.84
Citus	148	Relational, Multi-model	Score: 1.32
ClickHouse	53	Relational	Score: 7.82
CloudKit	107	Document	Score: 2.8
CockroachDB	59	Relational	Score: 6.55
Comdb2	274	Relational	Score: 0.25
CortexDB	342	Multi-model	Score: 0
Couchbase	26	Document, Multi-model	Score: 31.82
CouchDB	36	Document	Score: 16.85
CovenantSQL	330	Relational	Score: 0.02
CrateDB	181	Multi-model	Score: 0.9
Crux	343	Document	Score: 0
CubicWeb	278	RDF	Score: 0.23
Cubrid	136	Relational	Score: 1.66
D3	146	Multivalue	Score: 1.43
DaggerDB	343	Relational	Score: 0
Datacom/DB	178	Relational	Score: 0.93
DataEase	153	Relational	Score: 1.24
Datameer	147	Document	Score: 1.37
Datastax Enterprise	48	Wide column, Multi-model	Score: 8.49
Datomic	105	Relational	Score: 2.92
Db4o	141	Object oriented	Score: 1.6
dBASE	38	Relational	Score: 15.05
DBISAM	171	Relational	Score: 1.01
DensoDB	318	Document	Score: 0.05
Derby	63	Relational	Score: 5.9
Dgraph	134	Graph	Score: 1.69
DolphinDB	210	Time Series	Score: 0.65
DuckDB	295	Relational	Score: 0.13
Dydra	303	RDF	Score: 0.1
EDB Postgres	116	Relational, Multi-model	Score: 2.45
Edge Intelligence	343	Relational	Score: 0
Ehcache	54	Key-value	Score: 7.66
EJDB	277	Document	Score: 0.23
Elassandra	218	Wide column, Multi-model	Score: 0.6
Elasticsearch	8	Search engine, Multi-model	Score: 152.49
ElevateDB	273	Relational	Score: 0.26
Elliptics	304	Key-value	Score: 0.09
Eloquera	339	Object oriented	Score: 0.01
Empress	143	Relational	Score: 1.53
EsgynDB	266	Relational	Score: 0.28
etcd	47	Key-value	Score: 8.57
EventStoreDB	236	Event	Score: 0.48
EXASOL	89	Relational	Score: 3.65
eXist-db	196	Native XML	Score: 0.76
Exorbyte	328	Search engine	Score: 0.03
eXtremeDB	217	Multi-model	Score: 0.61
Faircom DB	228	Multi-model	Score: 0.53
Faircom EDGE	265	Multi-model	Score: 0.28
FaunaDB	126	Multi-model	Score: 2.01
FileMaker	22	Relational	Score: 47.7
FinchDB	329	Multi-model	Score: 0.03
Firebase Realtime Database	35	Document	Score: 16.96
Firebird	29	Relational	Score: 22.83
FlockDB	257	Graph	Score: 0.33
Fluree	254	Graph	Score: 0.36
FoundationDB	158	Multi-model	Score: 1.18
FrontBase	173	Relational	Score: 0.99
GBase	162	Relational	Score: 1.16
GemStone/S	202	Object oriented	Score: 0.72
Geode	129	Key-value	Score: 1.96
GeoSpock	262	Relational, Multi-model	Score: 0.29
GigaSpaces InsightEdge	182	Multi-model	Score: 0.86
Giraph	165	Graph	Score: 1.14
Google BigQuery	24	Relational	Score: 35.76
Google Cloud Bigtable	86	Wide column	Score: 4.06
Google Cloud Datastore	70	Document	Score: 5.51
Google Cloud Firestore	50	Document	Score: 8.39
Google Cloud Spanner	106	Relational	Score: 2.89
Grakn	194	Multi-model	Score: 0.77
GraphBase	284	Graph	Score: 0.18
GraphDB	125	Multi-model	Score: 2.05
Graph Engine	204	Multi-model	Score: 0.7
Graphite	79	Time Series	Score: 4.68
Greenplum	40	Relational, Multi-model	Score: 12.92
GridDB	187	Time Series, Multi-model	Score: 0.82
GridGain	119	Multi-model	Score: 2.31
GT.M	159	Key-value	Score: 1.18
H2	49	Relational	Score: 8.44
HarperDB	242	Document	Score: 0.44
Hawkular Metrics	317	Time Series	Score: 0.05
HAWQ	167	Relational	Score: 1.06
Hazelcast	43	Key-value, Multi-model	Score: 9.48
HBase	23	Wide column	Score: 46.92
Helium	343	Key-value	Score: 0
Heroic	239	Time Series	Score: 0.47
HFSQL	138	Relational	Score: 1.65
HGraphDB	332	Graph	Score: 0.02
Hibari	253	Key-value	Score: 0.36
Hive	15	Relational	Score: 70.27
HPE Ezmeral Data Fabric	188	Multi-model	Score: 0.81
HugeGraph	310	Graph	Score: 0.07
HyperGraphDB	269	Graph	Score: 0.27
HyperLevelDB	331	Key-value	Score: 0.02
HyperSQL	67	Relational	Score: 5.65
Hyprcubd	343	Time Series	Score: 0
IBM Cloudant	83	Document	Score: 4.17
IBM Db2	6	Relational, Multi-model	Score: 160.43
IBM Db2 Event Store	247	Multi-model	Score: 0.39
IBM Db2 warehouse	121	Relational	Score: 2.28
iBoxDB	336	Document	Score: 0.01
IDMS	149	Navigational	Score: 1.29
Ignite	71	Multi-model	Score: 5.32
Impala	37	Relational, Multi-model	Score: 15.32
IMS	96	Navigational	Score: 3.4
Indica	343	Search engine	Score: 0
Infinispan	91	Key-value	Score: 3.59
InfiniteGraph	233	Graph	Score: 0.5
InfinityDB	324	Key-value	Score: 0.04
InfluxDB	27	Time Series	Score: 26.15
Infobright	160	Relational	Score: 1.18
Informix	30	Relational, Multi-model	Score: 22.65
Ingres	58	Relational	Score: 6.64
Interbase	56	Relational	Score: 7.07
InterSystems Caché	92	Multi-model	Score: 3.59
InterSystems IRIS	130	Multi-model	Score: 1.87
IRONdb	323	Time Series	Score: 0.04
ITTIA	276	Relational	Score: 0.24
Jackrabbit	76	Content	Score: 5.1
Jade	211	Object oriented	Score: 0.65
JaguarDB	306	Key-value	Score: 0.08
JanusGraph	109	Graph	Score: 2.65
JasDB	341	Document	Score: 0.01
jBASE	120	Multivalue	Score: 2.29
JethroData	338	Relational	Score: 0.01
JSqlDb	343	Multi-model	Score: 0
KairosDB	197	Time Series	Score: 0.75
K-DB	343	Relational	Score: 0
Kdb+	55	Time Series, Multi-model	Score: 7.66
KeyDB	259	Key-value	Score: 0.32
Kinetica	201	Relational	Score: 0.72
Kognitio	175	Relational	Score: 0.97
Kyoto Cabinet	258	Key-value	Score: 0.32
Kyoto Tycoon	280	Key-value	Score: 0.21
LeanXcale	270	Multi-model	Score: 0.26
LedisDB	343	Key-value	Score: 0
LevelDB	90	Key-value	Score: 3.62
Linter	309	Relational	Score: 0.08
LiteDB	139	Document	Score: 1.62
LMDB	98	Key-value	Score: 3.23
LokiJS	206	Document	Score: 0.7
Lovefield	238	Relational	Score: 0.47
M3DB	281	Time Series	Score: 0.21
Machbase	261	Time Series	Score: 0.3
Manticore Search	314	Search engine	Score: 0.07
MapDB	215	Key-value	Score: 0.62
MariaDB	12	Relational, Multi-model	Score: 93.61
MarkLogic	42	Multi-model	Score: 10.94
Matisse	155	Object oriented	Score: 1.22
MaxDB	77	Relational	Score: 4.75
Memcached	28	Key-value	Score: 25.89
Memgraph	307	Graph	Score: 0.08
Microsoft Access	11	Relational	Score: 116.74
Microsoft Azure Cosmos DB	25	Multi-model	Score: 33.54
Microsoft Azure Data Explorer	78	Relational, Multi-model	Score: 4.7
Microsoft Azure Search	57	Search engine	Score: 6.85
Microsoft Azure SQL Database	16	Relational, Multi-model	Score: 69.49
Microsoft Azure Synapse Analytics	51	Relational	Score: 8.34
Microsoft Azure Table Storage	66	Wide column	Score: 5.68
Microsoft SQL Server	3	Relational, Multi-model	Score: 1038.09
Mimer SQL	260	Relational	Score: 0.31
Mnesia	137	Document	Score: 1.66
Model 204	150	Multivalue	Score: 1.28
ModeShape	243	Content	Score: 0.42
MonetDB	123	Relational, Multi-model	Score: 2.13
MongoDB	5	Document, Multi-model	Score: 457.73
mSQL	131	Relational	Score: 1.84
Mulgara	289	RDF	Score: 0.16
MySQL	2	Relational, Multi-model	Score: 1255.45
NCache	154	Key-value, Multi-model	Score: 1.23
Nebula Graph	184	Graph	Score: 0.86
Neo4j	19	Graph	Score: 54.64
Netezza	34	Relational	Score: 18.33
NEventStore	275	Event	Score: 0.25
Newts	343	Time Series	Score: 0
NexusDB	214	Relational	Score: 0.63
NonStop SQL	164	Relational	Score: 1.14
Northgate Reality	221	Multivalue	Score: 0.56
NosDB	337	Document	Score: 0.01
NSDb	343	Time Series	Score: 0
NuoDB	156	Relational	Score: 1.22
ObjectBox	186	Object oriented, Multi-model	Score: 0.82
ObjectDB	189	Object oriented	Score: 0.81
Objectivity/DB	174	Object oriented	Score: 0.97
ObjectStore	133	Object oriented	Score: 1.76
OmniSci	124	Relational	Score: 2.11
OpenBase	200	Relational	Score: 0.74
OpenEdge	73	Relational	Score: 5.22
OpenInsight	219	Multivalue	Score: 0.58
OpenQM	250	Multivalue	Score: 0.37
OpenTSDB	117	Time Series	Score: 2.44
Oracle	1	Relational, Multi-model	Score: 1325.6
Oracle Berkeley DB	87	Multi-model	Score: 3.77
Oracle Coherence	103	Key-value	Score: 3.03
Oracle Essbase	45	Relational	Score: 9.21
Oracle NoSQL	80	Multi-model	Score: 4.42
Oracle Rdb	151	Relational	Score: 1.28
OrientDB	72	Multi-model	Score: 5.29
OrigoDB	315	Multi-model	Score: 0.05
Percona Server for MongoDB	208	Document	Score: 0.69
Percona Server for MySQL	100	Relational	Score: 3.12
Perst	168	Object oriented	Score: 1.05
PipelineDB	244	Relational	Score: 0.42
PostgreSQL	4	Relational, Multi-model	Score: 547.57
Postgres-XL	225	Relational, Multi-model	Score: 0.55
PouchDB	95	Document	Score: 3.52
Presto	39	Relational	Score: 12.92
Project Voldemort	241	Key-value	Score: 0.45
Prometheus	65	Time Series	Score: 5.75
Quasardb	272	Time Series	Score: 0.26
QuestDB	251	Time Series, Multi-model	Score: 0.37
Raima Database Manager	227	Relational	Score: 0.53
RaptorDB	301	Document	Score: 0.1
Rasdaman	222	Multivalue	Score: 0.56
RavenDB	85	Document, Multi-model	Score: 4.12
R:BASE	183	Relational	Score: 0.86
RDF4J	224	RDF	Score: 0.55
Realm	46	Document	Score: 9.15
Redis	7	Key-value, Multi-model	Score: 153.63
Redland	240	RDF	Score: 0.47
RedStore	333	RDF	Score: 0.02
Resin Cache	327	Key-value	Score: 0.03
RethinkDB	82	Document	Score: 4.3
Riak KV	68	Key-value	Score: 5.55
Riak TS	256	Time Series	Score: 0.34
Rizhiyi	343	Search engine, Multi-model	Score: 0
RocksDB	88	Key-value	Score: 3.72
Rockset	229	Document, Multi-model	Score: 0.52
RRDtool	97	Time Series	Score: 3.3
Sadas Engine	316	Relational	Score: 0.05
SAP Adaptive Server	18	Relational	Score: 54.88
SAP Advantage Database Server	94	Relational	Score: 3.54
SAP HANA	20	Relational, Multi-model	Score: 52.5
SAP IQ	74	Relational	Score: 5.21
SAP SQL Anywhere	60	Relational	Score: 6.49
Scalaris	232	Key-value	Score: 0.51
ScaleArc	180	Relational	Score: 0.9
ScaleOut StateServer	343	Key-value	Score: 0
SciDB	195	Multivalue	Score: 0.76
ScyllaDB	115	Multi-model	Score: 2.51
SearchBlox	246	Search engine	Score: 0.4
searchxml	340	Multi-model	Score: 0.01
Sedna	169	Native XML	Score: 1.04
SenseiDB	305	Document	Score: 0.08
Sequoiadb	252	Multi-model	Score: 0.36
Siaqodb	322	Object oriented	Score: 0.04
SingleStore	64	Relational, Multi-model	Score: 5.88
SiriDB	325	Time Series	Score: 0.04
SiteWhere	335	Time Series	Score: 0.01
SmallSQL	321	Relational	Score: 0.04
Snowflake	41	Relational	Score: 12.91
solidDB	179	Relational	Score: 0.91
Solr	21	Search engine	Score: 51.24
SparkleDB	334	RDF	Score: 0.02
Sparksee	283	Graph	Score: 0.19
Spark SQL	33	Relational	Score: 19.29
Sphinx	61	Search engine	Score: 6.32
Splice Machine	170	Relational	Score: 1.02
Splunk	13	Search engine	Score: 87
SQLBase	140	Relational	Score: 1.62
SQLite	9	Relational	Score: 121.68
SQL.JS	198	Relational	Score: 0.75
SQream DB	216	Relational	Score: 0.62
Starcounter	234	Object oriented	Score: 0.49
Stardog	144	Multi-model	Score: 1.47
Strabon	291	RDF	Score: 0.16
STSdb	296	Key-value	Score: 0.12
SwayDB	312	Key-value	Score: 0.07
SWC-DB	343	Wide column, Multi-model	Score: 0
Tajo	249	Relational	Score: 0.38
Tarantool	132	Key-value, Multi-model	Score: 1.78
Teradata	14	Relational, Multi-model	Score: 73.83
TerarkDB	320	Key-value	Score: 0.05
TerminusDB	300	Graph, Multi-model	Score: 0.11
Tibco ComputeDB	248	Relational	Score: 0.38
Tibero	122	Relational	Score: 2.25
TiDB	118	Relational, Multi-model	Score: 2.4
TigerGraph	145	Graph	Score: 1.47
TimescaleDB	104	Time Series, Multi-model	Score: 2.98
TimesTen	113	Relational	Score: 2.54
TinkerGraph	286	Graph	Score: 0.17
Tokyo Cabinet	192	Key-value	Score: 0.78
Tokyo Tyrant	213	Key-value	Score: 0.64
TomP2P	343	Key-value	Score: 0
ToroDB	326	Document	Score: 0.03
Trafodion	231	Relational	Score: 0.51
Transbase	271	Relational	Score: 0.26
TransLattice	285	Relational	Score: 0.17
UniData,UniVerse	81	Multivalue	Score: 4.33
Upscaledb	290	Key-value	Score: 0.16
Valentina Server	267	Relational	Score: 0.28
VelocityDB	308	Multi-model	Score: 0.08
Vertica	32	Relational, Multi-model	Score: 22.21
VictoriaMetrics	282	Time Series	Score: 0.2
Virtuoso	112	Multi-model	Score: 2.58
VistaDB	209	Relational	Score: 0.68
VoltDB	127	Relational	Score: 2
WakandaDB	298	Object oriented	Score: 0.11
Warp 10	287	Time Series	Score: 0.17
Weaviate	319	Search engine	Score: 0.05
WebSphere eXtreme Scale	193	Key-value	Score: 0.78
WhiteDB	302	Document	Score: 0.1
WiredTiger	163	Key-value	Score: 1.15
Xapian	172	Search engine	Score: 1.01
XtremeData	279	Relational	Score: 0.22
Yaacomo	343	Relational	Score: 0
Yanza	343	Time Series	Score: 0
Yellowbrick	191	Relational	Score: 0.79
YugabyteDB	152	Relational, Multi-model	Score: 1.28
ZODB	177	Key-value	Score: 0.95
\.

COPY schemata.engines (engine_name, label, has_go_driver, has_information_schema, remarks) FROM stdin;
1010data
4D
4store
Accumulo
Actian FastObjects
Actian NoSQL Database
Actian PSQL
Actian Vector
ActivePivot
ActorDB
Adabas
Aerospike
AgensGraph
AlaSQL
Algolia
Alibaba Cloud AnalyticDB for MySQL
Alibaba Cloud AnalyticDB for PostgreSQL
Alibaba Cloud ApsaraDB for PolarDB
Alibaba Cloud Log Service
Alibaba Cloud MaxCompute		yes
Alibaba Cloud Table Store
Alibaba Cloud TSDB
AllegroGraph
Altibase
Amazon Aurora
Amazon CloudSearch
Amazon DocumentDB
Amazon DynamoDB
Amazon Keyspaces
Amazon Neptune
Amazon Redshift
Amazon SimpleDB
Amazon Timestream
AnzoGraph DB
Apache Drill
Apache Druid
Apache IoTDB
Apache Jena - TDB
Apache Phoenix		yes
ArangoDB
Axibase
Badger
Bangdb
BaseX
BergDB
BigchainDB
BigObject
Blazegraph
Blueflood
BoltDB
BrightstarDB
Brytlyt
Cachelot.io
Cassandra
Citus
ClickHouse		yes
CloudKit
CockroachDB		yes
Comdb2
CortexDB
Couchbase		yes
CouchDB
CovenantSQL
CrateDB
Crux
CubicWeb
Cubrid
D3
DaggerDB
Datacom/DB
DataEase
Datameer
Datastax Enterprise
Datomic
Db4o
dBASE
DBISAM
DensoDB
Derby			no
Dgraph
DolphinDB
DuckDB
Dydra
EDB Postgres
Edge Intelligence
Ehcache
EJDB
Elassandra
Elasticsearch
ElevateDB
Elliptics
Eloquera
Empress
EsgynDB
etcd
EventStoreDB
EXASOL
eXist-db
Exorbyte
eXtremeDB
Faircom DB
Faircom EDGE
FaunaDB
FileMaker
FinchDB
Firebase Realtime Database
Firebird		yes	no
FlockDB
Fluree
FoundationDB
FrontBase
GBase
GemStone/S
Geode
GeoSpock
GigaSpaces InsightEdge
Giraph
Google BigQuery		yes
Google Cloud Bigtable
Google Cloud Datastore
Google Cloud Firestore
Google Cloud Spanner		yes
Grakn
GraphBase
GraphDB
Graph Engine
Graphite
Greenplum
GridDB
GridGain
GT.M
H2	h2	yes	yes	Version 1.4.200
HarperDB
Hawkular Metrics
HAWQ
Hazelcast
HBase
Helium
Heroic
HFSQL
HGraphDB
Hibari
Hive		yes
HPE Ezmeral Data Fabric
HugeGraph
HyperGraphDB
HyperLevelDB
HyperSQL	hsqldb		yes	Version 2.5.1
Hyprcubd
IBM Cloudant
IBM Db2 Event Store
IBM Db2 warehouse
IBM Db2		yes
iBoxDB
IDMS
Ignite		yes
Impala		yes
IMS
Indica
Infinispan
InfiniteGraph
InfinityDB
InfluxDB
Infobright
Informix			no
Ingres			no
Interbase
InterSystems Caché		no?	yes
InterSystems IRIS
IRONdb
ITTIA
Jackrabbit
Jade
JaguarDB
JanusGraph
JasDB
jBASE
JethroData
JSqlDb
KairosDB
Kdb+
K-DB
KeyDB
Kinetica
Kognitio
Kyoto Cabinet
Kyoto Tycoon
LeanXcale
LedisDB
LevelDB
Linter
LiteDB
LMDB
LokiJS
Lovefield
M3DB
Machbase
Manticore Search
MapDB
MariaDB	mariadb	yes	yes	Version 10.3
MarkLogic
Matisse
MaxDB
Memcached
Memgraph
Microsoft Access			no
Microsoft Azure Cosmos DB		yes
Microsoft Azure Data Explorer
Microsoft Azure Search
Microsoft Azure SQL Database
Microsoft Azure Synapse Analytics
Microsoft Azure Table Storage
Microsoft SQL Server	mssql	yes	yes	Version 2019
Mimer SQL
Mnesia
Model 204
ModeShape
MonetDB
MongoDB
mSQL
Mulgara
MySQL	mysql	yes	yes	driver compatible with MariaDB
NCache
Nebula Graph
Neo4j
Netezza
NEventStore
Newts
NexusDB
NonStop SQL
Northgate Reality
NosDB
NSDb
NuoDB
ObjectBox
ObjectDB
Objectivity/DB
ObjectStore
OmniSci
OpenBase
OpenEdge
OpenInsight
OpenQM
OpenTSDB
Oracle Berkeley DB
Oracle Coherence
Oracle Essbase
Oracle NoSQL
Oracle	ora	yes	no
Oracle Rdb
OrientDB
OrigoDB
Percona Server for MongoDB
Percona Server for MySQL
Perst
PipelineDB
PostgreSQL	pg	yes	yes	Version 12.5
Postgres-XL
PouchDB
Presto		yes
Project Voldemort
Prometheus
Quasardb
QuestDB
Raima Database Manager
RaptorDB
Rasdaman
RavenDB
R:BASE
RDF4J
Realm
Redis
Redland
RedStore
Resin Cache
RethinkDB
Riak KV
Riak TS
Rizhiyi
RocksDB
Rockset
RRDtool
Sadas Engine
SAP Adaptive Server		yes	no?
SAP Advantage Database Server
SAP HANA		yes	no?
SAP IQ
SAP SQL Anywhere			no
Scalaris
ScaleArc
ScaleOut StateServer
SciDB
ScyllaDB
SearchBlox
searchxml
Sedna
SenseiDB
Sequoiadb
Siaqodb
SingleStore
SiriDB
SiteWhere
SmallSQL
Snowflake
solidDB
Solr
SparkleDB
Sparksee
Spark SQL
Sphinx
Splice Machine
Splunk
SQLBase
SQLite	sqlite	yes	no	Version 3.23.1
SQL.JS
SQream DB
Starcounter
Stardog
Strabon
STSdb
SwayDB
SWC-DB
Tajo
Tarantool
Teradata			no
TerarkDB
TerminusDB
Tibco ComputeDB
Tibero
TiDB		yes
TigerGraph
TimescaleDB
TimesTen
TinkerGraph
Tokyo Cabinet
Tokyo Tyrant
TomP2P
ToroDB
Trafodion
Transbase
TransLattice
UniData,UniVerse
Upscaledb
Valentina Server
VelocityDB
Vertica		yes
VictoriaMetrics
Virtuoso
VistaDB
VoltDB
WakandaDB
Warp 10
Weaviate
WebSphere eXtreme Scale
WhiteDB
WiredTiger
Xapian
XtremeData
Yaacomo
Yanza
Yellowbrick
YugabyteDB
ZODB
\.

COPY schemata.information_columns (label, table_catalog, table_schema, table_name, column_name, ordinal_position, data_type) FROM stdin;
h2	db_name	INFORMATION_SCHEMA	CATALOGS	CATALOG_NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLLATIONS	KEY	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLLATIONS	NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	COLUMN_NAME	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTEE	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTOR	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	IS_GRANTABLE	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_CATALOG	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_NAME	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_SCHEMA	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_OCTET_LENGTH	10	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_NAME	14	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	CHECK_CONSTRAINT	20	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	COLLATION_NAME	15	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_DEFAULT	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_NAME	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_ON_UPDATE	25	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_TYPE	24	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	DATA_TYPE	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	IS_COMPUTED	18	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	COLUMNS	IS_NULLABLE	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	NULLABLE	17	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION	11	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION_RADIX	12	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_SCALE	13	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	ORDINAL_POSITION	5	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	REMARKS	22	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	SELECTIVITY	19	INTEGER
h2	db_name	INFORMATION_SCHEMA	COLUMNS	SEQUENCE_NAME	21	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	SOURCE_DATA_TYPE	23	SMALLINT
h2	db_name	INFORMATION_SCHEMA	COLUMNS	TABLE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	TABLE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	TABLE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	COLUMNS	TYPE_NAME	16	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	CONSTANT_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	CONSTANT_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	CONSTANT_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	DATA_TYPE	4	INTEGER
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	ID	7	INTEGER
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	REMARKS	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTANTS	SQL	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	CHECK_EXPRESSION	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	COLUMN_LIST	10	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	CONSTRAINT_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	CONSTRAINT_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	CONSTRAINT_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	CONSTRAINT_TYPE	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	ID	13	INTEGER
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	REMARKS	11	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	SQL	12	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	TABLE_CATALOG	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	TABLE_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	TABLE_SCHEMA	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CONSTRAINTS	UNIQUE_INDEX_NAME	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	DEFERRABILITY	14	SMALLINT
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	DELETE_RULE	11	SMALLINT
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	FKCOLUMN_NAME	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	FK_NAME	12	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	FKTABLE_CATALOG	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	FKTABLE_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	FKTABLE_SCHEMA	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	ORDINAL_POSITION	9	SMALLINT
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	PKCOLUMN_NAME	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	PK_NAME	13	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	PKTABLE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	PKTABLE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	PKTABLE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	CROSS_REFERENCES	UPDATE_RULE	10	SMALLINT
h2	db_name	INFORMATION_SCHEMA	DOMAINS	CHECK_CONSTRAINT	11	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	COLUMN_DEFAULT	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	DATA_TYPE	6	INTEGER
h2	db_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	ID	14	INTEGER
h2	db_name	INFORMATION_SCHEMA	DOMAINS	IS_NULLABLE	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	PRECISION	7	INTEGER
h2	db_name	INFORMATION_SCHEMA	DOMAINS	REMARKS	12	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	SCALE	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	DOMAINS	SELECTIVITY	10	INTEGER
h2	db_name	INFORMATION_SCHEMA	DOMAINS	SQL	13	VARCHAR
h2	db_name	INFORMATION_SCHEMA	DOMAINS	TYPE_NAME	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	ALIAS_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	ALIAS_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	ALIAS_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	COLUMN_COUNT	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	DATA_TYPE	6	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	ID	11	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	JAVA_CLASS	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	JAVA_METHOD	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	REMARKS	10	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	RETURNS_RESULT	9	SMALLINT
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	SOURCE	12	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_ALIASES	TYPE_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	ALIAS_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	ALIAS_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	ALIAS_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	COLUMN_COUNT	6	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	COLUMN_DEFAULT	17	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	COLUMN_NAME	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	COLUMN_TYPE	15	SMALLINT
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	DATA_TYPE	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	JAVA_CLASS	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	JAVA_METHOD	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	NULLABLE	14	SMALLINT
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	POS	7	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	PRECISION	11	INTEGER
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	RADIX	13	SMALLINT
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	REMARKS	16	VARCHAR
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	SCALE	12	SMALLINT
h2	db_name	INFORMATION_SCHEMA	FUNCTION_COLUMNS	TYPE_NAME	10	VARCHAR
h2	db_name	INFORMATION_SCHEMA	HELP	ID	1	INTEGER
h2	db_name	INFORMATION_SCHEMA	HELP	SECTION	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	HELP	SYNTAX	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	HELP	TEXT	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	HELP	TOPIC	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	AFFINITY	22	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	INDEXES	ASC_OR_DESC	13	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	CARDINALITY	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	INDEXES	COLUMN_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	CONSTRAINT_NAME	20	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	FILTER_CONDITION	15	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	ID	18	INTEGER
h2	db_name	INFORMATION_SCHEMA	INDEXES	INDEX_CLASS	21	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	INDEX_NAME	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	INDEX_TYPE	12	SMALLINT
h2	db_name	INFORMATION_SCHEMA	INDEXES	INDEX_TYPE_NAME	10	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	IS_GENERATED	11	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	INDEXES	NON_UNIQUE	4	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	INDEXES	ORDINAL_POSITION	6	SMALLINT
h2	db_name	INFORMATION_SCHEMA	INDEXES	PAGES	14	INTEGER
h2	db_name	INFORMATION_SCHEMA	INDEXES	PRIMARY_KEY	9	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	INDEXES	REMARKS	16	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	SORT_TYPE	19	INTEGER
h2	db_name	INFORMATION_SCHEMA	INDEXES	SQL	17	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	TABLE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	TABLE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	INDEXES	TABLE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	IN_DOUBT	STATE	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	IN_DOUBT	TRANSACTION	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	COLUMN_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	POSITION_IN_UNIQUE_CONSTRAINT	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_CATALOG	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_NAME	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	LOCKS	LOCK_TYPE	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	LOCKS	SESSION_ID	3	INTEGER
h2	db_name	INFORMATION_SCHEMA	LOCKS	TABLE_NAME	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	LOCKS	TABLE_SCHEMA	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	AVERAGE_EXECUTION_TIME	6	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	AVERAGE_ROW_COUNT	11	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	CUMULATIVE_EXECUTION_TIME	5	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	CUMULATIVE_ROW_COUNT	10	BIGINT
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	EXECUTION_COUNT	2	INTEGER
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	MAX_EXECUTION_TIME	4	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	MAX_ROW_COUNT	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	MIN_EXECUTION_TIME	3	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	MIN_ROW_COUNT	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	SQL_STATEMENT	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	STD_DEV_EXECUTION_TIME	7	DOUBLE
h2	db_name	INFORMATION_SCHEMA	QUERY_STATISTICS	STD_DEV_ROW_COUNT	12	DOUBLE
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	GRANTEDROLE	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	GRANTEE	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	GRANTEETYPE	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	ID	7	INTEGER
h2	db_name	INFORMATION_SCHEMA	RIGHTS	RIGHTS	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	TABLE_NAME	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	RIGHTS	TABLE_SCHEMA	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	ROLES	ID	3	INTEGER
h2	db_name	INFORMATION_SCHEMA	ROLES	NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	ROLES	REMARKS	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	CATALOG_NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_COLLATION_NAME	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	ID	8	INTEGER
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	IS_DEFAULT	6	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	REMARKS	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_NAME	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_OWNER	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	CACHE	8	BIGINT
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	CURRENT_VALUE	4	BIGINT
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	ID	12	INTEGER
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	INCREMENT	5	BIGINT
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	IS_CYCLE	11	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	IS_GENERATED	6	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	MAX_VALUE	10	BIGINT
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	MIN_VALUE	9	BIGINT
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	REMARKS	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSIONS	CONTAINS_UNCOMMITTED	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSIONS	ID	1	INTEGER
h2	db_name	INFORMATION_SCHEMA	SESSIONS	SESSION_START	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSIONS	STATEMENT	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSIONS	STATEMENT_START	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSION_STATE	KEY	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSION_STATE	SQL	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SESSIONS	USER_NAME	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SETTINGS	NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SETTINGS	VALUE	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	ID	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	REMARKS	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	STATUS	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	SYNONYM_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	SYNONYM_FOR	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	SYNONYM_FOR_SCHEMA	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	SYNONYM_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	SYNONYM_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	SYNONYMS	TYPE_NAME	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	INITIALLY_DEFERRED	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	IS_DEFERRABLE	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_CATALOG	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_SCHEMA	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTEE	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTOR	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	IS_GRANTABLE	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	PRIVILEGE_TYPE	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_CATALOG	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_NAME	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_SCHEMA	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	ID	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	TABLES	LAST_MODIFICATION	8	BIGINT
h2	db_name	INFORMATION_SCHEMA	TABLES	REMARKS	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	ROW_COUNT_ESTIMATE	12	BIGINT
h2	db_name	INFORMATION_SCHEMA	TABLES	SQL	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	STORAGE_TYPE	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TABLE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TABLE_CLASS	11	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TABLE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TABLE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TABLE_TYPE	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLES	TYPE_NAME	10	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TABLE_TYPES	TYPE	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	BEFORE	8	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	ID	14	INTEGER
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	JAVA_CLASS	9	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	NO_WAIT	11	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	QUEUE_SIZE	10	INTEGER
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	REMARKS	12	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	SQL	13	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TABLE_CATALOG	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TABLE_NAME	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TABLE_SCHEMA	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_TYPE	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	AUTO_INCREMENT	7	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	CASE_SENSITIVE	12	BOOLEAN
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	DATA_TYPE	2	INTEGER
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	MAXIMUM_SCALE	9	SMALLINT
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	MINIMUM_SCALE	8	SMALLINT
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	NULLABLE	13	SMALLINT
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	PARAMS	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	POS	11	INTEGER
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	PRECISION	3	INTEGER
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	PREFIX	4	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	RADIX	10	INTEGER
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	SEARCHABLE	14	SMALLINT
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	SUFFIX	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	TYPE_INFO	TYPE_NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	USERS	ADMIN	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	USERS	ID	4	INTEGER
h2	db_name	INFORMATION_SCHEMA	USERS	NAME	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	USERS	REMARKS	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	CHECK_OPTION	5	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	ID	9	INTEGER
h2	db_name	INFORMATION_SCHEMA	VIEWS	IS_UPDATABLE	6	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	REMARKS	8	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	STATUS	7	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	TABLE_CATALOG	1	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	TABLE_NAME	3	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	TABLE_SCHEMA	2	VARCHAR
h2	db_name	INFORMATION_SCHEMA	VIEWS	VIEW_DEFINITION	4	VARCHAR
hsqldb	PUBLIC	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	GRANTEE	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	IS_GRANTABLE	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	ROLE_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	APPLICABLE_ROLES	GRANTEE	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	APPLICABLE_ROLES	IS_GRANTABLE	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	APPLICABLE_ROLES	ROLE_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ASSERTIONS	INITIALLY_DEFERRED	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ASSERTIONS	IS_DEFERRABLE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	AUTHORIZATIONS	AUTHORIZATION_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	AUTHORIZATIONS	AUTHORIZATION_TYPE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_REPERTOIRE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_CATALOG	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_SCHEMA	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHARACTER_SETS	FORM_OF_USE	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CHECK_CLAUSE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLLATIONS	COLLATION_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLLATIONS	COLLATION_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLLATIONS	COLLATION_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLLATIONS	PAD_ATTRIBUTE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	DEPENDENT_COLUMN	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	COLUMN_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	COLUMN_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	IS_GRANTABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	CHARACTER_OCTET_LENGTH	10	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_CATALOG	17	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_NAME	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_SCHEMA	18	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	COLLATION_CATALOG	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	COLLATION_NAME	22	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	COLLATION_SCHEMA	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	COLUMN_DEFAULT	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DATA_TYPE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DATETIME_PRECISION	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DECLARED_DATA_TYPE	48	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DECLARED_NUMERIC_PRECISION	49	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DECLARED_NUMERIC_SCALE	50	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DOMAIN_CATALOG	23	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DOMAIN_NAME	25	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DOMAIN_SCHEMA	24	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	DTD_IDENTIFIER	33	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	GENERATION_EXPRESSION	43	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_CYCLE	41	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_GENERATION	36	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_INCREMENT	38	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_MAXIMUM	39	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_MINIMUM	40	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IDENTITY_START	37	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	INTERVAL_PRECISION	16	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	INTERVAL_TYPE	15	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_GENERATED	42	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_IDENTITY	35	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_NULLABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_SELF_REFERENCING	34	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_SYSTEM_TIME_PERIOD_END	45	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_SYSTEM_TIME_PERIOD_START	44	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	IS_UPDATABLE	47	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	MAXIMUM_CARDINALITY	32	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION	11	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION_RADIX	12	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	NUMERIC_SCALE	13	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	ORDINAL_POSITION	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	SCOPE_CATALOG	29	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	SCOPE_NAME	31	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	SCOPE_SCHEMA	30	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	SYSTEM_TIME_PERIOD_TIMESTAMP_GENERATION	46	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	UDT_CATALOG	26	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	UDT_NAME	28	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMNS	UDT_SCHEMA	27	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	COLUMN_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_CATALOG	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_SCHEMA	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	CONSTRAINT_CATALOG	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	CONSTRAINT_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	CONSTRAINT_SCHEMA	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	PERIOD_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_PERIOD_USAGE	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	DTD_IDENTIFIER	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	INITIALLY_DEFERRED	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	IS_DEFERRABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	CHARACTER_MAXIMUM_LENGTH	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	CHARACTER_OCTET_LENGTH	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	COLLATION_CATALOG	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	COLLATION_NAME	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	COLLATION_SCHEMA	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DATA_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DATETIME_PRECISION	16	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DECLARED_DATA_TYPE	22	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DECLARED_NUMERIC_PRECISION	23	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DECLARED_NUMERIC_SCALE	24	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DOMAIN_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DOMAIN_DEFAULT	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DOMAIN_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DOMAIN_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	DTD_IDENTIFIER	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	INTERVAL_PRECISION	18	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	INTERVAL_TYPE	17	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	MAXIMUM_CARDINALITY	20	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION	13	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION_RADIX	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	DOMAINS	NUMERIC_SCALE	15	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_MAXIMUM_LENGTH	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_OCTET_LENGTH	8	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_CATALOG	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_NAME	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_SCHEMA	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_CATALOG	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_NAME	14	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_SCHEMA	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLECTION_TYPE_IDENTIFIER	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DATA_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DATETIME_PRECISION	18	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DECLARED_DATA_TYPE	29	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DECLARED_NUMERIC_PRECISION	30	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DECLARED_NUMERIC_SCALE	31	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	DTD_IDENTIFIER	28	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	INTERVAL_PRECISION	20	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	INTERVAL_TYPE	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	MAXIMUM_CARDINALITY	27	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_PRECISION	15	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_PRECISION_RADIX	16	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_SCALE	17	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_CATALOG	24	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_NAME	26	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_SCHEMA	25	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_CATALOG	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_NAME	23	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_SCHEMA	22	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ENABLED_ROLES	ROLE_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	INFORMATION_SCHEMA_CATALOG_NAME	CATALOG_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	JAR_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	JAR_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	JAR_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	PATH_JAR_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	PATH_JAR_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JAR_JAR_USAGE	PATH_JAR_SCHAMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JARS	JAR_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JARS	JAR_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JARS	JAR_PATH	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	JARS	JAR_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	COLUMN_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	POSITION_IN_UNIQUE_CONSTRAINT	9	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	PERIOD_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	KEY_PERIOD_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	AS_LOCATOR	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_MAXIMUM_LENGTH	16	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_OCTET_LENGTH	17	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_CATALOG	18	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_NAME	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_SCHEMA	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	COLLATION_CATALOG	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	COLLATION_NAME	23	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	COLLATION_SCHEMA	22	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DATA_TYPE	15	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DATETIME_PRECISION	27	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DECLARED_DATA_TYPE	38	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DECLARED_NUMERIC_PRECISION	39	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DECLARED_NUMERIC_SCALE	40	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	DTD_IDENTIFIER	37	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_CATALOG	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_NAME	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_SCHEMA	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_PRECISION	29	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_TYPE	28	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	IS_RESULT	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	MAXIMUM_CARDINALITY	36	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION	24	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION_RADIX	25	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_SCALE	26	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	ORDINAL_POSITION	4	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_MODE	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SCOPE_CATALOG	33	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SCOPE_NAME	35	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SCOPE_SCHEMA	34	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_CATALOG	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_NAME	14	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_SCHEMA	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	UDT_CATALOG	30	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	UDT_NAME	32	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PARAMETERS	UDT_SCHEMA	31	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	END_COLUMN_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	PERIOD_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	START_COLUMN_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	PERIODS	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	GRANTOR	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	IS_GRANTABLE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	ROLE_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	COLUMN_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	IS_GRANTABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	PRIVILEGE_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	IS_GRANTABLE	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	PRIVILEGE_TYPE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_CATALOG	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_SCHEMA	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	IS_GRANTABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	PRIVILEGE_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	WITH_HIERARCHY	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	IS_GRANTABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	PRIVILEGE_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	IS_GRANTABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	PRIVILEGE_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	COLUMN_NAME	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	JAR_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	JAR_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	JAR_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_JAR_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	PERIOD_NAME	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	ROUTINE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	ROUTINE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	ROUTINE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	TABLE_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	TABLE_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PERIOD_USAGE	TABLE_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	IS_GRANTABLE	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	PRIVILEGE_TYPE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_CATALOG	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_SCHEMA	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	AS_LOCATOR	54	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CHARACTER_MAXIMUM_LENGTH	15	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CHARACTER_OCTET_LENGTH	16	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_CATALOG	17	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_NAME	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_SCHEMA	18	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	COLLATION_CATALOG	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	COLLATION_NAME	22	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	COLLATION_SCHEMA	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	CREATED	55	TIMESTAMP
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DATA_TYPE	14	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DATETIME_PRECISION	26	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DECLARED_DATA_TYPE	83	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DECLARED_NUMERIC_PRECISION	84	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DECLARED_NUMERIC_SCALE	85	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	DTD_IDENTIFIER	36	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_LANGUAGE	40	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_NAME	39	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	INTERVAL_PRECISION	28	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	INTERVAL_TYPE	27	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	IS_DETERMINISTIC	42	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	IS_IMPLICITLY_INVOCABLE	49	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	IS_NULL_CALL	44	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	IS_UDT_DEPENDENT	58	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	IS_USER_DEFINED_CAST	48	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	LAST_ALTERED	56	TIMESTAMP
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	MAX_DYNAMIC_RESULT_SETS	47	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	MAXIMUM_CARDINALITY	35	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	MODULE_CATALOG	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	MODULE_NAME	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	MODULE_SCHEMA	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	NEW_SAVEPOINT_LEVEL	57	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION	23	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION_RADIX	24	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	NUMERIC_SCALE	25	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	PARAMETER_STYLE	41	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_AS_LOCATOR	60	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHARACTER_SET_NAME	65	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_MAX_LENGTH	61	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_OCTET_LENGTH	62	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_SET_CATALOG	63	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_SET_SCHEMA	64	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_CATALOG	66	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_NAME	68	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_SCHEMA	67	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DATETIME_PRECISION	72	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DECLARED_NUMERIC_PRECISION	87	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DECLARED_NUMERIC_SCALE	88	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DTD_IDENTIFIER	82	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_FROM_DATA_TYPE	59	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_FROM_DECLARED_DATA_TYPE	86	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_INTERVAL_PRECISION	74	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_INTERVAL_TYPE	73	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_MAX_CARDINALITY	81	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_PRECISION	69	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_RADIX	70	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_SCALE	71	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_CATALOG	78	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_NAME	80	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_SCHEMA	79	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_CATALOG	75	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_NAME	77	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_SCHEMA	76	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_BODY	37	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_DEFINITION	38	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	ROUTINE_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SCHEMA_LEVEL_ROUTINE	46	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SCOPE_CATALOG	32	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SCOPE_NAME	34	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SCOPE_SCHEMA	33	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SECURITY_TYPE	50	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SQL_DATA_ACCESS	43	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	SQL_PATH	45	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_CATALOG	51	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_NAME	53	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_SCHEMA	52	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_CATALOG	29	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_NAME	31	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_SCHEMA	30	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	UDT_CATALOG	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	UDT_NAME	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINES	UDT_SCHEMA	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	CATALOG_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_OWNER	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SCHEMATA	SQL_PATH	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	CYCLE_OPTION	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	DATA_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	DECLARED_DATA_TYPE	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	DECLARED_NUMERIC_PRECISION	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	DECLARED_NUMERIC_SCALE	15	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	INCREMENT	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	MAXIMUM_VALUE	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	MINIMUM_VALUE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	NEXT_VALUE	17	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION_RADIX	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_SCALE	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	START_VALUE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SEQUENCES	START_WITH	16	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	COMMENTS	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	FEATURE_ID	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	FEATURE_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	IS_SUPPORTED	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	IS_VERIFIED_BY	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	SUB_FEATURE_ID	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_FEATURES	SUB_FEATURE_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	CHARACTER_VALUE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	COMMENTS	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_ID	1	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	INTEGER_VALUE	3	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PACKAGES	COMMENTS	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PACKAGES	ID	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PACKAGES	IS_SUPPORTED	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PACKAGES	IS_VERIFIED_BY	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PACKAGES	NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PARTS	COMMENTS	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PARTS	IS_SUPPORTED	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PARTS	IS_VERIFIED_BY	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PARTS	NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_PARTS	PART	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING	COMMENTS	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	COMMENTS	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_ID	3	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	REQUIRED_VALUE	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	SIZING_ID	1	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	SIZING_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING	SIZING_ID	1	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING	SIZING_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SQL_SIZING	SUPPORTED_VALUE	3	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	BUFFER_LENGTH	6	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	COLUMN_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	COLUMN_SIZE	5	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	DATA_TYPE	3	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	DECIMAL_DIGITS	7	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	IN_KEY	13	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	NULLABLE	12	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	PSEUDO_COLUMN	8	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	SCOPE	1	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	TABLE_CAT	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	TABLE_NAME	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	TABLE_SCHEM	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_BESTROWIDENTIFIER	TYPE_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	CACHE_BYTES	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	CACHE_FILE	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	CACHE_SIZE	4	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	FILE_FREE_POS	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	FILE_LOST_BYTES	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	MAX_CACHE_BYTES	3	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CACHEINFO	MAX_CACHE_COUNT	2	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	BUFFER_LENGTH	8	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	CHAR_OCTET_LENGTH	16	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	COLUMN_DEF	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	COLUMN_SIZE	7	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	DATA_TYPE	5	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	DECIMAL_DIGITS	9	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	SEQUENCE_CATALOG	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	SEQUENCE_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	SEQUENCE_SCHEMA	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMN_SEQUENCE_USAGE	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	IS_AUTOINCREMENT	23	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	IS_GENERATEDCOLUMN	24	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	IS_NULLABLE	18	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	NULLABLE	11	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	NUM_PREC_RADIX	10	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	ORDINAL_POSITION	17	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	REMARKS	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SCOPE_CATALOG	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SCOPE_SCHEMA	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SCOPE_TABLE	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SOURCE_DATA_TYPE	22	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SQL_DATA_TYPE	14	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	SQL_DATETIME_SUB	15	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	TABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	TABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COLUMNS	TYPE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	COLUMN_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	COMMENT	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	OBJECT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	OBJECT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	OBJECT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_COMMENTS	OBJECT_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CONNECTION_PROPERTIES	DEFAULT_VALUE	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CONNECTION_PROPERTIES	DESCRIPTION	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CONNECTION_PROPERTIES	MAX_LEN	2	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CONNECTION_PROPERTIES	NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	DEFERRABILITY	14	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	DELETE_RULE	11	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	FKCOLUMN_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	FK_NAME	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	FKTABLE_CAT	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	FKTABLE_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	FKTABLE_SCHEM	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	KEY_SEQ	9	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	PKCOLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	PK_NAME	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	PKTABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	PKTABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	PKTABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_CROSSREFERENCE	UPDATE_RULE	10	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	ASC_OR_DESC	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	CARDINALITY	11	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	COLUMN_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	FILTER_CONDITION	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	INDEX_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	INDEX_QUALIFIER	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	NON_UNIQUE	4	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	ORDINAL_POSITION	8	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	PAGES	12	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	ROW_CARDINALITY	14	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	TABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	TABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXINFO	TYPE	7	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	ALLOCATED_ROWS	8	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	ALLOCATED_SPACE	10	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	BASE_SPACE	12	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	CARDINALITY	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	INDEX_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	ORDINAL_POSITION	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	SPACE_ID	11	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	TABLE_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_INDEXSTATS	USED_SPACE	9	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	INDEX_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	INDEX_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_KEY_INDEX_USAGE	INDEX_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	KEY_SEQ	5	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	PK_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	TABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PRIMARYKEYS	TABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	CHAR_OCTET_LENGTH	17	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	COLUMN_DEF	14	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	COLUMN_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	COLUMN_TYPE	5	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	DATA_TYPE	6	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	IS_NULLABLE	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	LENGTH	9	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	NULLABLE	12	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	ORDINAL_POSITION	18	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	PRECISION	8	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	PROCEDURE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	PROCEDURE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	PROCEDURE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	RADIX	11	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	REMARKS	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	SCALE	10	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	SPECIFIC_NAME	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	SQL_DATA_TYPE	15	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	SQL_DATETIME_SUB	16	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURECOLUMNS	TYPE_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	COL_4	4	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	COL_5	5	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	COL_6	6	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	PROCEDURE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	PROCEDURE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	PROCEDURE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	PROCEDURE_TYPE	8	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	REMARKS	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROCEDURES	SPECIFIC_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROPERTIES	PROPERTY_CLASS	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROPERTIES	PROPERTY_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROPERTIES	PROPERTY_NAMESPACE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROPERTIES	PROPERTY_SCOPE	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_PROPERTIES	PROPERTY_VALUE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SCHEMAS	IS_DEFAULT	3	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SCHEMAS	TABLE_CATALOG	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SCHEMAS	TABLE_SCHEM	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	CYCLE_OPTION	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	DATA_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	DECLARED_DATA_TYPE	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	DECLARED_NUMERIC_PRECISION	13	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	DECLARED_NUMERIC_SCALE	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	INCREMENT	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	MAXIMUM_VALUE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	MINIMUM_VALUE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	NEXT_VALUE	16	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	NUMERIC_PRECISION	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	NUMERIC_PRECISION_RADIX	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	NUMERIC_SCALE	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	SEQUENCE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	SEQUENCE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	SEQUENCE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SEQUENCES	START_WITH	15	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONINFO	KEY	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONINFO	VALUE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	AUTOCOMMIT	5	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	CONNECTED	2	TIMESTAMP
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	CURRENT_STATEMENT	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	IS_ADMIN	4	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	LAST_IDENTITY	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	LATCH_COUNT	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	READONLY	6	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	SESSION_ID	1	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	THIS_WAITING_FOR	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	TRANSACTION	9	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	TRANSACTION_SIZE	10	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	USER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SESSIONS	WAITING_FOR_THIS	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	OBJECT_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	OBJECT_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	OBJECT_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	OBJECT_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	SYNONYM_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	SYNONYM_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_SYNONYMS	SYNONYM_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	COMMIT_ACTION	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	HSQLDB_TYPE	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	READ_ONLY	12	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	REF_GENERATION	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	REMARKS	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	SELF_REFERENCING_COL_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TABLE_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	ALLOCATED_SPACE	8	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	CARDINALITY	5	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	SPACE_ID	6	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	TABLE_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	USED_MEMORY	9	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLESTATS	USED_SPACE	7	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TYPE_CAT	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TYPE_NAME	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLES	TYPE_SCHEM	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TABLETYPES	TABLE_TYPE	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	DATA_SOURCE_DEFINTION	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	FIELD_SEPARATOR	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	FILE_ENCODING	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	FILE_PATH	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	IS_ALL_QUOTED	12	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	IS_DESC	13	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	IS_IGNORE_FIRST	10	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	IS_QUOTED	11	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	LONGVARCHAR_SEPARATOR	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	TABLE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	TABLE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TEXTTABLES	VARCHAR_SEPARATOR	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	AUTO_INCREMENT	12	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	CASE_SENSITIVE	8	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	CREATE_PARAMS	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	DATA_TYPE	2	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	FIXED_PREC_SCALE	11	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	INTERVAL_PRECISION	19	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	LITERAL_PREFIX	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	LITERAL_SUFFIX	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	LOCAL_TYPE_NAME	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	MAXIMUM_SCALE	15	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	MINIMUM_SCALE	14	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	NULLABLE	7	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	NUM_PREC_RADIX	18	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	PRECISION	3	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	SEARCHABLE	9	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	SQL_DATA_TYPE	16	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	SQL_DATETIME_SUB	17	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	TYPE_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_TYPEINFO	UNSIGNED_ATTRIBUTE	10	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	BASE_TYPE	7	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	CLASS_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	DATA_TYPE	5	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	REMARKS	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	TYPE_CAT	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	TYPE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_UDTS	TYPE_SCHEM	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_USERS	ADMIN	2	BOOLEAN
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_USERS	AUTHENTICATION	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_USERS	INITIAL_SCHEMA	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_USERS	PASSWORD_DIGEST	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_USERS	USER_NAME	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	BUFFER_LENGTH	6	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	COLUMN_NAME	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	COLUMN_SIZE	5	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	DATA_TYPE	3	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	DECIMAL_DIGITS	7	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	PSEUDO_COLUMN	8	SMALLINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	SCOPE	1	INTEGER
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	TABLE_CAT	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	TABLE_NAME	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	TABLE_SCHEM	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	SYSTEM_VERSIONCOLUMNS	TYPE_NAME	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	INITIALLY_DEFERRED	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	IS_DEFERRABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_CATALOG	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_SCHEMA	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	IS_GRANTABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	PRIVILEGE_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLE_PRIVILEGES	WITH_HIERARCHY	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	COMMIT_ACTION	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	IS_INSERTABLE_INTO	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	IS_TYPED	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	REFERENCE_GENERATION	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	SELF_REFERENCING_COLUMN_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	TABLE_TYPE	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_CATALOG	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_NAME	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_SCHEMA	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_CATALOG	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_NAME	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_SCHEMA	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	COLUMN_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_COLUMN	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_TABLE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	PERIOD_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_PERIOD_USAGE	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_CONDITION	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_ORDER	8	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_ORIENTATION	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_ROW	16	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_TABLE	14	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_ROW	15	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_TABLE	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_STATEMENT	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	ACTION_TIMING	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	CREATED	17	TIMESTAMP
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	EVENT_MANIPULATION	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_CATALOG	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_SCHEMA	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_TABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	IS_GRANTABLE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	PRIVILEGE_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	GRANTEE	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	GRANTOR	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	IS_GRANTABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_CATALOG	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_NAME	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_SCHEMA	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_TYPE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USAGE_PRIVILEGES	PRIVILEGE_TYPE	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_MAXIMUM_LENGTH	14	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_OCTET_LENGTH	15	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_CATALOG	16	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_NAME	18	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_SCHEMA	17	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_CATALOG	19	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_NAME	21	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_SCHEMA	20	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DATA_TYPE	13	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DATETIME_PRECISION	25	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DECLARED_DATA_TYPE	30	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DECLARED_NUMERIC_PRECISION	31	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DECLARED_NUMERIC_SCALE	32	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	EXTERNAL_LANGUAGE	35	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	EXTERNAL_NAME	34	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	INTERVAL_PRECISION	27	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	INTERVAL_TYPE	26	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	IS_FINAL	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	IS_INSTANTIABLE	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	JAVA_INTERFACE	36	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	MAXIMUM_CARDINALITY	33	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_PRECISION	22	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_PRECISION_RADIX	23	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_SCALE	24	BIGINT
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_CATEGORY	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_FORM	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_CATALOG	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_NAME	11	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_SCHEMA	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	REF_DTD_IDENTIFIER	29	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	REFERENCE_TYPE	12	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	SOURCE_DTD_IDENTIFIER	28	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATEGORY	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	COLUMN_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	PERIOD_NAME	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	VIEW_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	VIEW_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_PERIOD_USAGE	VIEW_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	VIEW_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	VIEW_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	VIEW_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	CHECK_OPTION	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	INSERTABLE_INTO	7	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	IS_TRIGGER_DELETABLE	9	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	IS_TRIGGER_INSERTABLE_INTO	10	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	IS_TRIGGER_UPDATABLE	8	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	IS_UPDATABLE	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	TABLE_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	TABLE_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	TABLE_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEWS	VIEW_DEFINITION	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_CATALOG	4	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_NAME	6	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_SCHEMA	5	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_CATALOG	1	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_NAME	3	CHARACTER VARYING
hsqldb	PUBLIC	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_SCHEMA	2	CHARACTER VARYING
hsqldb	PUBLIC	SYSTEM_LOBS	BLOCKS	BLOCK_ADDR	1	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	BLOCKS	BLOCK_COUNT	2	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	BLOCKS	TX_ID	3	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	LOB_IDS	LOB_ID	1	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	LOB_IDS	LOB_LENGTH	2	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	LOB_IDS	LOB_TYPE	4	SMALLINT
hsqldb	PUBLIC	SYSTEM_LOBS	LOB_IDS	LOB_USAGE_COUNT	3	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	LOBS	BLOCK_ADDR	1	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	LOBS	BLOCK_COUNT	2	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	LOBS	BLOCK_OFFSET	3	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	LOBS	LOB_ID	4	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	BLOCK_COUNT	1	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	BLOCK_OFFSET	2	INTEGER
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	LOB_ID	6	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	PART_BYTES	5	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	PART_LENGTH	4	BIGINT
hsqldb	PUBLIC	SYSTEM_LOBS	PARTS	PART_OFFSET	3	BIGINT
mariadb	def	information_schema	ALL_PLUGINS	LOAD_OPTION	11	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_AUTHOR	8	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_AUTH_VERSION	13	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_DESCRIPTION	9	longtext
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_LIBRARY	6	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_LIBRARY_VERSION	7	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_LICENSE	10	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_MATURITY	12	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_NAME	1	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_STATUS	3	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_TYPE	4	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_TYPE_VERSION	5	varchar
mariadb	def	information_schema	ALL_PLUGINS	PLUGIN_VERSION	2	varchar
mariadb	def	information_schema	APPLICABLE_ROLES	GRANTEE	1	varchar
mariadb	def	information_schema	APPLICABLE_ROLES	IS_DEFAULT	4	varchar
mariadb	def	information_schema	APPLICABLE_ROLES	IS_GRANTABLE	3	varchar
mariadb	def	information_schema	APPLICABLE_ROLES	ROLE_NAME	2	varchar
mariadb	def	information_schema	CHARACTER_SETS	CHARACTER_SET_NAME	1	varchar
mariadb	def	information_schema	CHARACTER_SETS	DEFAULT_COLLATE_NAME	2	varchar
mariadb	def	information_schema	CHARACTER_SETS	DESCRIPTION	3	varchar
mariadb	def	information_schema	CHARACTER_SETS	MAXLEN	4	bigint
mariadb	def	information_schema	CHECK_CONSTRAINTS	CHECK_CLAUSE	5	varchar
mariadb	def	information_schema	CHECK_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
mariadb	def	information_schema	CHECK_CONSTRAINTS	CONSTRAINT_NAME	4	varchar
mariadb	def	information_schema	CHECK_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
mariadb	def	information_schema	CHECK_CONSTRAINTS	TABLE_NAME	3	varchar
mariadb	def	information_schema	CLIENT_STATISTICS	ACCESS_DENIED	22	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	BINLOG_BYTES_WRITTEN	9	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	BUSY_TIME	5	double
mariadb	def	information_schema	CLIENT_STATISTICS	BYTES_RECEIVED	7	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	BYTES_SENT	8	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	CLIENT	1	varchar
mariadb	def	information_schema	CLIENT_STATISTICS	COMMIT_TRANSACTIONS	18	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	CONCURRENT_CONNECTIONS	3	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	CONNECTED_TIME	4	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	CPU_TIME	6	double
mariadb	def	information_schema	CLIENT_STATISTICS	DENIED_CONNECTIONS	20	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	EMPTY_QUERIES	23	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	LOST_CONNECTIONS	21	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	MAX_STATEMENT_TIME_EXCEEDED	25	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	OTHER_COMMANDS	17	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROLLBACK_TRANSACTIONS	19	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROWS_DELETED	12	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROWS_INSERTED	13	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROWS_READ	10	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROWS_SENT	11	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	ROWS_UPDATED	14	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	SELECT_COMMANDS	15	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	TOTAL_CONNECTIONS	2	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	TOTAL_SSL_CONNECTIONS	24	bigint
mariadb	def	information_schema	CLIENT_STATISTICS	UPDATE_COMMANDS	16	bigint
mariadb	def	information_schema	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_NAME	2	varchar
mariadb	def	information_schema	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_NAME	1	varchar
mariadb	def	information_schema	COLLATIONS	CHARACTER_SET_NAME	2	varchar
mariadb	def	information_schema	COLLATIONS	COLLATION_NAME	1	varchar
mariadb	def	information_schema	COLLATIONS	ID	3	bigint
mariadb	def	information_schema	COLLATIONS	IS_COMPILED	5	varchar
mariadb	def	information_schema	COLLATIONS	IS_DEFAULT	4	varchar
mariadb	def	information_schema	COLLATIONS	SORTLEN	6	bigint
mariadb	def	information_schema	COLUMN_PRIVILEGES	COLUMN_NAME	5	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	GRANTEE	1	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	IS_GRANTABLE	7	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	TABLE_CATALOG	2	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	TABLE_NAME	4	varchar
mariadb	def	information_schema	COLUMN_PRIVILEGES	TABLE_SCHEMA	3	varchar
mariadb	def	information_schema	COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	bigint
mariadb	def	information_schema	COLUMNS	CHARACTER_OCTET_LENGTH	10	bigint
mariadb	def	information_schema	COLUMNS	CHARACTER_SET_NAME	14	varchar
mariadb	def	information_schema	COLUMNS	COLLATION_NAME	15	varchar
mariadb	def	information_schema	COLUMNS	COLUMN_COMMENT	20	varchar
mariadb	def	information_schema	COLUMNS	COLUMN_DEFAULT	6	longtext
mariadb	def	information_schema	COLUMNS	COLUMN_KEY	17	varchar
mariadb	def	information_schema	COLUMNS	COLUMN_NAME	4	varchar
mariadb	def	information_schema	COLUMNS	COLUMN_TYPE	16	longtext
mariadb	def	information_schema	COLUMNS	DATA_TYPE	8	varchar
mariadb	def	information_schema	COLUMNS	DATETIME_PRECISION	13	bigint
mariadb	def	information_schema	COLUMNS	EXTRA	18	varchar
mariadb	def	information_schema	COLUMNS	GENERATION_EXPRESSION	22	longtext
mariadb	def	information_schema	COLUMNS	IS_GENERATED	21	varchar
mariadb	def	information_schema	COLUMNS	IS_NULLABLE	7	varchar
mariadb	def	information_schema	COLUMNS	NUMERIC_PRECISION	11	bigint
mariadb	def	information_schema	COLUMNS	NUMERIC_SCALE	12	bigint
mariadb	def	information_schema	COLUMNS	ORDINAL_POSITION	5	bigint
mariadb	def	information_schema	COLUMNS	PRIVILEGES	19	varchar
mariadb	def	information_schema	COLUMNS	TABLE_CATALOG	1	varchar
mariadb	def	information_schema	COLUMNS	TABLE_NAME	3	varchar
mariadb	def	information_schema	COLUMNS	TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	ENABLED_ROLES	ROLE_NAME	1	varchar
mariadb	def	information_schema	ENGINES	COMMENT	3	varchar
mariadb	def	information_schema	ENGINES	ENGINE	1	varchar
mariadb	def	information_schema	ENGINES	SAVEPOINTS	6	varchar
mariadb	def	information_schema	ENGINES	SUPPORT	2	varchar
mariadb	def	information_schema	ENGINES	TRANSACTIONS	4	varchar
mariadb	def	information_schema	ENGINES	XA	5	varchar
mariadb	def	information_schema	EVENTS	CHARACTER_SET_CLIENT	22	varchar
mariadb	def	information_schema	EVENTS	COLLATION_CONNECTION	23	varchar
mariadb	def	information_schema	EVENTS	CREATED	17	datetime
mariadb	def	information_schema	EVENTS	DATABASE_COLLATION	24	varchar
mariadb	def	information_schema	EVENTS	DEFINER	4	varchar
mariadb	def	information_schema	EVENTS	ENDS	14	datetime
mariadb	def	information_schema	EVENTS	EVENT_BODY	6	varchar
mariadb	def	information_schema	EVENTS	EVENT_CATALOG	1	varchar
mariadb	def	information_schema	EVENTS	EVENT_COMMENT	20	varchar
mariadb	def	information_schema	EVENTS	EVENT_DEFINITION	7	longtext
mariadb	def	information_schema	EVENTS	EVENT_NAME	3	varchar
mariadb	def	information_schema	EVENTS	EVENT_SCHEMA	2	varchar
mariadb	def	information_schema	EVENTS	EVENT_TYPE	8	varchar
mariadb	def	information_schema	EVENTS	EXECUTE_AT	9	datetime
mariadb	def	information_schema	EVENTS	INTERVAL_FIELD	11	varchar
mariadb	def	information_schema	EVENTS	INTERVAL_VALUE	10	varchar
mariadb	def	information_schema	EVENTS	LAST_ALTERED	18	datetime
mariadb	def	information_schema	EVENTS	LAST_EXECUTED	19	datetime
mariadb	def	information_schema	EVENTS	ON_COMPLETION	16	varchar
mariadb	def	information_schema	EVENTS	ORIGINATOR	21	bigint
mariadb	def	information_schema	EVENTS	SQL_MODE	12	varchar
mariadb	def	information_schema	EVENTS	STARTS	13	datetime
mariadb	def	information_schema	EVENTS	STATUS	15	varchar
mariadb	def	information_schema	EVENTS	TIME_ZONE	5	varchar
mariadb	def	information_schema	FILES	AUTOEXTEND_SIZE	19	bigint
mariadb	def	information_schema	FILES	AVG_ROW_LENGTH	28	bigint
mariadb	def	information_schema	FILES	CHECKSUM	36	bigint
mariadb	def	information_schema	FILES	CHECK_TIME	35	datetime
mariadb	def	information_schema	FILES	CREATE_TIME	33	datetime
mariadb	def	information_schema	FILES	CREATION_TIME	20	datetime
mariadb	def	information_schema	FILES	DATA_FREE	32	bigint
mariadb	def	information_schema	FILES	DATA_LENGTH	29	bigint
mariadb	def	information_schema	FILES	DELETED_ROWS	12	bigint
mariadb	def	information_schema	FILES	ENGINE	10	varchar
mariadb	def	information_schema	FILES	EXTENT_SIZE	16	bigint
mariadb	def	information_schema	FILES	EXTRA	38	varchar
mariadb	def	information_schema	FILES	FILE_ID	1	bigint
mariadb	def	information_schema	FILES	FILE_NAME	2	varchar
mariadb	def	information_schema	FILES	FILE_TYPE	3	varchar
mariadb	def	information_schema	FILES	FREE_EXTENTS	14	bigint
mariadb	def	information_schema	FILES	FULLTEXT_KEYS	11	varchar
mariadb	def	information_schema	FILES	INDEX_LENGTH	31	bigint
mariadb	def	information_schema	FILES	INITIAL_SIZE	17	bigint
mariadb	def	information_schema	FILES	LAST_ACCESS_TIME	22	datetime
mariadb	def	information_schema	FILES	LAST_UPDATE_TIME	21	datetime
mariadb	def	information_schema	FILES	LOGFILE_GROUP_NAME	8	varchar
mariadb	def	information_schema	FILES	LOGFILE_GROUP_NUMBER	9	bigint
mariadb	def	information_schema	FILES	MAX_DATA_LENGTH	30	bigint
mariadb	def	information_schema	FILES	MAXIMUM_SIZE	18	bigint
mariadb	def	information_schema	FILES	RECOVER_TIME	23	bigint
mariadb	def	information_schema	FILES	ROW_FORMAT	26	varchar
mariadb	def	information_schema	FILES	STATUS	37	varchar
mariadb	def	information_schema	FILES	TABLE_CATALOG	5	varchar
mariadb	def	information_schema	FILES	TABLE_NAME	7	varchar
mariadb	def	information_schema	FILES	TABLE_ROWS	27	bigint
mariadb	def	information_schema	FILES	TABLE_SCHEMA	6	varchar
mariadb	def	information_schema	FILES	TABLESPACE_NAME	4	varchar
mariadb	def	information_schema	FILES	TOTAL_EXTENTS	15	bigint
mariadb	def	information_schema	FILES	TRANSACTION_COUNTER	24	bigint
mariadb	def	information_schema	FILES	UPDATE_COUNT	13	bigint
mariadb	def	information_schema	FILES	UPDATE_TIME	34	datetime
mariadb	def	information_schema	FILES	VERSION	25	bigint
mariadb	def	information_schema	GEOMETRY_COLUMNS	COORD_DIMENSION	11	tinyint
mariadb	def	information_schema	GEOMETRY_COLUMNS	F_GEOMETRY_COLUMN	4	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	F_TABLE_CATALOG	1	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	F_TABLE_NAME	3	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	F_TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	GEOMETRY_TYPE	10	int
mariadb	def	information_schema	GEOMETRY_COLUMNS	G_GEOMETRY_COLUMN	8	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	G_TABLE_CATALOG	5	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	G_TABLE_NAME	7	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	G_TABLE_SCHEMA	6	varchar
mariadb	def	information_schema	GEOMETRY_COLUMNS	MAX_PPR	12	tinyint
mariadb	def	information_schema	GEOMETRY_COLUMNS	SRID	13	smallint
mariadb	def	information_schema	GEOMETRY_COLUMNS	STORAGE_TYPE	9	tinyint
mariadb	def	information_schema	GLOBAL_STATUS	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	GLOBAL_STATUS	VARIABLE_VALUE	2	varchar
mariadb	def	information_schema	GLOBAL_VARIABLES	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	GLOBAL_VARIABLES	VARIABLE_VALUE	2	varchar
mariadb	def	information_schema	INDEX_STATISTICS	INDEX_NAME	3	varchar
mariadb	def	information_schema	INDEX_STATISTICS	ROWS_READ	4	bigint
mariadb	def	information_schema	INDEX_STATISTICS	TABLE_NAME	2	varchar
mariadb	def	information_schema	INDEX_STATISTICS	TABLE_SCHEMA	1	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	ACCESS_TIME	11	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	BLOCK_ID	2	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	COMPRESSED_SIZE	16	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	DATA_SIZE	15	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	FIX_COUNT	7	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	FLUSH_TYPE	6	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	FREE_PAGE_CLOCK	20	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	INDEX_NAME	13	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	IO_FIX	18	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	IS_HASHED	8	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	IS_OLD	19	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	ACCESS_TIME	11	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	COMPRESSED	17	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	COMPRESSED_SIZE	16	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	DATA_SIZE	15	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	FIX_COUNT	7	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	FLUSH_TYPE	6	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	FREE_PAGE_CLOCK	20	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	INDEX_NAME	13	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	IO_FIX	18	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	IS_HASHED	8	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	IS_OLD	19	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	LRU_POSITION	2	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	NEWEST_MODIFICATION	9	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	NUMBER_RECORDS	14	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	OLDEST_MODIFICATION	10	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	PAGE_NUMBER	4	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	PAGE_TYPE	5	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	POOL_ID	1	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	SPACE	3	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE_LRU	TABLE_NAME	12	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	NEWEST_MODIFICATION	9	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	NUMBER_RECORDS	14	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	OLDEST_MODIFICATION	10	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	PAGE_NUMBER	4	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	PAGE_STATE	17	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	PAGE_TYPE	5	varchar
mariadb	def	information_schema	INNODB_BUFFER_PAGE	POOL_ID	1	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	SPACE	3	bigint
mariadb	def	information_schema	INNODB_BUFFER_PAGE	TABLE_NAME	12	varchar
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	DATABASE_PAGES	4	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	FREE_BUFFERS	3	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	HIT_RATE	22	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	LRU_IO_CURRENT	30	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	LRU_IO_TOTAL	29	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	MODIFIED_DATABASE_PAGES	6	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NOT_YOUNG_MAKE_PER_THOUSAND_GETS	24	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_PAGES_CREATED	16	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_PAGES_GET	21	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_PAGES_READ	15	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_PAGES_READ_AHEAD	25	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_PAGES_WRITTEN	17	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	NUMBER_READ_AHEAD_EVICTED	26	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	OLD_DATABASE_PAGES	5	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_CREATE_RATE	19	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_MADE_NOT_YOUNG_RATE	14	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_MADE_YOUNG	11	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_MADE_YOUNG_RATE	13	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_NOT_MADE_YOUNG	12	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_READ_RATE	18	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PAGES_WRITTEN_RATE	20	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PENDING_DECOMPRESS	7	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PENDING_FLUSH_LIST	10	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PENDING_FLUSH_LRU	9	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	PENDING_READS	8	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	POOL_ID	1	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	POOL_SIZE	2	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	READ_AHEAD_EVICTED_RATE	28	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	READ_AHEAD_RATE	27	double
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	UNCOMPRESS_CURRENT	32	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	UNCOMPRESS_TOTAL	31	bigint
mariadb	def	information_schema	INNODB_BUFFER_POOL_STATS	YOUNG_MAKE_PER_THOUSAND_GETS	23	bigint
mariadb	def	information_schema	INNODB_CMP	compress_ops	2	int
mariadb	def	information_schema	INNODB_CMP	compress_ops_ok	3	int
mariadb	def	information_schema	INNODB_CMP	compress_time	4	int
mariadb	def	information_schema	INNODB_CMPMEM	buffer_pool_instance	2	int
mariadb	def	information_schema	INNODB_CMPMEM	pages_free	4	int
mariadb	def	information_schema	INNODB_CMPMEM	page_size	1	int
mariadb	def	information_schema	INNODB_CMPMEM	pages_used	3	int
mariadb	def	information_schema	INNODB_CMPMEM	relocation_ops	5	bigint
mariadb	def	information_schema	INNODB_CMPMEM	relocation_time	6	int
mariadb	def	information_schema	INNODB_CMPMEM_RESET	buffer_pool_instance	2	int
mariadb	def	information_schema	INNODB_CMPMEM_RESET	pages_free	4	int
mariadb	def	information_schema	INNODB_CMPMEM_RESET	page_size	1	int
mariadb	def	information_schema	INNODB_CMPMEM_RESET	pages_used	3	int
mariadb	def	information_schema	INNODB_CMPMEM_RESET	relocation_ops	5	bigint
mariadb	def	information_schema	INNODB_CMPMEM_RESET	relocation_time	6	int
mariadb	def	information_schema	INNODB_CMP	page_size	1	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	compress_ops	4	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	compress_ops_ok	5	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	compress_time	6	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	database_name	1	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	index_name	3	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	compress_ops	4	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	compress_ops_ok	5	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	compress_time	6	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	database_name	1	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	index_name	3	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	table_name	2	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	uncompress_ops	7	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX_RESET	uncompress_time	8	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	table_name	2	varchar
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	uncompress_ops	7	int
mariadb	def	information_schema	INNODB_CMP_PER_INDEX	uncompress_time	8	int
mariadb	def	information_schema	INNODB_CMP_RESET	compress_ops	2	int
mariadb	def	information_schema	INNODB_CMP_RESET	compress_ops_ok	3	int
mariadb	def	information_schema	INNODB_CMP_RESET	compress_time	4	int
mariadb	def	information_schema	INNODB_CMP_RESET	page_size	1	int
mariadb	def	information_schema	INNODB_CMP_RESET	uncompress_ops	5	int
mariadb	def	information_schema	INNODB_CMP_RESET	uncompress_time	6	int
mariadb	def	information_schema	INNODB_CMP	uncompress_ops	5	int
mariadb	def	information_schema	INNODB_CMP	uncompress_time	6	int
mariadb	def	information_schema	INNODB_FT_BEING_DELETED	DOC_ID	1	bigint
mariadb	def	information_schema	INNODB_FT_CONFIG	KEY	1	varchar
mariadb	def	information_schema	INNODB_FT_CONFIG	VALUE	2	varchar
mariadb	def	information_schema	INNODB_FT_DEFAULT_STOPWORD	value	1	varchar
mariadb	def	information_schema	INNODB_FT_DELETED	DOC_ID	1	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	DOC_COUNT	4	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	DOC_ID	5	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	FIRST_DOC_ID	2	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	LAST_DOC_ID	3	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	POSITION	6	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_CACHE	WORD	1	varchar
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	DOC_COUNT	4	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	DOC_ID	5	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	FIRST_DOC_ID	2	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	LAST_DOC_ID	3	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	POSITION	6	bigint
mariadb	def	information_schema	INNODB_FT_INDEX_TABLE	WORD	1	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_data	10	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_id	1	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_index	6	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_mode	3	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_page	8	bigint
mariadb	def	information_schema	INNODB_LOCKS	lock_rec	9	bigint
mariadb	def	information_schema	INNODB_LOCKS	lock_space	7	bigint
mariadb	def	information_schema	INNODB_LOCKS	lock_table	5	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_trx_id	2	varchar
mariadb	def	information_schema	INNODB_LOCKS	lock_type	4	varchar
mariadb	def	information_schema	INNODB_LOCK_WAITS	blocking_lock_id	4	varchar
mariadb	def	information_schema	INNODB_LOCK_WAITS	blocking_trx_id	3	varchar
mariadb	def	information_schema	INNODB_LOCK_WAITS	requested_lock_id	2	varchar
mariadb	def	information_schema	INNODB_LOCK_WAITS	requesting_trx_id	1	varchar
mariadb	def	information_schema	INNODB_METRICS	AVG_COUNT	6	double
mariadb	def	information_schema	INNODB_METRICS	AVG_COUNT_RESET	10	double
mariadb	def	information_schema	INNODB_METRICS	COMMENT	17	varchar
mariadb	def	information_schema	INNODB_METRICS	COUNT	3	bigint
mariadb	def	information_schema	INNODB_METRICS	COUNT_RESET	7	bigint
mariadb	def	information_schema	INNODB_METRICS	MAX_COUNT	4	bigint
mariadb	def	information_schema	INNODB_METRICS	MAX_COUNT_RESET	8	bigint
mariadb	def	information_schema	INNODB_METRICS	MIN_COUNT	5	bigint
mariadb	def	information_schema	INNODB_METRICS	MIN_COUNT_RESET	9	bigint
mariadb	def	information_schema	INNODB_METRICS	NAME	1	varchar
mariadb	def	information_schema	INNODB_METRICS	STATUS	15	varchar
mariadb	def	information_schema	INNODB_METRICS	SUBSYSTEM	2	varchar
mariadb	def	information_schema	INNODB_METRICS	TIME_DISABLED	12	datetime
mariadb	def	information_schema	INNODB_METRICS	TIME_ELAPSED	13	bigint
mariadb	def	information_schema	INNODB_METRICS	TIME_ENABLED	11	datetime
mariadb	def	information_schema	INNODB_METRICS	TIME_RESET	14	datetime
mariadb	def	information_schema	INNODB_METRICS	TYPE	16	varchar
mariadb	def	information_schema	INNODB_MUTEXES	CREATE_FILE	2	varchar
mariadb	def	information_schema	INNODB_MUTEXES	CREATE_LINE	3	int
mariadb	def	information_schema	INNODB_MUTEXES	NAME	1	varchar
mariadb	def	information_schema	INNODB_MUTEXES	OS_WAITS	4	bigint
mariadb	def	information_schema	INNODB_SYS_COLUMNS	LEN	6	int
mariadb	def	information_schema	INNODB_SYS_COLUMNS	MTYPE	4	int
mariadb	def	information_schema	INNODB_SYS_COLUMNS	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_COLUMNS	POS	3	bigint
mariadb	def	information_schema	INNODB_SYS_COLUMNS	PRTYPE	5	int
mariadb	def	information_schema	INNODB_SYS_COLUMNS	TABLE_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_DATAFILES	PATH	2	varchar
mariadb	def	information_schema	INNODB_SYS_DATAFILES	SPACE	1	int
mariadb	def	information_schema	INNODB_SYS_FIELDS	INDEX_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_FIELDS	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_FIELDS	POS	3	int
mariadb	def	information_schema	INNODB_SYS_FOREIGN_COLS	FOR_COL_NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN_COLS	ID	1	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN_COLS	POS	4	int
mariadb	def	information_schema	INNODB_SYS_FOREIGN_COLS	REF_COL_NAME	3	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN	FOR_NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN	ID	1	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN	N_COLS	4	int
mariadb	def	information_schema	INNODB_SYS_FOREIGN	REF_NAME	3	varchar
mariadb	def	information_schema	INNODB_SYS_FOREIGN	TYPE	5	int
mariadb	def	information_schema	INNODB_SYS_INDEXES	INDEX_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_INDEXES	MERGE_THRESHOLD	8	int
mariadb	def	information_schema	INNODB_SYS_INDEXES	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_INDEXES	N_FIELDS	5	int
mariadb	def	information_schema	INNODB_SYS_INDEXES	PAGE_NO	6	int
mariadb	def	information_schema	INNODB_SYS_INDEXES	SPACE	7	int
mariadb	def	information_schema	INNODB_SYS_INDEXES	TABLE_ID	3	bigint
mariadb	def	information_schema	INNODB_SYS_INDEXES	TYPE	4	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	CREATED_FILE	11	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	CREATED_LINE	12	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	FILE	3	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	HOLDER_FILE	9	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	HOLDER_LINE	10	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	HOLDER_THREAD_ID	8	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	LAST_WRITER_FILE	18	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	LAST_WRITER_LINE	19	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	LINE	4	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	LOCK_WORD	17	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	OBJECT_NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	OS_WAIT_COUNT	20	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	READERS	15	int
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	RESERVATION_MODE	14	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	THREAD_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	WAITERS_FLAG	16	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	WAIT_OBJECT	6	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	WAIT_TIME	5	bigint
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	WAIT_TYPE	7	varchar
mariadb	def	information_schema	INNODB_SYS_SEMAPHORE_WAITS	WRITER_THREAD	13	bigint
mariadb	def	information_schema	INNODB_SYS_TABLES	FLAG	3	int
mariadb	def	information_schema	INNODB_SYS_TABLES	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_TABLES	N_COLS	4	int
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	ALLOCATED_SIZE	10	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	FILE_SIZE	9	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	FLAG	3	int
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	FS_BLOCK_SIZE	8	int
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	PAGE_SIZE	5	int
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	ROW_FORMAT	4	varchar
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	SPACE	1	int
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	SPACE_TYPE	7	varchar
mariadb	def	information_schema	INNODB_SYS_TABLESPACES	ZIP_PAGE_SIZE	6	int
mariadb	def	information_schema	INNODB_SYS_TABLES	ROW_FORMAT	6	varchar
mariadb	def	information_schema	INNODB_SYS_TABLES	SPACE	5	int
mariadb	def	information_schema	INNODB_SYS_TABLES	SPACE_TYPE	8	varchar
mariadb	def	information_schema	INNODB_SYS_TABLES	TABLE_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	AUTOINC	8	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	CLUST_INDEX_SIZE	5	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	MODIFIED_COUNTER	7	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	NAME	2	varchar
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	NUM_ROWS	4	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	OTHER_INDEX_SIZE	6	bigint
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	REF_COUNT	9	int
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	STATS_INITIALIZED	3	varchar
mariadb	def	information_schema	INNODB_SYS_TABLESTATS	TABLE_ID	1	bigint
mariadb	def	information_schema	INNODB_SYS_TABLES	ZIP_PAGE_SIZE	7	int
mariadb	def	information_schema	INNODB_SYS_VIRTUAL	BASE_POS	3	int
mariadb	def	information_schema	INNODB_SYS_VIRTUAL	POS	2	int
mariadb	def	information_schema	INNODB_SYS_VIRTUAL	TABLE_ID	1	bigint
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	CURRENT_KEY_ID	9	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	CURRENT_KEY_VERSION	6	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	ENCRYPTION_SCHEME	3	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	KEY_ROTATION_MAX_PAGE_NUMBER	8	bigint
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	KEY_ROTATION_PAGE_NUMBER	7	bigint
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	KEYSERVER_REQUESTS	4	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	MIN_KEY_VERSION	5	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	NAME	2	varchar
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	ROTATING_OR_FLUSHING	10	int
mariadb	def	information_schema	INNODB_TABLESPACES_ENCRYPTION	SPACE	1	int
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	COMPRESSED	3	int
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	CURRENT_SCRUB_ACTIVE_THREADS	6	int
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	CURRENT_SCRUB_MAX_PAGE_NUMBER	8	bigint
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	CURRENT_SCRUB_PAGE_NUMBER	7	bigint
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	CURRENT_SCRUB_STARTED	5	datetime
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	LAST_SCRUB_COMPLETED	4	datetime
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	NAME	2	varchar
mariadb	def	information_schema	INNODB_TABLESPACES_SCRUBBING	SPACE	1	bigint
mariadb	def	information_schema	INNODB_TRX	trx_autocommit_non_locking	22	int
mariadb	def	information_schema	INNODB_TRX	trx_concurrency_tickets	16	bigint
mariadb	def	information_schema	INNODB_TRX	trx_foreign_key_checks	19	int
mariadb	def	information_schema	INNODB_TRX	trx_id	1	varchar
mariadb	def	information_schema	INNODB_TRX	trx_isolation_level	17	varchar
mariadb	def	information_schema	INNODB_TRX	trx_is_read_only	21	int
mariadb	def	information_schema	INNODB_TRX	trx_last_foreign_key_error	20	varchar
mariadb	def	information_schema	INNODB_TRX	trx_lock_memory_bytes	13	bigint
mariadb	def	information_schema	INNODB_TRX	trx_lock_structs	12	bigint
mariadb	def	information_schema	INNODB_TRX	trx_mysql_thread_id	7	bigint
mariadb	def	information_schema	INNODB_TRX	trx_operation_state	9	varchar
mariadb	def	information_schema	INNODB_TRX	trx_query	8	varchar
mariadb	def	information_schema	INNODB_TRX	trx_requested_lock_id	4	varchar
mariadb	def	information_schema	INNODB_TRX	trx_rows_locked	14	bigint
mariadb	def	information_schema	INNODB_TRX	trx_rows_modified	15	bigint
mariadb	def	information_schema	INNODB_TRX	trx_started	3	datetime
mariadb	def	information_schema	INNODB_TRX	trx_state	2	varchar
mariadb	def	information_schema	INNODB_TRX	trx_tables_in_use	10	bigint
mariadb	def	information_schema	INNODB_TRX	trx_tables_locked	11	bigint
mariadb	def	information_schema	INNODB_TRX	trx_unique_checks	18	int
mariadb	def	information_schema	INNODB_TRX	trx_wait_started	5	datetime
mariadb	def	information_schema	INNODB_TRX	trx_weight	6	bigint
mariadb	def	information_schema	KEY_CACHES	BLOCK_SIZE	5	bigint
mariadb	def	information_schema	KEY_CACHES	DIRTY_BLOCKS	8	bigint
mariadb	def	information_schema	KEY_CACHES	FULL_SIZE	4	bigint
mariadb	def	information_schema	KEY_CACHES	KEY_CACHE_NAME	1	varchar
mariadb	def	information_schema	KEY_CACHES	READ_REQUESTS	9	bigint
mariadb	def	information_schema	KEY_CACHES	READS	10	bigint
mariadb	def	information_schema	KEY_CACHES	SEGMENT_NUMBER	3	int
mariadb	def	information_schema	KEY_CACHES	SEGMENTS	2	int
mariadb	def	information_schema	KEY_CACHES	UNUSED_BLOCKS	7	bigint
mariadb	def	information_schema	KEY_CACHES	USED_BLOCKS	6	bigint
mariadb	def	information_schema	KEY_CACHES	WRITE_REQUESTS	11	bigint
mariadb	def	information_schema	KEY_CACHES	WRITES	12	bigint
mariadb	def	information_schema	KEY_COLUMN_USAGE	COLUMN_NAME	7	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	bigint
mariadb	def	information_schema	KEY_COLUMN_USAGE	POSITION_IN_UNIQUE_CONSTRAINT	9	bigint
mariadb	def	information_schema	KEY_COLUMN_USAGE	REFERENCED_COLUMN_NAME	12	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	REFERENCED_TABLE_NAME	11	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	REFERENCED_TABLE_SCHEMA	10	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	TABLE_CATALOG	4	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	TABLE_NAME	6	varchar
mariadb	def	information_schema	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
mariadb	def	information_schema	PARAMETERS	CHARACTER_MAXIMUM_LENGTH	8	int
mariadb	def	information_schema	PARAMETERS	CHARACTER_OCTET_LENGTH	9	int
mariadb	def	information_schema	PARAMETERS	CHARACTER_SET_NAME	13	varchar
mariadb	def	information_schema	PARAMETERS	COLLATION_NAME	14	varchar
mariadb	def	information_schema	PARAMETERS	DATA_TYPE	7	varchar
mariadb	def	information_schema	PARAMETERS	DATETIME_PRECISION	12	bigint
mariadb	def	information_schema	PARAMETERS	DTD_IDENTIFIER	15	longtext
mariadb	def	information_schema	PARAMETERS	NUMERIC_PRECISION	10	int
mariadb	def	information_schema	PARAMETERS	NUMERIC_SCALE	11	int
mariadb	def	information_schema	PARAMETERS	ORDINAL_POSITION	4	int
mariadb	def	information_schema	PARAMETERS	PARAMETER_MODE	5	varchar
mariadb	def	information_schema	PARAMETERS	PARAMETER_NAME	6	varchar
mariadb	def	information_schema	PARAMETERS	ROUTINE_TYPE	16	varchar
mariadb	def	information_schema	PARAMETERS	SPECIFIC_CATALOG	1	varchar
mariadb	def	information_schema	PARAMETERS	SPECIFIC_NAME	3	varchar
mariadb	def	information_schema	PARAMETERS	SPECIFIC_SCHEMA	2	varchar
mariadb	def	information_schema	PARTITIONS	AVG_ROW_LENGTH	14	bigint
mariadb	def	information_schema	PARTITIONS	CHECKSUM	22	bigint
mariadb	def	information_schema	PARTITIONS	CHECK_TIME	21	datetime
mariadb	def	information_schema	PARTITIONS	CREATE_TIME	19	datetime
mariadb	def	information_schema	PARTITIONS	DATA_FREE	18	bigint
mariadb	def	information_schema	PARTITIONS	DATA_LENGTH	15	bigint
mariadb	def	information_schema	PARTITIONS	INDEX_LENGTH	17	bigint
mariadb	def	information_schema	PARTITIONS	MAX_DATA_LENGTH	16	bigint
mariadb	def	information_schema	PARTITIONS	NODEGROUP	24	varchar
mariadb	def	information_schema	PARTITIONS	PARTITION_COMMENT	23	varchar
mariadb	def	information_schema	PARTITIONS	PARTITION_DESCRIPTION	12	longtext
mariadb	def	information_schema	PARTITIONS	PARTITION_EXPRESSION	10	longtext
mariadb	def	information_schema	PARTITIONS	PARTITION_METHOD	8	varchar
mariadb	def	information_schema	PARTITIONS	PARTITION_NAME	4	varchar
mariadb	def	information_schema	PARTITIONS	PARTITION_ORDINAL_POSITION	6	bigint
mariadb	def	information_schema	PARTITIONS	SUBPARTITION_EXPRESSION	11	longtext
mariadb	def	information_schema	PARTITIONS	SUBPARTITION_METHOD	9	varchar
mariadb	def	information_schema	PARTITIONS	SUBPARTITION_NAME	5	varchar
mariadb	def	information_schema	PARTITIONS	SUBPARTITION_ORDINAL_POSITION	7	bigint
mariadb	def	information_schema	PARTITIONS	TABLE_CATALOG	1	varchar
mariadb	def	information_schema	PARTITIONS	TABLE_NAME	3	varchar
mariadb	def	information_schema	PARTITIONS	TABLE_ROWS	13	bigint
mariadb	def	information_schema	PARTITIONS	TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	PARTITIONS	TABLESPACE_NAME	25	varchar
mariadb	def	information_schema	PARTITIONS	UPDATE_TIME	20	datetime
mariadb	def	information_schema	PLUGINS	LOAD_OPTION	11	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_AUTHOR	8	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_AUTH_VERSION	13	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_DESCRIPTION	9	longtext
mariadb	def	information_schema	PLUGINS	PLUGIN_LIBRARY	6	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_LIBRARY_VERSION	7	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_LICENSE	10	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_MATURITY	12	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_NAME	1	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_STATUS	3	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_TYPE	4	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_TYPE_VERSION	5	varchar
mariadb	def	information_schema	PLUGINS	PLUGIN_VERSION	2	varchar
mariadb	def	information_schema	PROCESSLIST	COMMAND	5	varchar
mariadb	def	information_schema	PROCESSLIST	DB	4	varchar
mariadb	def	information_schema	PROCESSLIST	EXAMINED_ROWS	15	int
mariadb	def	information_schema	PROCESSLIST	HOST	3	varchar
mariadb	def	information_schema	PROCESSLIST	ID	1	bigint
mariadb	def	information_schema	PROCESSLIST	INFO	8	longtext
mariadb	def	information_schema	PROCESSLIST	INFO_BINARY	17	blob
mariadb	def	information_schema	PROCESSLIST	MAX_MEMORY_USED	14	bigint
mariadb	def	information_schema	PROCESSLIST	MAX_STAGE	11	tinyint
mariadb	def	information_schema	PROCESSLIST	MEMORY_USED	13	bigint
mariadb	def	information_schema	PROCESSLIST	PROGRESS	12	decimal
mariadb	def	information_schema	PROCESSLIST	QUERY_ID	16	bigint
mariadb	def	information_schema	PROCESSLIST	STAGE	10	tinyint
mariadb	def	information_schema	PROCESSLIST	STATE	7	varchar
mariadb	def	information_schema	PROCESSLIST	TID	18	bigint
mariadb	def	information_schema	PROCESSLIST	TIME	6	int
mariadb	def	information_schema	PROCESSLIST	TIME_MS	9	decimal
mariadb	def	information_schema	PROCESSLIST	USER	2	varchar
mariadb	def	information_schema	PROFILING	BLOCK_OPS_IN	9	int
mariadb	def	information_schema	PROFILING	BLOCK_OPS_OUT	10	int
mariadb	def	information_schema	PROFILING	CONTEXT_INVOLUNTARY	8	int
mariadb	def	information_schema	PROFILING	CONTEXT_VOLUNTARY	7	int
mariadb	def	information_schema	PROFILING	CPU_SYSTEM	6	decimal
mariadb	def	information_schema	PROFILING	CPU_USER	5	decimal
mariadb	def	information_schema	PROFILING	DURATION	4	decimal
mariadb	def	information_schema	PROFILING	MESSAGES_RECEIVED	12	int
mariadb	def	information_schema	PROFILING	MESSAGES_SENT	11	int
mariadb	def	information_schema	PROFILING	PAGE_FAULTS_MAJOR	13	int
mariadb	def	information_schema	PROFILING	PAGE_FAULTS_MINOR	14	int
mariadb	def	information_schema	PROFILING	QUERY_ID	1	int
mariadb	def	information_schema	PROFILING	SEQ	2	int
mariadb	def	information_schema	PROFILING	SOURCE_FILE	17	varchar
mariadb	def	information_schema	PROFILING	SOURCE_FUNCTION	16	varchar
mariadb	def	information_schema	PROFILING	SOURCE_LINE	18	int
mariadb	def	information_schema	PROFILING	STATE	3	varchar
mariadb	def	information_schema	PROFILING	SWAPS	15	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	REFERENCED_TABLE_NAME	11	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	TABLE_NAME	10	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	varchar
mariadb	def	information_schema	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	varchar
mariadb	def	information_schema	ROUTINES	CHARACTER_MAXIMUM_LENGTH	7	int
mariadb	def	information_schema	ROUTINES	CHARACTER_OCTET_LENGTH	8	int
mariadb	def	information_schema	ROUTINES	CHARACTER_SET_CLIENT	29	varchar
mariadb	def	information_schema	ROUTINES	CHARACTER_SET_NAME	12	varchar
mariadb	def	information_schema	ROUTINES	COLLATION_CONNECTION	30	varchar
mariadb	def	information_schema	ROUTINES	COLLATION_NAME	13	varchar
mariadb	def	information_schema	ROUTINES	CREATED	24	datetime
mariadb	def	information_schema	ROUTINES	DATABASE_COLLATION	31	varchar
mariadb	def	information_schema	ROUTINES	DATA_TYPE	6	varchar
mariadb	def	information_schema	ROUTINES	DATETIME_PRECISION	11	bigint
mariadb	def	information_schema	ROUTINES	DEFINER	28	varchar
mariadb	def	information_schema	ROUTINES	DTD_IDENTIFIER	14	longtext
mariadb	def	information_schema	ROUTINES	EXTERNAL_LANGUAGE	18	varchar
mariadb	def	information_schema	ROUTINES	EXTERNAL_NAME	17	varchar
mariadb	def	information_schema	ROUTINES	IS_DETERMINISTIC	20	varchar
mariadb	def	information_schema	ROUTINES	LAST_ALTERED	25	datetime
mariadb	def	information_schema	ROUTINES	NUMERIC_PRECISION	9	int
mariadb	def	information_schema	ROUTINES	NUMERIC_SCALE	10	int
mariadb	def	information_schema	ROUTINES	PARAMETER_STYLE	19	varchar
mariadb	def	information_schema	ROUTINES	ROUTINE_BODY	15	varchar
mariadb	def	information_schema	ROUTINES	ROUTINE_CATALOG	2	varchar
mariadb	def	information_schema	ROUTINES	ROUTINE_COMMENT	27	longtext
mariadb	def	information_schema	ROUTINES	ROUTINE_DEFINITION	16	longtext
mariadb	def	information_schema	ROUTINES	ROUTINE_NAME	4	varchar
mariadb	def	information_schema	ROUTINES	ROUTINE_SCHEMA	3	varchar
mariadb	def	information_schema	ROUTINES	ROUTINE_TYPE	5	varchar
mariadb	def	information_schema	ROUTINES	SECURITY_TYPE	23	varchar
mariadb	def	information_schema	ROUTINES	SPECIFIC_NAME	1	varchar
mariadb	def	information_schema	ROUTINES	SQL_DATA_ACCESS	21	varchar
mariadb	def	information_schema	ROUTINES	SQL_MODE	26	varchar
mariadb	def	information_schema	ROUTINES	SQL_PATH	22	varchar
mariadb	def	information_schema	SCHEMA_PRIVILEGES	GRANTEE	1	varchar
mariadb	def	information_schema	SCHEMA_PRIVILEGES	IS_GRANTABLE	5	varchar
mariadb	def	information_schema	SCHEMA_PRIVILEGES	PRIVILEGE_TYPE	4	varchar
mariadb	def	information_schema	SCHEMA_PRIVILEGES	TABLE_CATALOG	2	varchar
mariadb	def	information_schema	SCHEMA_PRIVILEGES	TABLE_SCHEMA	3	varchar
mariadb	def	information_schema	SCHEMATA	CATALOG_NAME	1	varchar
mariadb	def	information_schema	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	3	varchar
mariadb	def	information_schema	SCHEMATA	DEFAULT_COLLATION_NAME	4	varchar
mariadb	def	information_schema	SCHEMATA	SCHEMA_NAME	2	varchar
mariadb	def	information_schema	SCHEMATA	SQL_PATH	5	varchar
mariadb	def	information_schema	SESSION_STATUS	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	SESSION_STATUS	VARIABLE_VALUE	2	varchar
mariadb	def	information_schema	SESSION_VARIABLES	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	SESSION_VARIABLES	VARIABLE_VALUE	2	varchar
mariadb	def	information_schema	SPATIAL_REF_SYS	AUTH_NAME	2	varchar
mariadb	def	information_schema	SPATIAL_REF_SYS	AUTH_SRID	3	int
mariadb	def	information_schema	SPATIAL_REF_SYS	SRID	1	smallint
mariadb	def	information_schema	SPATIAL_REF_SYS	SRTEXT	4	varchar
mariadb	def	information_schema	STATISTICS	CARDINALITY	10	bigint
mariadb	def	information_schema	STATISTICS	COLLATION	9	varchar
mariadb	def	information_schema	STATISTICS	COLUMN_NAME	8	varchar
mariadb	def	information_schema	STATISTICS	COMMENT	15	varchar
mariadb	def	information_schema	STATISTICS	INDEX_COMMENT	16	varchar
mariadb	def	information_schema	STATISTICS	INDEX_NAME	6	varchar
mariadb	def	information_schema	STATISTICS	INDEX_SCHEMA	5	varchar
mariadb	def	information_schema	STATISTICS	INDEX_TYPE	14	varchar
mariadb	def	information_schema	STATISTICS	NON_UNIQUE	4	bigint
mariadb	def	information_schema	STATISTICS	NULLABLE	13	varchar
mariadb	def	information_schema	STATISTICS	PACKED	12	varchar
mariadb	def	information_schema	STATISTICS	SEQ_IN_INDEX	7	bigint
mariadb	def	information_schema	STATISTICS	SUB_PART	11	bigint
mariadb	def	information_schema	STATISTICS	TABLE_CATALOG	1	varchar
mariadb	def	information_schema	STATISTICS	TABLE_NAME	3	varchar
mariadb	def	information_schema	STATISTICS	TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	COMMAND_LINE_ARGUMENT	14	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	DEFAULT_VALUE	5	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	ENUM_VALUE_LIST	12	longtext
mariadb	def	information_schema	SYSTEM_VARIABLES	GLOBAL_VALUE	3	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	GLOBAL_VALUE_ORIGIN	4	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	NUMERIC_BLOCK_SIZE	11	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	NUMERIC_MAX_VALUE	10	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	NUMERIC_MIN_VALUE	9	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	READ_ONLY	13	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	SESSION_VALUE	2	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	VARIABLE_COMMENT	8	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	VARIABLE_SCOPE	6	varchar
mariadb	def	information_schema	SYSTEM_VARIABLES	VARIABLE_TYPE	7	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	6	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	TABLE_NAME	5	varchar
mariadb	def	information_schema	TABLE_CONSTRAINTS	TABLE_SCHEMA	4	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	GRANTEE	1	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	IS_GRANTABLE	6	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	PRIVILEGE_TYPE	5	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	TABLE_CATALOG	2	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	TABLE_NAME	4	varchar
mariadb	def	information_schema	TABLE_PRIVILEGES	TABLE_SCHEMA	3	varchar
mariadb	def	information_schema	TABLES	AUTO_INCREMENT	14	bigint
mariadb	def	information_schema	TABLES	AVG_ROW_LENGTH	9	bigint
mariadb	def	information_schema	TABLES	CHECKSUM	19	bigint
mariadb	def	information_schema	TABLES	CHECK_TIME	17	datetime
mariadb	def	information_schema	TABLES	CREATE_OPTIONS	20	varchar
mariadb	def	information_schema	TABLES	CREATE_TIME	15	datetime
mariadb	def	information_schema	TABLES	DATA_FREE	13	bigint
mariadb	def	information_schema	TABLES	DATA_LENGTH	10	bigint
mariadb	def	information_schema	TABLES	ENGINE	5	varchar
mariadb	def	information_schema	TABLES	INDEX_LENGTH	12	bigint
mariadb	def	information_schema	TABLES	MAX_DATA_LENGTH	11	bigint
mariadb	def	information_schema	TABLES	MAX_INDEX_LENGTH	22	bigint
mariadb	def	information_schema	TABLESPACES	AUTOEXTEND_SIZE	6	bigint
mariadb	def	information_schema	TABLESPACES	ENGINE	2	varchar
mariadb	def	information_schema	TABLESPACES	EXTENT_SIZE	5	bigint
mariadb	def	information_schema	TABLESPACES	LOGFILE_GROUP_NAME	4	varchar
mariadb	def	information_schema	TABLESPACES	MAXIMUM_SIZE	7	bigint
mariadb	def	information_schema	TABLESPACES	NODEGROUP_ID	8	bigint
mariadb	def	information_schema	TABLESPACES	TABLESPACE_COMMENT	9	varchar
mariadb	def	information_schema	TABLESPACES	TABLESPACE_NAME	1	varchar
mariadb	def	information_schema	TABLESPACES	TABLESPACE_TYPE	3	varchar
mariadb	def	information_schema	TABLES	ROW_FORMAT	7	varchar
mariadb	def	information_schema	TABLES	TABLE_CATALOG	1	varchar
mariadb	def	information_schema	TABLES	TABLE_COLLATION	18	varchar
mariadb	def	information_schema	TABLES	TABLE_COMMENT	21	varchar
mariadb	def	information_schema	TABLES	TABLE_NAME	3	varchar
mariadb	def	information_schema	TABLES	TABLE_ROWS	8	bigint
mariadb	def	information_schema	TABLES	TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	TABLES	TABLE_TYPE	4	varchar
mariadb	def	information_schema	TABLE_STATISTICS	ROWS_CHANGED	4	bigint
mariadb	def	information_schema	TABLE_STATISTICS	ROWS_CHANGED_X_INDEXES	5	bigint
mariadb	def	information_schema	TABLE_STATISTICS	ROWS_READ	3	bigint
mariadb	def	information_schema	TABLE_STATISTICS	TABLE_NAME	2	varchar
mariadb	def	information_schema	TABLE_STATISTICS	TABLE_SCHEMA	1	varchar
mariadb	def	information_schema	TABLES	TEMPORARY	23	varchar
mariadb	def	information_schema	TABLES	UPDATE_TIME	16	datetime
mariadb	def	information_schema	TABLES	VERSION	6	bigint
mariadb	def	information_schema	TRIGGERS	ACTION_CONDITION	9	longtext
mariadb	def	information_schema	TRIGGERS	ACTION_ORDER	8	bigint
mariadb	def	information_schema	TRIGGERS	ACTION_ORIENTATION	11	varchar
mariadb	def	information_schema	TRIGGERS	ACTION_REFERENCE_NEW_ROW	16	varchar
mariadb	def	information_schema	TRIGGERS	ACTION_REFERENCE_NEW_TABLE	14	varchar
mariadb	def	information_schema	TRIGGERS	ACTION_REFERENCE_OLD_ROW	15	varchar
mariadb	def	information_schema	TRIGGERS	ACTION_REFERENCE_OLD_TABLE	13	varchar
mariadb	def	information_schema	TRIGGERS	ACTION_STATEMENT	10	longtext
mariadb	def	information_schema	TRIGGERS	ACTION_TIMING	12	varchar
mariadb	def	information_schema	TRIGGERS	CHARACTER_SET_CLIENT	20	varchar
mariadb	def	information_schema	TRIGGERS	COLLATION_CONNECTION	21	varchar
mariadb	def	information_schema	TRIGGERS	CREATED	17	datetime
mariadb	def	information_schema	TRIGGERS	DATABASE_COLLATION	22	varchar
mariadb	def	information_schema	TRIGGERS	DEFINER	19	varchar
mariadb	def	information_schema	TRIGGERS	EVENT_MANIPULATION	4	varchar
mariadb	def	information_schema	TRIGGERS	EVENT_OBJECT_CATALOG	5	varchar
mariadb	def	information_schema	TRIGGERS	EVENT_OBJECT_SCHEMA	6	varchar
mariadb	def	information_schema	TRIGGERS	EVENT_OBJECT_TABLE	7	varchar
mariadb	def	information_schema	TRIGGERS	SQL_MODE	18	varchar
mariadb	def	information_schema	TRIGGERS	TRIGGER_CATALOG	1	varchar
mariadb	def	information_schema	TRIGGERS	TRIGGER_NAME	3	varchar
mariadb	def	information_schema	TRIGGERS	TRIGGER_SCHEMA	2	varchar
mariadb	def	information_schema	USER_PRIVILEGES	GRANTEE	1	varchar
mariadb	def	information_schema	USER_PRIVILEGES	IS_GRANTABLE	4	varchar
mariadb	def	information_schema	USER_PRIVILEGES	PRIVILEGE_TYPE	3	varchar
mariadb	def	information_schema	USER_PRIVILEGES	TABLE_CATALOG	2	varchar
mariadb	def	information_schema	USER_STATISTICS	ACCESS_DENIED	22	bigint
mariadb	def	information_schema	USER_STATISTICS	BINLOG_BYTES_WRITTEN	9	bigint
mariadb	def	information_schema	USER_STATISTICS	BUSY_TIME	5	double
mariadb	def	information_schema	USER_STATISTICS	BYTES_RECEIVED	7	bigint
mariadb	def	information_schema	USER_STATISTICS	BYTES_SENT	8	bigint
mariadb	def	information_schema	USER_STATISTICS	COMMIT_TRANSACTIONS	18	bigint
mariadb	def	information_schema	USER_STATISTICS	CONCURRENT_CONNECTIONS	3	int
mariadb	def	information_schema	USER_STATISTICS	CONNECTED_TIME	4	int
mariadb	def	information_schema	USER_STATISTICS	CPU_TIME	6	double
mariadb	def	information_schema	USER_STATISTICS	DENIED_CONNECTIONS	20	bigint
mariadb	def	information_schema	USER_STATISTICS	EMPTY_QUERIES	23	bigint
mariadb	def	information_schema	USER_STATISTICS	LOST_CONNECTIONS	21	bigint
mariadb	def	information_schema	USER_STATISTICS	MAX_STATEMENT_TIME_EXCEEDED	25	bigint
mariadb	def	information_schema	USER_STATISTICS	OTHER_COMMANDS	17	bigint
mariadb	def	information_schema	USER_STATISTICS	ROLLBACK_TRANSACTIONS	19	bigint
mariadb	def	information_schema	USER_STATISTICS	ROWS_DELETED	12	bigint
mariadb	def	information_schema	USER_STATISTICS	ROWS_INSERTED	13	bigint
mariadb	def	information_schema	USER_STATISTICS	ROWS_READ	10	bigint
mariadb	def	information_schema	USER_STATISTICS	ROWS_SENT	11	bigint
mariadb	def	information_schema	USER_STATISTICS	ROWS_UPDATED	14	bigint
mariadb	def	information_schema	USER_STATISTICS	SELECT_COMMANDS	15	bigint
mariadb	def	information_schema	USER_STATISTICS	TOTAL_CONNECTIONS	2	int
mariadb	def	information_schema	USER_STATISTICS	TOTAL_SSL_CONNECTIONS	24	bigint
mariadb	def	information_schema	USER_STATISTICS	UPDATE_COMMANDS	16	bigint
mariadb	def	information_schema	USER_STATISTICS	USER	1	varchar
mariadb	def	information_schema	user_variables	CHARACTER_SET_NAME	4	varchar
mariadb	def	information_schema	user_variables	VARIABLE_NAME	1	varchar
mariadb	def	information_schema	user_variables	VARIABLE_TYPE	3	varchar
mariadb	def	information_schema	user_variables	VARIABLE_VALUE	2	varchar
mariadb	def	information_schema	VIEWS	ALGORITHM	11	varchar
mariadb	def	information_schema	VIEWS	CHARACTER_SET_CLIENT	9	varchar
mariadb	def	information_schema	VIEWS	CHECK_OPTION	5	varchar
mariadb	def	information_schema	VIEWS	COLLATION_CONNECTION	10	varchar
mariadb	def	information_schema	VIEWS	DEFINER	7	varchar
mariadb	def	information_schema	VIEWS	IS_UPDATABLE	6	varchar
mariadb	def	information_schema	VIEWS	SECURITY_TYPE	8	varchar
mariadb	def	information_schema	VIEWS	TABLE_CATALOG	1	varchar
mariadb	def	information_schema	VIEWS	TABLE_NAME	3	varchar
mariadb	def	information_schema	VIEWS	TABLE_SCHEMA	2	varchar
mariadb	def	information_schema	VIEWS	VIEW_DEFINITION	4	longtext
mssql	master	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CHECK_CLAUSE	4	nvarchar
mssql	master	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	COLUMN_NAME	7	sysname
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	COLUMN_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTEE	2	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTOR	1	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	IS_GRANTABLE	8	varchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	7	varchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_CATALOG	3	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_NAME	5	sysname
mssql	master	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_SCHEMA	4	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	int
mssql	master	INFORMATION_SCHEMA	COLUMNS	CHARACTER_OCTET_LENGTH	10	int
mssql	master	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_CATALOG	15	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_NAME	17	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_SCHEMA	16	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	COLLATION_CATALOG	18	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	COLLATION_NAME	20	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	COLLATION_SCHEMA	19	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	COLUMN_DEFAULT	6	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMNS	COLUMN_NAME	4	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	DATA_TYPE	8	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMNS	DATETIME_PRECISION	14	smallint
mssql	master	INFORMATION_SCHEMA	COLUMNS	DOMAIN_CATALOG	21	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	DOMAIN_NAME	23	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	DOMAIN_SCHEMA	22	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	IS_NULLABLE	7	varchar
mssql	master	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION	11	tinyint
mssql	master	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION_RADIX	12	smallint
mssql	master	INFORMATION_SCHEMA	COLUMNS	NUMERIC_SCALE	13	int
mssql	master	INFORMATION_SCHEMA	COLUMNS	ORDINAL_POSITION	5	int
mssql	master	INFORMATION_SCHEMA	COLUMNS	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	COLUMNS	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	COLUMNS	TABLE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	COLUMN_NAME	4	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_CATALOG	5	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_NAME	7	sysname
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_SCHEMA	6	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	INITIALLY_DEFERRED	8	varchar
mssql	master	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	IS_DEFERRABLE	7	varchar
mssql	master	INFORMATION_SCHEMA	DOMAINS	CHARACTER_MAXIMUM_LENGTH	5	int
mssql	master	INFORMATION_SCHEMA	DOMAINS	CHARACTER_OCTET_LENGTH	6	int
mssql	master	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_CATALOG	10	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_NAME	12	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_SCHEMA	11	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	COLLATION_CATALOG	7	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	COLLATION_NAME	9	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	COLLATION_SCHEMA	8	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	DATA_TYPE	4	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAINS	DATETIME_PRECISION	16	smallint
mssql	master	INFORMATION_SCHEMA	DOMAINS	DOMAIN_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAINS	DOMAIN_DEFAULT	17	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAINS	DOMAIN_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	DOMAINS	DOMAIN_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION	13	tinyint
mssql	master	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION_RADIX	14	smallint
mssql	master	INFORMATION_SCHEMA	DOMAINS	NUMERIC_SCALE	15	int
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	COLUMN_NAME	7	nvarchar
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	int
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	AS_LOCATOR	7	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_MAXIMUM_LENGTH	10	int
mssql	master	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_OCTET_LENGTH	11	int
mssql	master	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_CATALOG	15	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_NAME	17	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_SCHEMA	16	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	COLLATION_CATALOG	12	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	COLLATION_NAME	14	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	COLLATION_SCHEMA	13	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	DATA_TYPE	9	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	DATETIME_PRECISION	21	smallint
mssql	master	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_PRECISION	23	smallint
mssql	master	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_TYPE	22	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	IS_RESULT	6	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION	18	tinyint
mssql	master	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION_RADIX	19	smallint
mssql	master	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_SCALE	20	int
mssql	master	INFORMATION_SCHEMA	PARAMETERS	ORDINAL_POSITION	4	int
mssql	master	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_MODE	5	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_NAME	8	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SCOPE_CATALOG	27	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SCOPE_NAME	29	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SCOPE_SCHEMA	28	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	PARAMETERS	USER_DEFINED_TYPE_CATALOG	24	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	USER_DEFINED_TYPE_NAME	26	sysname
mssql	master	INFORMATION_SCHEMA	PARAMETERS	USER_DEFINED_TYPE_SCHEMA	25	sysname
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	varchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	varchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	varchar
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	int
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	CHARACTER_OCTET_LENGTH	10	int
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	CHARACTER_SET_CATALOG	15	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	CHARACTER_SET_NAME	17	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	CHARACTER_SET_SCHEMA	16	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	COLLATION_CATALOG	18	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	COLLATION_NAME	20	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	COLLATION_SCHEMA	19	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	COLUMN_DEFAULT	6	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	COLUMN_NAME	4	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	DATA_TYPE	8	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	DATETIME_PRECISION	14	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	DOMAIN_CATALOG	21	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	DOMAIN_NAME	23	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	DOMAIN_SCHEMA	22	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	IS_NULLABLE	7	varchar
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	NUMERIC_PRECISION	11	tinyint
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	NUMERIC_PRECISION_RADIX	12	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	NUMERIC_SCALE	13	int
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	ORDINAL_POSITION	5	int
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINE_COLUMNS	TABLE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	CHARACTER_MAXIMUM_LENGTH	15	int
mssql	master	INFORMATION_SCHEMA	ROUTINES	CHARACTER_OCTET_LENGTH	16	int
mssql	master	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_CATALOG	20	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_NAME	22	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_SCHEMA	21	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	COLLATION_CATALOG	17	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	COLLATION_NAME	19	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	COLLATION_SCHEMA	18	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	CREATED	50	datetime
mssql	master	INFORMATION_SCHEMA	ROUTINES	DATA_TYPE	14	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	DATETIME_PRECISION	26	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINES	DTD_IDENTIFIER	36	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_LANGUAGE	40	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_NAME	39	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	INTERVAL_PRECISION	28	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINES	INTERVAL_TYPE	27	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	IS_DETERMINISTIC	42	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	IS_IMPLICITLY_INVOCABLE	49	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	IS_NULL_CALL	44	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	IS_USER_DEFINED_CAST	48	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	LAST_ALTERED	51	datetime
mssql	master	INFORMATION_SCHEMA	ROUTINES	MAX_DYNAMIC_RESULT_SETS	47	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINES	MAXIMUM_CARDINALITY	35	bigint
mssql	master	INFORMATION_SCHEMA	ROUTINES	MODULE_CATALOG	8	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	MODULE_NAME	10	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	MODULE_SCHEMA	9	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION	23	tinyint
mssql	master	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION_RADIX	24	smallint
mssql	master	INFORMATION_SCHEMA	ROUTINES	NUMERIC_SCALE	25	int
mssql	master	INFORMATION_SCHEMA	ROUTINES	PARAMETER_STYLE	41	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_BODY	37	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_DEFINITION	38	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	ROUTINE_TYPE	7	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	SCHEMA_LEVEL_ROUTINE	46	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	SCOPE_CATALOG	32	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	SCOPE_NAME	34	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	SCOPE_SCHEMA	33	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	SQL_DATA_ACCESS	43	nvarchar
mssql	master	INFORMATION_SCHEMA	ROUTINES	SQL_PATH	45	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_CATALOG	29	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_NAME	31	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_SCHEMA	30	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	UDT_CATALOG	11	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	UDT_NAME	13	sysname
mssql	master	INFORMATION_SCHEMA	ROUTINES	UDT_SCHEMA	12	sysname
mssql	master	INFORMATION_SCHEMA	SCHEMATA	CATALOG_NAME	1	nvarchar
mssql	master	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_CATALOG	4	sysname
mssql	master	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_SCHEMA	5	sysname
mssql	master	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_NAME	2	sysname
mssql	master	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_OWNER	3	nvarchar
mssql	master	INFORMATION_SCHEMA	SEQUENCES	CYCLE_OPTION	12	bit
mssql	master	INFORMATION_SCHEMA	SEQUENCES	DATA_TYPE	4	nvarchar
mssql	master	INFORMATION_SCHEMA	SEQUENCES	DECLARED_DATA_TYPE	13	sysname
mssql	master	INFORMATION_SCHEMA	SEQUENCES	DECLARED_NUMERIC_PRECISION	14	tinyint
mssql	master	INFORMATION_SCHEMA	SEQUENCES	DECLARED_NUMERIC_SCALE	15	tinyint
mssql	master	INFORMATION_SCHEMA	SEQUENCES	INCREMENT	11	sql_variant
mssql	master	INFORMATION_SCHEMA	SEQUENCES	MAXIMUM_VALUE	10	sql_variant
mssql	master	INFORMATION_SCHEMA	SEQUENCES	MINIMUM_VALUE	9	sql_variant
mssql	master	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION	5	tinyint
mssql	master	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION_RADIX	6	smallint
mssql	master	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_SCALE	7	int
mssql	master	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	SEQUENCES	START_VALUE	8	sql_variant
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	7	varchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	INITIALLY_DEFERRED	9	varchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	IS_DEFERRABLE	8	varchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTEE	2	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTOR	1	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	IS_GRANTABLE	7	varchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_CATALOG	3	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_NAME	5	sysname
mssql	master	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_SCHEMA	4	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLES	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	TABLES	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	TABLES	TABLE_SCHEMA	2	sysname
mssql	master	INFORMATION_SCHEMA	TABLES	TABLE_TYPE	4	varchar
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	COLUMN_NAME	7	sysname
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEWS	CHECK_OPTION	5	varchar
mssql	master	INFORMATION_SCHEMA	VIEWS	IS_UPDATABLE	6	varchar
mssql	master	INFORMATION_SCHEMA	VIEWS	TABLE_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEWS	TABLE_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	VIEWS	TABLE_SCHEMA	2	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEWS	VIEW_DEFINITION	4	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_CATALOG	4	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_NAME	6	sysname
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_SCHEMA	5	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_CATALOG	1	nvarchar
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_NAME	3	sysname
mssql	master	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_SCHEMA	2	nvarchar
pg	db_name	information_schema	administrable_role_authorizations	grantee	1	name
pg	db_name	information_schema	administrable_role_authorizations	is_grantable	3	character varying
pg	db_name	information_schema	administrable_role_authorizations	role_name	2	name
pg	db_name	information_schema	applicable_roles	grantee	1	name
pg	db_name	information_schema	applicable_roles	is_grantable	3	character varying
pg	db_name	information_schema	applicable_roles	role_name	2	name
pg	db_name	information_schema	attributes	attribute_default	6	character varying
pg	db_name	information_schema	attributes	attribute_name	4	name
pg	db_name	information_schema	attributes	attribute_udt_catalog	23	name
pg	db_name	information_schema	attributes	attribute_udt_name	25	name
pg	db_name	information_schema	attributes	attribute_udt_schema	24	name
pg	db_name	information_schema	attributes	character_maximum_length	9	integer
pg	db_name	information_schema	attributes	character_octet_length	10	integer
pg	db_name	information_schema	attributes	character_set_catalog	11	name
pg	db_name	information_schema	attributes	character_set_name	13	name
pg	db_name	information_schema	attributes	character_set_schema	12	name
pg	db_name	information_schema	attributes	collation_catalog	14	name
pg	db_name	information_schema	attributes	collation_name	16	name
pg	db_name	information_schema	attributes	collation_schema	15	name
pg	db_name	information_schema	attributes	data_type	8	character varying
pg	db_name	information_schema	attributes	datetime_precision	20	integer
pg	db_name	information_schema	attributes	dtd_identifier	30	name
pg	db_name	information_schema	attributes	interval_precision	22	integer
pg	db_name	information_schema	attributes	interval_type	21	character varying
pg	db_name	information_schema	attributes	is_derived_reference_attribute	31	character varying
pg	db_name	information_schema	attributes	is_nullable	7	character varying
pg	db_name	information_schema	attributes	maximum_cardinality	29	integer
pg	db_name	information_schema	attributes	numeric_precision	17	integer
pg	db_name	information_schema	attributes	numeric_precision_radix	18	integer
pg	db_name	information_schema	attributes	numeric_scale	19	integer
pg	db_name	information_schema	attributes	ordinal_position	5	integer
pg	db_name	information_schema	attributes	scope_catalog	26	name
pg	db_name	information_schema	attributes	scope_name	28	name
pg	db_name	information_schema	attributes	scope_schema	27	name
pg	db_name	information_schema	attributes	udt_catalog	1	name
pg	db_name	information_schema	attributes	udt_name	3	name
pg	db_name	information_schema	attributes	udt_schema	2	name
pg	db_name	information_schema	character_sets	character_repertoire	4	name
pg	db_name	information_schema	character_sets	character_set_catalog	1	name
pg	db_name	information_schema	character_sets	character_set_name	3	name
pg	db_name	information_schema	character_sets	character_set_schema	2	name
pg	db_name	information_schema	character_sets	default_collate_catalog	6	name
pg	db_name	information_schema	character_sets	default_collate_name	8	name
pg	db_name	information_schema	character_sets	default_collate_schema	7	name
pg	db_name	information_schema	character_sets	form_of_use	5	name
pg	db_name	information_schema	check_constraint_routine_usage	constraint_catalog	1	name
pg	db_name	information_schema	check_constraint_routine_usage	constraint_name	3	name
pg	db_name	information_schema	check_constraint_routine_usage	constraint_schema	2	name
pg	db_name	information_schema	check_constraint_routine_usage	specific_catalog	4	name
pg	db_name	information_schema	check_constraint_routine_usage	specific_name	6	name
pg	db_name	information_schema	check_constraint_routine_usage	specific_schema	5	name
pg	db_name	information_schema	check_constraints	check_clause	4	character varying
pg	db_name	information_schema	check_constraints	constraint_catalog	1	name
pg	db_name	information_schema	check_constraints	constraint_name	3	name
pg	db_name	information_schema	check_constraints	constraint_schema	2	name
pg	db_name	information_schema	collation_character_set_applicability	character_set_catalog	4	name
pg	db_name	information_schema	collation_character_set_applicability	character_set_name	6	name
pg	db_name	information_schema	collation_character_set_applicability	character_set_schema	5	name
pg	db_name	information_schema	collation_character_set_applicability	collation_catalog	1	name
pg	db_name	information_schema	collation_character_set_applicability	collation_name	3	name
pg	db_name	information_schema	collation_character_set_applicability	collation_schema	2	name
pg	db_name	information_schema	collations	collation_catalog	1	name
pg	db_name	information_schema	collations	collation_name	3	name
pg	db_name	information_schema	collations	collation_schema	2	name
pg	db_name	information_schema	collations	pad_attribute	4	character varying
pg	db_name	information_schema	column_column_usage	column_name	4	name
pg	db_name	information_schema	column_column_usage	dependent_column	5	name
pg	db_name	information_schema	column_column_usage	table_catalog	1	name
pg	db_name	information_schema	column_column_usage	table_name	3	name
pg	db_name	information_schema	column_column_usage	table_schema	2	name
pg	db_name	information_schema	column_domain_usage	column_name	7	name
pg	db_name	information_schema	column_domain_usage	domain_catalog	1	name
pg	db_name	information_schema	column_domain_usage	domain_name	3	name
pg	db_name	information_schema	column_domain_usage	domain_schema	2	name
pg	db_name	information_schema	column_domain_usage	table_catalog	4	name
pg	db_name	information_schema	column_domain_usage	table_name	6	name
pg	db_name	information_schema	column_domain_usage	table_schema	5	name
pg	db_name	information_schema	column_options	column_name	4	name
pg	db_name	information_schema	column_options	option_name	5	name
pg	db_name	information_schema	column_options	option_value	6	character varying
pg	db_name	information_schema	column_options	table_catalog	1	name
pg	db_name	information_schema	column_options	table_name	3	name
pg	db_name	information_schema	column_options	table_schema	2	name
pg	db_name	information_schema	column_privileges	column_name	6	name
pg	db_name	information_schema	column_privileges	grantee	2	name
pg	db_name	information_schema	column_privileges	grantor	1	name
pg	db_name	information_schema	column_privileges	is_grantable	8	character varying
pg	db_name	information_schema	column_privileges	privilege_type	7	character varying
pg	db_name	information_schema	column_privileges	table_catalog	3	name
pg	db_name	information_schema	column_privileges	table_name	5	name
pg	db_name	information_schema	column_privileges	table_schema	4	name
pg	db_name	information_schema	columns	character_maximum_length	9	integer
pg	db_name	information_schema	columns	character_octet_length	10	integer
pg	db_name	information_schema	columns	character_set_catalog	17	name
pg	db_name	information_schema	columns	character_set_name	19	name
pg	db_name	information_schema	columns	character_set_schema	18	name
pg	db_name	information_schema	columns	collation_catalog	20	name
pg	db_name	information_schema	columns	collation_name	22	name
pg	db_name	information_schema	columns	collation_schema	21	name
pg	db_name	information_schema	columns	column_default	6	character varying
pg	db_name	information_schema	columns	column_name	4	name
pg	db_name	information_schema	columns	data_type	8	character varying
pg	db_name	information_schema	columns	datetime_precision	14	integer
pg	db_name	information_schema	columns	domain_catalog	23	name
pg	db_name	information_schema	columns	domain_name	25	name
pg	db_name	information_schema	columns	domain_schema	24	name
pg	db_name	information_schema	columns	dtd_identifier	33	name
pg	db_name	information_schema	columns	generation_expression	43	character varying
pg	db_name	information_schema	columns	identity_cycle	41	character varying
pg	db_name	information_schema	columns	identity_generation	36	character varying
pg	db_name	information_schema	columns	identity_increment	38	character varying
pg	db_name	information_schema	columns	identity_maximum	39	character varying
pg	db_name	information_schema	columns	identity_minimum	40	character varying
pg	db_name	information_schema	columns	identity_start	37	character varying
pg	db_name	information_schema	columns	interval_precision	16	integer
pg	db_name	information_schema	columns	interval_type	15	character varying
pg	db_name	information_schema	columns	is_generated	42	character varying
pg	db_name	information_schema	columns	is_identity	35	character varying
pg	db_name	information_schema	columns	is_nullable	7	character varying
pg	db_name	information_schema	columns	is_self_referencing	34	character varying
pg	db_name	information_schema	columns	is_updatable	44	character varying
pg	db_name	information_schema	columns	maximum_cardinality	32	integer
pg	db_name	information_schema	columns	numeric_precision	11	integer
pg	db_name	information_schema	columns	numeric_precision_radix	12	integer
pg	db_name	information_schema	columns	numeric_scale	13	integer
pg	db_name	information_schema	columns	ordinal_position	5	integer
pg	db_name	information_schema	columns	scope_catalog	29	name
pg	db_name	information_schema	columns	scope_name	31	name
pg	db_name	information_schema	columns	scope_schema	30	name
pg	db_name	information_schema	columns	table_catalog	1	name
pg	db_name	information_schema	columns	table_name	3	name
pg	db_name	information_schema	columns	table_schema	2	name
pg	db_name	information_schema	columns	udt_catalog	26	name
pg	db_name	information_schema	columns	udt_name	28	name
pg	db_name	information_schema	columns	udt_schema	27	name
pg	db_name	information_schema	column_udt_usage	column_name	7	name
pg	db_name	information_schema	column_udt_usage	table_catalog	4	name
pg	db_name	information_schema	column_udt_usage	table_name	6	name
pg	db_name	information_schema	column_udt_usage	table_schema	5	name
pg	db_name	information_schema	column_udt_usage	udt_catalog	1	name
pg	db_name	information_schema	column_udt_usage	udt_name	3	name
pg	db_name	information_schema	column_udt_usage	udt_schema	2	name
pg	db_name	information_schema	constraint_column_usage	column_name	4	name
pg	db_name	information_schema	constraint_column_usage	constraint_catalog	5	name
pg	db_name	information_schema	constraint_column_usage	constraint_name	7	name
pg	db_name	information_schema	constraint_column_usage	constraint_schema	6	name
pg	db_name	information_schema	constraint_column_usage	table_catalog	1	name
pg	db_name	information_schema	constraint_column_usage	table_name	3	name
pg	db_name	information_schema	constraint_column_usage	table_schema	2	name
pg	db_name	information_schema	constraint_table_usage	constraint_catalog	4	name
pg	db_name	information_schema	constraint_table_usage	constraint_name	6	name
pg	db_name	information_schema	constraint_table_usage	constraint_schema	5	name
pg	db_name	information_schema	constraint_table_usage	table_catalog	1	name
pg	db_name	information_schema	constraint_table_usage	table_name	3	name
pg	db_name	information_schema	constraint_table_usage	table_schema	2	name
pg	db_name	information_schema	data_type_privileges	dtd_identifier	5	name
pg	db_name	information_schema	data_type_privileges	object_catalog	1	name
pg	db_name	information_schema	data_type_privileges	object_name	3	name
pg	db_name	information_schema	data_type_privileges	object_schema	2	name
pg	db_name	information_schema	data_type_privileges	object_type	4	character varying
pg	db_name	information_schema	domain_constraints	constraint_catalog	1	name
pg	db_name	information_schema	domain_constraints	constraint_name	3	name
pg	db_name	information_schema	domain_constraints	constraint_schema	2	name
pg	db_name	information_schema	domain_constraints	domain_catalog	4	name
pg	db_name	information_schema	domain_constraints	domain_name	6	name
pg	db_name	information_schema	domain_constraints	domain_schema	5	name
pg	db_name	information_schema	domain_constraints	initially_deferred	8	character varying
pg	db_name	information_schema	domain_constraints	is_deferrable	7	character varying
pg	db_name	information_schema	domains	character_maximum_length	5	integer
pg	db_name	information_schema	domains	character_octet_length	6	integer
pg	db_name	information_schema	domains	character_set_catalog	7	name
pg	db_name	information_schema	domains	character_set_name	9	name
pg	db_name	information_schema	domains	character_set_schema	8	name
pg	db_name	information_schema	domains	collation_catalog	10	name
pg	db_name	information_schema	domains	collation_name	12	name
pg	db_name	information_schema	domains	collation_schema	11	name
pg	db_name	information_schema	domains	data_type	4	character varying
pg	db_name	information_schema	domains	datetime_precision	16	integer
pg	db_name	information_schema	domains	domain_catalog	1	name
pg	db_name	information_schema	domains	domain_default	19	character varying
pg	db_name	information_schema	domains	domain_name	3	name
pg	db_name	information_schema	domains	domain_schema	2	name
pg	db_name	information_schema	domains	dtd_identifier	27	name
pg	db_name	information_schema	domains	interval_precision	18	integer
pg	db_name	information_schema	domains	interval_type	17	character varying
pg	db_name	information_schema	domains	maximum_cardinality	26	integer
pg	db_name	information_schema	domains	numeric_precision	13	integer
pg	db_name	information_schema	domains	numeric_precision_radix	14	integer
pg	db_name	information_schema	domains	numeric_scale	15	integer
pg	db_name	information_schema	domains	scope_catalog	23	name
pg	db_name	information_schema	domains	scope_name	25	name
pg	db_name	information_schema	domains	scope_schema	24	name
pg	db_name	information_schema	domains	udt_catalog	20	name
pg	db_name	information_schema	domains	udt_name	22	name
pg	db_name	information_schema	domains	udt_schema	21	name
pg	db_name	information_schema	domain_udt_usage	domain_catalog	4	name
pg	db_name	information_schema	domain_udt_usage	domain_name	6	name
pg	db_name	information_schema	domain_udt_usage	domain_schema	5	name
pg	db_name	information_schema	domain_udt_usage	udt_catalog	1	name
pg	db_name	information_schema	domain_udt_usage	udt_name	3	name
pg	db_name	information_schema	domain_udt_usage	udt_schema	2	name
pg	db_name	information_schema	element_types	character_maximum_length	7	integer
pg	db_name	information_schema	element_types	character_octet_length	8	integer
pg	db_name	information_schema	element_types	character_set_catalog	9	name
pg	db_name	information_schema	element_types	character_set_name	11	name
pg	db_name	information_schema	element_types	character_set_schema	10	name
pg	db_name	information_schema	element_types	collation_catalog	12	name
pg	db_name	information_schema	element_types	collation_name	14	name
pg	db_name	information_schema	element_types	collation_schema	13	name
pg	db_name	information_schema	element_types	collection_type_identifier	5	name
pg	db_name	information_schema	element_types	data_type	6	character varying
pg	db_name	information_schema	element_types	datetime_precision	18	integer
pg	db_name	information_schema	element_types	domain_default	21	character varying
pg	db_name	information_schema	element_types	dtd_identifier	29	name
pg	db_name	information_schema	element_types	interval_precision	20	integer
pg	db_name	information_schema	element_types	interval_type	19	character varying
pg	db_name	information_schema	element_types	maximum_cardinality	28	integer
pg	db_name	information_schema	element_types	numeric_precision	15	integer
pg	db_name	information_schema	element_types	numeric_precision_radix	16	integer
pg	db_name	information_schema	element_types	numeric_scale	17	integer
pg	db_name	information_schema	element_types	object_catalog	1	name
pg	db_name	information_schema	element_types	object_name	3	name
pg	db_name	information_schema	element_types	object_schema	2	name
pg	db_name	information_schema	element_types	object_type	4	character varying
pg	db_name	information_schema	element_types	scope_catalog	25	name
pg	db_name	information_schema	element_types	scope_name	27	name
pg	db_name	information_schema	element_types	scope_schema	26	name
pg	db_name	information_schema	element_types	udt_catalog	22	name
pg	db_name	information_schema	element_types	udt_name	24	name
pg	db_name	information_schema	element_types	udt_schema	23	name
pg	db_name	information_schema	enabled_roles	role_name	1	name
pg	db_name	information_schema	foreign_data_wrapper_options	foreign_data_wrapper_catalog	1	name
pg	db_name	information_schema	foreign_data_wrapper_options	foreign_data_wrapper_name	2	name
pg	db_name	information_schema	foreign_data_wrapper_options	option_name	3	name
pg	db_name	information_schema	foreign_data_wrapper_options	option_value	4	character varying
pg	db_name	information_schema	foreign_data_wrappers	authorization_identifier	3	name
pg	db_name	information_schema	foreign_data_wrappers	foreign_data_wrapper_catalog	1	name
pg	db_name	information_schema	foreign_data_wrappers	foreign_data_wrapper_language	5	character varying
pg	db_name	information_schema	foreign_data_wrappers	foreign_data_wrapper_name	2	name
pg	db_name	information_schema	foreign_data_wrappers	library_name	4	character varying
pg	db_name	information_schema	foreign_server_options	foreign_server_catalog	1	name
pg	db_name	information_schema	foreign_server_options	foreign_server_name	2	name
pg	db_name	information_schema	foreign_server_options	option_name	3	name
pg	db_name	information_schema	foreign_server_options	option_value	4	character varying
pg	db_name	information_schema	foreign_servers	authorization_identifier	7	name
pg	db_name	information_schema	foreign_servers	foreign_data_wrapper_catalog	3	name
pg	db_name	information_schema	foreign_servers	foreign_data_wrapper_name	4	name
pg	db_name	information_schema	foreign_servers	foreign_server_catalog	1	name
pg	db_name	information_schema	foreign_servers	foreign_server_name	2	name
pg	db_name	information_schema	foreign_servers	foreign_server_type	5	character varying
pg	db_name	information_schema	foreign_servers	foreign_server_version	6	character varying
pg	db_name	information_schema	foreign_table_options	foreign_table_catalog	1	name
pg	db_name	information_schema	foreign_table_options	foreign_table_name	3	name
pg	db_name	information_schema	foreign_table_options	foreign_table_schema	2	name
pg	db_name	information_schema	foreign_table_options	option_name	4	name
pg	db_name	information_schema	foreign_table_options	option_value	5	character varying
pg	db_name	information_schema	foreign_tables	foreign_server_catalog	4	name
pg	db_name	information_schema	foreign_tables	foreign_server_name	5	name
pg	db_name	information_schema	foreign_tables	foreign_table_catalog	1	name
pg	db_name	information_schema	foreign_tables	foreign_table_name	3	name
pg	db_name	information_schema	foreign_tables	foreign_table_schema	2	name
pg	db_name	information_schema	information_schema_catalog_name	catalog_name	1	name
pg	db_name	information_schema	key_column_usage	column_name	7	name
pg	db_name	information_schema	key_column_usage	constraint_catalog	1	name
pg	db_name	information_schema	key_column_usage	constraint_name	3	name
pg	db_name	information_schema	key_column_usage	constraint_schema	2	name
pg	db_name	information_schema	key_column_usage	ordinal_position	8	integer
pg	db_name	information_schema	key_column_usage	position_in_unique_constraint	9	integer
pg	db_name	information_schema	key_column_usage	table_catalog	4	name
pg	db_name	information_schema	key_column_usage	table_name	6	name
pg	db_name	information_schema	key_column_usage	table_schema	5	name
pg	db_name	information_schema	parameters	as_locator	7	character varying
pg	db_name	information_schema	parameters	character_maximum_length	10	integer
pg	db_name	information_schema	parameters	character_octet_length	11	integer
pg	db_name	information_schema	parameters	character_set_catalog	12	name
pg	db_name	information_schema	parameters	character_set_name	14	name
pg	db_name	information_schema	parameters	character_set_schema	13	name
pg	db_name	information_schema	parameters	collation_catalog	15	name
pg	db_name	information_schema	parameters	collation_name	17	name
pg	db_name	information_schema	parameters	collation_schema	16	name
pg	db_name	information_schema	parameters	data_type	9	character varying
pg	db_name	information_schema	parameters	datetime_precision	21	integer
pg	db_name	information_schema	parameters	dtd_identifier	31	name
pg	db_name	information_schema	parameters	interval_precision	23	integer
pg	db_name	information_schema	parameters	interval_type	22	character varying
pg	db_name	information_schema	parameters	is_result	6	character varying
pg	db_name	information_schema	parameters	maximum_cardinality	30	integer
pg	db_name	information_schema	parameters	numeric_precision	18	integer
pg	db_name	information_schema	parameters	numeric_precision_radix	19	integer
pg	db_name	information_schema	parameters	numeric_scale	20	integer
pg	db_name	information_schema	parameters	ordinal_position	4	integer
pg	db_name	information_schema	parameters	parameter_default	32	character varying
pg	db_name	information_schema	parameters	parameter_mode	5	character varying
pg	db_name	information_schema	parameters	parameter_name	8	name
pg	db_name	information_schema	parameters	scope_catalog	27	name
pg	db_name	information_schema	parameters	scope_name	29	name
pg	db_name	information_schema	parameters	scope_schema	28	name
pg	db_name	information_schema	parameters	specific_catalog	1	name
pg	db_name	information_schema	parameters	specific_name	3	name
pg	db_name	information_schema	parameters	specific_schema	2	name
pg	db_name	information_schema	parameters	udt_catalog	24	name
pg	db_name	information_schema	parameters	udt_name	26	name
pg	db_name	information_schema	parameters	udt_schema	25	name
pg	db_name	information_schema	_pg_foreign_data_wrappers	authorization_identifier	6	name
pg	db_name	information_schema	_pg_foreign_data_wrappers	fdwoptions	3	ARRAY
pg	db_name	information_schema	_pg_foreign_data_wrappers	fdwowner	2	oid
pg	db_name	information_schema	_pg_foreign_data_wrappers	foreign_data_wrapper_catalog	4	name
pg	db_name	information_schema	_pg_foreign_data_wrappers	foreign_data_wrapper_language	7	character varying
pg	db_name	information_schema	_pg_foreign_data_wrappers	foreign_data_wrapper_name	5	name
pg	db_name	information_schema	_pg_foreign_data_wrappers	oid	1	oid
pg	db_name	information_schema	_pg_foreign_servers	authorization_identifier	9	name
pg	db_name	information_schema	_pg_foreign_servers	foreign_data_wrapper_catalog	5	name
pg	db_name	information_schema	_pg_foreign_servers	foreign_data_wrapper_name	6	name
pg	db_name	information_schema	_pg_foreign_servers	foreign_server_catalog	3	name
pg	db_name	information_schema	_pg_foreign_servers	foreign_server_name	4	name
pg	db_name	information_schema	_pg_foreign_servers	foreign_server_type	7	character varying
pg	db_name	information_schema	_pg_foreign_servers	foreign_server_version	8	character varying
pg	db_name	information_schema	_pg_foreign_servers	oid	1	oid
pg	db_name	information_schema	_pg_foreign_servers	srvoptions	2	ARRAY
pg	db_name	information_schema	_pg_foreign_table_columns	attfdwoptions	4	ARRAY
pg	db_name	information_schema	_pg_foreign_table_columns	attname	3	name
pg	db_name	information_schema	_pg_foreign_table_columns	nspname	1	name
pg	db_name	information_schema	_pg_foreign_table_columns	relname	2	name
pg	db_name	information_schema	_pg_foreign_tables	authorization_identifier	7	name
pg	db_name	information_schema	_pg_foreign_tables	foreign_server_catalog	5	name
pg	db_name	information_schema	_pg_foreign_tables	foreign_server_name	6	name
pg	db_name	information_schema	_pg_foreign_tables	foreign_table_catalog	1	name
pg	db_name	information_schema	_pg_foreign_tables	foreign_table_name	3	name
pg	db_name	information_schema	_pg_foreign_tables	foreign_table_schema	2	name
pg	db_name	information_schema	_pg_foreign_tables	ftoptions	4	ARRAY
pg	db_name	information_schema	_pg_user_mappings	authorization_identifier	4	name
pg	db_name	information_schema	_pg_user_mappings	foreign_server_catalog	5	name
pg	db_name	information_schema	_pg_user_mappings	foreign_server_name	6	name
pg	db_name	information_schema	_pg_user_mappings	oid	1	oid
pg	db_name	information_schema	_pg_user_mappings	srvowner	7	name
pg	db_name	information_schema	_pg_user_mappings	umoptions	2	ARRAY
pg	db_name	information_schema	_pg_user_mappings	umuser	3	oid
pg	db_name	information_schema	referential_constraints	constraint_catalog	1	name
pg	db_name	information_schema	referential_constraints	constraint_name	3	name
pg	db_name	information_schema	referential_constraints	constraint_schema	2	name
pg	db_name	information_schema	referential_constraints	delete_rule	9	character varying
pg	db_name	information_schema	referential_constraints	match_option	7	character varying
pg	db_name	information_schema	referential_constraints	unique_constraint_catalog	4	name
pg	db_name	information_schema	referential_constraints	unique_constraint_name	6	name
pg	db_name	information_schema	referential_constraints	unique_constraint_schema	5	name
pg	db_name	information_schema	referential_constraints	update_rule	8	character varying
pg	db_name	information_schema	role_column_grants	column_name	6	name
pg	db_name	information_schema	role_column_grants	grantee	2	name
pg	db_name	information_schema	role_column_grants	grantor	1	name
pg	db_name	information_schema	role_column_grants	is_grantable	8	character varying
pg	db_name	information_schema	role_column_grants	privilege_type	7	character varying
pg	db_name	information_schema	role_column_grants	table_catalog	3	name
pg	db_name	information_schema	role_column_grants	table_name	5	name
pg	db_name	information_schema	role_column_grants	table_schema	4	name
pg	db_name	information_schema	role_routine_grants	grantee	2	name
pg	db_name	information_schema	role_routine_grants	grantor	1	name
pg	db_name	information_schema	role_routine_grants	is_grantable	10	character varying
pg	db_name	information_schema	role_routine_grants	privilege_type	9	character varying
pg	db_name	information_schema	role_routine_grants	routine_catalog	6	name
pg	db_name	information_schema	role_routine_grants	routine_name	8	name
pg	db_name	information_schema	role_routine_grants	routine_schema	7	name
pg	db_name	information_schema	role_routine_grants	specific_catalog	3	name
pg	db_name	information_schema	role_routine_grants	specific_name	5	name
pg	db_name	information_schema	role_routine_grants	specific_schema	4	name
pg	db_name	information_schema	role_table_grants	grantee	2	name
pg	db_name	information_schema	role_table_grants	grantor	1	name
pg	db_name	information_schema	role_table_grants	is_grantable	7	character varying
pg	db_name	information_schema	role_table_grants	privilege_type	6	character varying
pg	db_name	information_schema	role_table_grants	table_catalog	3	name
pg	db_name	information_schema	role_table_grants	table_name	5	name
pg	db_name	information_schema	role_table_grants	table_schema	4	name
pg	db_name	information_schema	role_table_grants	with_hierarchy	8	character varying
pg	db_name	information_schema	role_udt_grants	grantee	2	name
pg	db_name	information_schema	role_udt_grants	grantor	1	name
pg	db_name	information_schema	role_udt_grants	is_grantable	7	character varying
pg	db_name	information_schema	role_udt_grants	privilege_type	6	character varying
pg	db_name	information_schema	role_udt_grants	udt_catalog	3	name
pg	db_name	information_schema	role_udt_grants	udt_name	5	name
pg	db_name	information_schema	role_udt_grants	udt_schema	4	name
pg	db_name	information_schema	role_usage_grants	grantee	2	name
pg	db_name	information_schema	role_usage_grants	grantor	1	name
pg	db_name	information_schema	role_usage_grants	is_grantable	8	character varying
pg	db_name	information_schema	role_usage_grants	object_catalog	3	name
pg	db_name	information_schema	role_usage_grants	object_name	5	name
pg	db_name	information_schema	role_usage_grants	object_schema	4	name
pg	db_name	information_schema	role_usage_grants	object_type	6	character varying
pg	db_name	information_schema	role_usage_grants	privilege_type	7	character varying
pg	db_name	information_schema	routine_privileges	grantee	2	name
pg	db_name	information_schema	routine_privileges	grantor	1	name
pg	db_name	information_schema	routine_privileges	is_grantable	10	character varying
pg	db_name	information_schema	routine_privileges	privilege_type	9	character varying
pg	db_name	information_schema	routine_privileges	routine_catalog	6	name
pg	db_name	information_schema	routine_privileges	routine_name	8	name
pg	db_name	information_schema	routine_privileges	routine_schema	7	name
pg	db_name	information_schema	routine_privileges	specific_catalog	3	name
pg	db_name	information_schema	routine_privileges	specific_name	5	name
pg	db_name	information_schema	routine_privileges	specific_schema	4	name
pg	db_name	information_schema	routines	as_locator	54	character varying
pg	db_name	information_schema	routines	character_maximum_length	15	integer
pg	db_name	information_schema	routines	character_octet_length	16	integer
pg	db_name	information_schema	routines	character_set_catalog	17	name
pg	db_name	information_schema	routines	character_set_name	19	name
pg	db_name	information_schema	routines	character_set_schema	18	name
pg	db_name	information_schema	routines	collation_catalog	20	name
pg	db_name	information_schema	routines	collation_name	22	name
pg	db_name	information_schema	routines	collation_schema	21	name
pg	db_name	information_schema	routines	created	55	timestamp with time zone
pg	db_name	information_schema	routines	data_type	14	character varying
pg	db_name	information_schema	routines	datetime_precision	26	integer
pg	db_name	information_schema	routines	dtd_identifier	36	name
pg	db_name	information_schema	routines	external_language	40	character varying
pg	db_name	information_schema	routines	external_name	39	character varying
pg	db_name	information_schema	routines	interval_precision	28	integer
pg	db_name	information_schema	routines	interval_type	27	character varying
pg	db_name	information_schema	routines	is_deterministic	42	character varying
pg	db_name	information_schema	routines	is_implicitly_invocable	49	character varying
pg	db_name	information_schema	routines	is_null_call	44	character varying
pg	db_name	information_schema	routines	is_udt_dependent	58	character varying
pg	db_name	information_schema	routines	is_user_defined_cast	48	character varying
pg	db_name	information_schema	routines	last_altered	56	timestamp with time zone
pg	db_name	information_schema	routines	max_dynamic_result_sets	47	integer
pg	db_name	information_schema	routines	maximum_cardinality	35	integer
pg	db_name	information_schema	routines	module_catalog	8	name
pg	db_name	information_schema	routines	module_name	10	name
pg	db_name	information_schema	routines	module_schema	9	name
pg	db_name	information_schema	routines	new_savepoint_level	57	character varying
pg	db_name	information_schema	routines	numeric_precision	23	integer
pg	db_name	information_schema	routines	numeric_precision_radix	24	integer
pg	db_name	information_schema	routines	numeric_scale	25	integer
pg	db_name	information_schema	routines	parameter_style	41	character varying
pg	db_name	information_schema	routines	result_cast_as_locator	60	character varying
pg	db_name	information_schema	routines	result_cast_char_max_length	61	integer
pg	db_name	information_schema	routines	result_cast_char_octet_length	62	integer
pg	db_name	information_schema	routines	result_cast_char_set_catalog	63	name
pg	db_name	information_schema	routines	result_cast_char_set_name	65	name
pg	db_name	information_schema	routines	result_cast_char_set_schema	64	name
pg	db_name	information_schema	routines	result_cast_collation_catalog	66	name
pg	db_name	information_schema	routines	result_cast_collation_name	68	name
pg	db_name	information_schema	routines	result_cast_collation_schema	67	name
pg	db_name	information_schema	routines	result_cast_datetime_precision	72	integer
pg	db_name	information_schema	routines	result_cast_dtd_identifier	82	name
pg	db_name	information_schema	routines	result_cast_from_data_type	59	character varying
pg	db_name	information_schema	routines	result_cast_interval_precision	74	integer
pg	db_name	information_schema	routines	result_cast_interval_type	73	character varying
pg	db_name	information_schema	routines	result_cast_maximum_cardinality	81	integer
pg	db_name	information_schema	routines	result_cast_numeric_precision	69	integer
pg	db_name	information_schema	routines	result_cast_numeric_precision_radix	70	integer
pg	db_name	information_schema	routines	result_cast_numeric_scale	71	integer
pg	db_name	information_schema	routines	result_cast_scope_catalog	78	name
pg	db_name	information_schema	routines	result_cast_scope_name	80	name
pg	db_name	information_schema	routines	result_cast_scope_schema	79	name
pg	db_name	information_schema	routines	result_cast_type_udt_catalog	75	name
pg	db_name	information_schema	routines	result_cast_type_udt_name	77	name
pg	db_name	information_schema	routines	result_cast_type_udt_schema	76	name
pg	db_name	information_schema	routines	routine_body	37	character varying
pg	db_name	information_schema	routines	routine_catalog	4	name
pg	db_name	information_schema	routines	routine_definition	38	character varying
pg	db_name	information_schema	routines	routine_name	6	name
pg	db_name	information_schema	routines	routine_schema	5	name
pg	db_name	information_schema	routines	routine_type	7	character varying
pg	db_name	information_schema	routines	schema_level_routine	46	character varying
pg	db_name	information_schema	routines	scope_catalog	32	name
pg	db_name	information_schema	routines	scope_name	34	name
pg	db_name	information_schema	routines	scope_schema	33	name
pg	db_name	information_schema	routines	security_type	50	character varying
pg	db_name	information_schema	routines	specific_catalog	1	name
pg	db_name	information_schema	routines	specific_name	3	name
pg	db_name	information_schema	routines	specific_schema	2	name
pg	db_name	information_schema	routines	sql_data_access	43	character varying
pg	db_name	information_schema	routines	sql_path	45	character varying
pg	db_name	information_schema	routines	to_sql_specific_catalog	51	name
pg	db_name	information_schema	routines	to_sql_specific_name	53	name
pg	db_name	information_schema	routines	to_sql_specific_schema	52	name
pg	db_name	information_schema	routines	type_udt_catalog	29	name
pg	db_name	information_schema	routines	type_udt_name	31	name
pg	db_name	information_schema	routines	type_udt_schema	30	name
pg	db_name	information_schema	routines	udt_catalog	11	name
pg	db_name	information_schema	routines	udt_name	13	name
pg	db_name	information_schema	routines	udt_schema	12	name
pg	db_name	information_schema	schemata	catalog_name	1	name
pg	db_name	information_schema	schemata	default_character_set_catalog	4	name
pg	db_name	information_schema	schemata	default_character_set_name	6	name
pg	db_name	information_schema	schemata	default_character_set_schema	5	name
pg	db_name	information_schema	schemata	schema_name	2	name
pg	db_name	information_schema	schemata	schema_owner	3	name
pg	db_name	information_schema	schemata	sql_path	7	character varying
pg	db_name	information_schema	sequences	cycle_option	12	character varying
pg	db_name	information_schema	sequences	data_type	4	character varying
pg	db_name	information_schema	sequences	increment	11	character varying
pg	db_name	information_schema	sequences	maximum_value	10	character varying
pg	db_name	information_schema	sequences	minimum_value	9	character varying
pg	db_name	information_schema	sequences	numeric_precision	5	integer
pg	db_name	information_schema	sequences	numeric_precision_radix	6	integer
pg	db_name	information_schema	sequences	numeric_scale	7	integer
pg	db_name	information_schema	sequences	sequence_catalog	1	name
pg	db_name	information_schema	sequences	sequence_name	3	name
pg	db_name	information_schema	sequences	sequence_schema	2	name
pg	db_name	information_schema	sequences	start_value	8	character varying
pg	db_name	information_schema	sql_features	comments	7	character varying
pg	db_name	information_schema	sql_features	feature_id	1	character varying
pg	db_name	information_schema	sql_features	feature_name	2	character varying
pg	db_name	information_schema	sql_features	is_supported	5	character varying
pg	db_name	information_schema	sql_features	is_verified_by	6	character varying
pg	db_name	information_schema	sql_features	sub_feature_id	3	character varying
pg	db_name	information_schema	sql_features	sub_feature_name	4	character varying
pg	db_name	information_schema	sql_implementation_info	character_value	4	character varying
pg	db_name	information_schema	sql_implementation_info	comments	5	character varying
pg	db_name	information_schema	sql_implementation_info	implementation_info_id	1	character varying
pg	db_name	information_schema	sql_implementation_info	implementation_info_name	2	character varying
pg	db_name	information_schema	sql_implementation_info	integer_value	3	integer
pg	db_name	information_schema	sql_languages	sql_language_binding_style	6	character varying
pg	db_name	information_schema	sql_languages	sql_language_conformance	3	character varying
pg	db_name	information_schema	sql_languages	sql_language_implementation	5	character varying
pg	db_name	information_schema	sql_languages	sql_language_integrity	4	character varying
pg	db_name	information_schema	sql_languages	sql_language_programming_language	7	character varying
pg	db_name	information_schema	sql_languages	sql_language_source	1	character varying
pg	db_name	information_schema	sql_languages	sql_language_year	2	character varying
pg	db_name	information_schema	sql_packages	comments	5	character varying
pg	db_name	information_schema	sql_packages	feature_id	1	character varying
pg	db_name	information_schema	sql_packages	feature_name	2	character varying
pg	db_name	information_schema	sql_packages	is_supported	3	character varying
pg	db_name	information_schema	sql_packages	is_verified_by	4	character varying
pg	db_name	information_schema	sql_parts	comments	5	character varying
pg	db_name	information_schema	sql_parts	feature_id	1	character varying
pg	db_name	information_schema	sql_parts	feature_name	2	character varying
pg	db_name	information_schema	sql_parts	is_supported	3	character varying
pg	db_name	information_schema	sql_parts	is_verified_by	4	character varying
pg	db_name	information_schema	sql_sizing	comments	4	character varying
pg	db_name	information_schema	sql_sizing_profiles	comments	5	character varying
pg	db_name	information_schema	sql_sizing_profiles	profile_id	3	character varying
pg	db_name	information_schema	sql_sizing_profiles	required_value	4	integer
pg	db_name	information_schema	sql_sizing_profiles	sizing_id	1	integer
pg	db_name	information_schema	sql_sizing_profiles	sizing_name	2	character varying
pg	db_name	information_schema	sql_sizing	sizing_id	1	integer
pg	db_name	information_schema	sql_sizing	sizing_name	2	character varying
pg	db_name	information_schema	sql_sizing	supported_value	3	integer
pg	db_name	information_schema	table_constraints	constraint_catalog	1	name
pg	db_name	information_schema	table_constraints	constraint_name	3	name
pg	db_name	information_schema	table_constraints	constraint_schema	2	name
pg	db_name	information_schema	table_constraints	constraint_type	7	character varying
pg	db_name	information_schema	table_constraints	enforced	10	character varying
pg	db_name	information_schema	table_constraints	initially_deferred	9	character varying
pg	db_name	information_schema	table_constraints	is_deferrable	8	character varying
pg	db_name	information_schema	table_constraints	table_catalog	4	name
pg	db_name	information_schema	table_constraints	table_name	6	name
pg	db_name	information_schema	table_constraints	table_schema	5	name
pg	db_name	information_schema	table_privileges	grantee	2	name
pg	db_name	information_schema	table_privileges	grantor	1	name
pg	db_name	information_schema	table_privileges	is_grantable	7	character varying
pg	db_name	information_schema	table_privileges	privilege_type	6	character varying
pg	db_name	information_schema	table_privileges	table_catalog	3	name
pg	db_name	information_schema	table_privileges	table_name	5	name
pg	db_name	information_schema	table_privileges	table_schema	4	name
pg	db_name	information_schema	table_privileges	with_hierarchy	8	character varying
pg	db_name	information_schema	tables	commit_action	12	character varying
pg	db_name	information_schema	tables	is_insertable_into	10	character varying
pg	db_name	information_schema	tables	is_typed	11	character varying
pg	db_name	information_schema	tables	reference_generation	6	character varying
pg	db_name	information_schema	tables	self_referencing_column_name	5	name
pg	db_name	information_schema	tables	table_catalog	1	name
pg	db_name	information_schema	tables	table_name	3	name
pg	db_name	information_schema	tables	table_schema	2	name
pg	db_name	information_schema	tables	table_type	4	character varying
pg	db_name	information_schema	tables	user_defined_type_catalog	7	name
pg	db_name	information_schema	tables	user_defined_type_name	9	name
pg	db_name	information_schema	tables	user_defined_type_schema	8	name
pg	db_name	information_schema	transforms	group_name	7	name
pg	db_name	information_schema	transforms	specific_catalog	4	name
pg	db_name	information_schema	transforms	specific_name	6	name
pg	db_name	information_schema	transforms	specific_schema	5	name
pg	db_name	information_schema	transforms	transform_type	8	character varying
pg	db_name	information_schema	transforms	udt_catalog	1	name
pg	db_name	information_schema	transforms	udt_name	3	name
pg	db_name	information_schema	transforms	udt_schema	2	name
pg	db_name	information_schema	triggered_update_columns	event_object_catalog	4	name
pg	db_name	information_schema	triggered_update_columns	event_object_column	7	name
pg	db_name	information_schema	triggered_update_columns	event_object_schema	5	name
pg	db_name	information_schema	triggered_update_columns	event_object_table	6	name
pg	db_name	information_schema	triggered_update_columns	trigger_catalog	1	name
pg	db_name	information_schema	triggered_update_columns	trigger_name	3	name
pg	db_name	information_schema	triggered_update_columns	trigger_schema	2	name
pg	db_name	information_schema	triggers	action_condition	9	character varying
pg	db_name	information_schema	triggers	action_order	8	integer
pg	db_name	information_schema	triggers	action_orientation	11	character varying
pg	db_name	information_schema	triggers	action_reference_new_row	16	name
pg	db_name	information_schema	triggers	action_reference_new_table	14	name
pg	db_name	information_schema	triggers	action_reference_old_row	15	name
pg	db_name	information_schema	triggers	action_reference_old_table	13	name
pg	db_name	information_schema	triggers	action_statement	10	character varying
pg	db_name	information_schema	triggers	action_timing	12	character varying
pg	db_name	information_schema	triggers	created	17	timestamp with time zone
pg	db_name	information_schema	triggers	event_manipulation	4	character varying
pg	db_name	information_schema	triggers	event_object_catalog	5	name
pg	db_name	information_schema	triggers	event_object_schema	6	name
pg	db_name	information_schema	triggers	event_object_table	7	name
pg	db_name	information_schema	triggers	trigger_catalog	1	name
pg	db_name	information_schema	triggers	trigger_name	3	name
pg	db_name	information_schema	triggers	trigger_schema	2	name
pg	db_name	information_schema	udt_privileges	grantee	2	name
pg	db_name	information_schema	udt_privileges	grantor	1	name
pg	db_name	information_schema	udt_privileges	is_grantable	7	character varying
pg	db_name	information_schema	udt_privileges	privilege_type	6	character varying
pg	db_name	information_schema	udt_privileges	udt_catalog	3	name
pg	db_name	information_schema	udt_privileges	udt_name	5	name
pg	db_name	information_schema	udt_privileges	udt_schema	4	name
pg	db_name	information_schema	usage_privileges	grantee	2	name
pg	db_name	information_schema	usage_privileges	grantor	1	name
pg	db_name	information_schema	usage_privileges	is_grantable	8	character varying
pg	db_name	information_schema	usage_privileges	object_catalog	3	name
pg	db_name	information_schema	usage_privileges	object_name	5	name
pg	db_name	information_schema	usage_privileges	object_schema	4	name
pg	db_name	information_schema	usage_privileges	object_type	6	character varying
pg	db_name	information_schema	usage_privileges	privilege_type	7	character varying
pg	db_name	information_schema	user_defined_types	character_maximum_length	14	integer
pg	db_name	information_schema	user_defined_types	character_octet_length	15	integer
pg	db_name	information_schema	user_defined_types	character_set_catalog	16	name
pg	db_name	information_schema	user_defined_types	character_set_name	18	name
pg	db_name	information_schema	user_defined_types	character_set_schema	17	name
pg	db_name	information_schema	user_defined_types	collation_catalog	19	name
pg	db_name	information_schema	user_defined_types	collation_name	21	name
pg	db_name	information_schema	user_defined_types	collation_schema	20	name
pg	db_name	information_schema	user_defined_types	data_type	13	character varying
pg	db_name	information_schema	user_defined_types	datetime_precision	25	integer
pg	db_name	information_schema	user_defined_types	interval_precision	27	integer
pg	db_name	information_schema	user_defined_types	interval_type	26	character varying
pg	db_name	information_schema	user_defined_types	is_final	6	character varying
pg	db_name	information_schema	user_defined_types	is_instantiable	5	character varying
pg	db_name	information_schema	user_defined_types	numeric_precision	22	integer
pg	db_name	information_schema	user_defined_types	numeric_precision_radix	23	integer
pg	db_name	information_schema	user_defined_types	numeric_scale	24	integer
pg	db_name	information_schema	user_defined_types	ordering_category	8	character varying
pg	db_name	information_schema	user_defined_types	ordering_form	7	character varying
pg	db_name	information_schema	user_defined_types	ordering_routine_catalog	9	name
pg	db_name	information_schema	user_defined_types	ordering_routine_name	11	name
pg	db_name	information_schema	user_defined_types	ordering_routine_schema	10	name
pg	db_name	information_schema	user_defined_types	ref_dtd_identifier	29	name
pg	db_name	information_schema	user_defined_types	reference_type	12	character varying
pg	db_name	information_schema	user_defined_types	source_dtd_identifier	28	name
pg	db_name	information_schema	user_defined_types	user_defined_type_catalog	1	name
pg	db_name	information_schema	user_defined_types	user_defined_type_category	4	character varying
pg	db_name	information_schema	user_defined_types	user_defined_type_name	3	name
pg	db_name	information_schema	user_defined_types	user_defined_type_schema	2	name
pg	db_name	information_schema	user_mapping_options	authorization_identifier	1	name
pg	db_name	information_schema	user_mapping_options	foreign_server_catalog	2	name
pg	db_name	information_schema	user_mapping_options	foreign_server_name	3	name
pg	db_name	information_schema	user_mapping_options	option_name	4	name
pg	db_name	information_schema	user_mapping_options	option_value	5	character varying
pg	db_name	information_schema	user_mappings	authorization_identifier	1	name
pg	db_name	information_schema	user_mappings	foreign_server_catalog	2	name
pg	db_name	information_schema	user_mappings	foreign_server_name	3	name
pg	db_name	information_schema	view_column_usage	column_name	7	name
pg	db_name	information_schema	view_column_usage	table_catalog	4	name
pg	db_name	information_schema	view_column_usage	table_name	6	name
pg	db_name	information_schema	view_column_usage	table_schema	5	name
pg	db_name	information_schema	view_column_usage	view_catalog	1	name
pg	db_name	information_schema	view_column_usage	view_name	3	name
pg	db_name	information_schema	view_column_usage	view_schema	2	name
pg	db_name	information_schema	view_routine_usage	specific_catalog	4	name
pg	db_name	information_schema	view_routine_usage	specific_name	6	name
pg	db_name	information_schema	view_routine_usage	specific_schema	5	name
pg	db_name	information_schema	view_routine_usage	table_catalog	1	name
pg	db_name	information_schema	view_routine_usage	table_name	3	name
pg	db_name	information_schema	view_routine_usage	table_schema	2	name
pg	db_name	information_schema	views	check_option	5	character varying
pg	db_name	information_schema	views	is_insertable_into	7	character varying
pg	db_name	information_schema	views	is_trigger_deletable	9	character varying
pg	db_name	information_schema	views	is_trigger_insertable_into	10	character varying
pg	db_name	information_schema	views	is_trigger_updatable	8	character varying
pg	db_name	information_schema	views	is_updatable	6	character varying
pg	db_name	information_schema	views	table_catalog	1	name
pg	db_name	information_schema	views	table_name	3	name
pg	db_name	information_schema	views	table_schema	2	name
pg	db_name	information_schema	views	view_definition	4	character varying
pg	db_name	information_schema	view_table_usage	table_catalog	4	name
pg	db_name	information_schema	view_table_usage	table_name	6	name
pg	db_name	information_schema	view_table_usage	table_schema	5	name
pg	db_name	information_schema	view_table_usage	view_catalog	1	name
pg	db_name	information_schema	view_table_usage	view_name	3	name
pg	db_name	information_schema	view_table_usage	view_schema	2	name
sql2003	cat_name	DEFINITION_SCHEMA	ASSERTIONS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ASSERTIONS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ASSERTIONS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ASSERTIONS	INITIALLY_DEFERRED	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ASSERTIONS	IS_DEFERRABLE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	ATTRIBUTE_DEFAULT	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	ATTRIBUTE_NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	DTD_IDENTIFIER	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	IS_DERIVED_REFERENCE_ATTRIBUTE	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	IS_NULLABLE	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	ORDINAL_POSITION	5	integer
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	UDT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	UDT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ATTRIBUTES	UDT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	AUTHORIZATIONS	AUTHORIZATION_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	AUTHORIZATIONS	AUTHORIZATION_TYPE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CATALOG_NAMES	CATALOG_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_ENCODING_FORMS	CHARACTER_ENCODING_FORM_NAME	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_ENCODING_FORMS	CHARACTER_REPERTOIRE_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_REPERTOIRES	CHARACTER_REPERTOIRE_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_REPERTOIRES	DEFAULT_COLLATION_CATALOG	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_REPERTOIRES	DEFAULT_COLLATION_NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_REPERTOIRES	DEFAULT_COLLATION_SCHEMA	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	CHARACTER_REPERTOIRE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	FORM_OF_USE	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHARACTER_SETS	NUMBER_OF_CHARACTERS	6	integer
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINTS	CHECK_CLAUSE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	CHECK_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	CHARACTER_REPERTOIRE_NAME	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_DEFINITION	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_DICTIONARY	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	COLLATION_TYPE	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLLATIONS	PAD_ATTRIBUTE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_COLUMN_USAGE	COLUMN_NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_COLUMN_USAGE	DEPENDENT_COLUMN	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	COLUMN_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	IS_GRANTABLE	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMN_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	COLUMN_DEFAULT	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	COLUMN_NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	DOMAIN_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	DOMAIN_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	DOMAIN_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	DTD_IDENTIFIER	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	GENERATION_EXPRESSION	21	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_CYCLE	19	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_GENERATION	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_INCREMENT	16	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_MAXIMUM	17	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_MINIMUM	18	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IDENTITY_START	15	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IS_GENERATED	20	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IS_IDENTITY	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IS_NULLABLE	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IS_SELF_REFERENCING	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	IS_UPDATABLE	22	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	ORDINAL_POSITION	5	integer
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	COLUMNS	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	CHARACTER_MAXIMUM_LENGTH	10	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	CHARACTER_OCTET_LENGTH	11	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	CHARACTER_SET_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	CHARACTER_SET_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	CHARACTER_SET_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	COLLATION_CATALOG	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	COLLATION_NAME	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	COLLATION_SCHEMA	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	DATA_TYPE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	DATETIME_PRECISION	18	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	DTD_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	INTERVAL_PRECISION	20	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	INTERVAL_TYPE	19	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	MAXIMUM_CARDINALITY	27	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	NUMERIC_PRECISION	15	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	NUMERIC_PRECISION_RADIX	16	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	NUMERIC_SCALE	17	integer
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	OBJECT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	OBJECT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	OBJECT_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	SCOPE_CATALOG	24	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	SCOPE_NAME	26	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	SCOPE_SCHEMA	25	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	USER_DEFINED_TYPE_CATALOG	21	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	USER_DEFINED_TYPE_NAME	23	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DATA_TYPE_DESCRIPTOR	USER_DEFINED_TYPE_SCHEMA	22	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTABLES	SUPERTABLE_NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTABLES	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTABLES	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTABLES	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	USER_DEFINED_TYPE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	USER_DEFINED_TYPE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DIRECT_SUPERTYPES	USER_DEFINED_TYPE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	INITIALLY_DEFERRED	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAIN_CONSTRAINTS	IS_DEFERRABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAINS	DOMAIN_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAINS	DOMAIN_DEFAULT	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAINS	DOMAIN_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAINS	DOMAIN_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	DOMAINS	DTD_IDENTIFIER	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	COLLECTION_TYPE_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	DTD_IDENTIFIER	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	OBJECT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	OBJECT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	OBJECT_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ELEMENT_TYPES	ROOT_DTD_IDENTIFIER	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	DTD_IDENTIFIER	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	FIELD_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	IS_NULLABLE	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	OBJECT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	OBJECT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	OBJECT_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	ORDINAL_POSITION	8	integer
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	ROOT_DTD_IDENTIFIER	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	FIELDS	ROW_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	integer
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	POSITION_IN_UNIQUE_CONSTRAINT	9	integer
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	AS_LOCATOR	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	DTD_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_CATALOG	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_NAME	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_SCHEMA	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	IS_RESULT	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	ORDINAL_POSITION	4	integer
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_MODE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	AS_LOCATOR	20	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	CREATED	21	timestamp
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	DTD_IDENTIFIER	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	IS_CONSTRUCTOR	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	IS_DETERMINISTIC	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	IS_NULL_CALL	16	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	IS_OVERRIDING	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	IS_STATIC	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	LAST_ALTERED	22	timestamp
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	METHOD_LANGUAGE	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	METHOD_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	PARAMETER_STYLE	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_AS_LOCATOR	24	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_FROM_DTD_IDENTIFIER	23	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	SQL_DATA_ACCESS	15	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_CATALOG	17	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_NAME	19	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_SCHEMA	18	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	USER_DEFINED_TYPE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	USER_DEFINED_TYPE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	METHOD_SPECIFICATIONS	USER_DEFINED_TYPE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	AS_LOCATOR	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	DTD_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_CATALOG	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_NAME	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_SCHEMA	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	IS_RESULT	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	ORDINAL_POSITION	4	integer
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	PARAMETER_MODE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	PARAMETER_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_CATALOG	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_NAME	15	varchar
sql2003	cat_name	DEFINITION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_SCHEMA	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	DTD_IDENTIFIER	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	OBJECT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	OBJECT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	OBJECT_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	REFERENCE_TYPE_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENCED_TYPES	ROOT_DTD_IDENTIFIER	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	GRANTOR	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	IS_GRANTABLE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROLE_AUTHORIZATION_DESCRIPTORS	ROLE_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	AS_LOCATOR	32	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	CREATED	33	timestamp
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	DTD_IDENTIFIER	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	EXTERNAL_LANGUAGE	18	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	EXTERNAL_NAME	17	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	IS_DETERMINISTIC	20	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	IS_IMPLICITLY_INVOCABLE	27	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	IS_NULL_CALL	22	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	IS_UDT_DEPENDENT	36	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	IS_USER_DEFINED_CAST	26	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	LAST_ALTERED	34	timestamp
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	MAX_DYNAMIC_RESULT_SETS	25	integer
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	MODULE_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	MODULE_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	MODULE_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	NEW_SAVEPOINT_LEVEL	35	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	PARAMETER_STYLE	19	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	RESULT_CAST_AS_LOCATOR	38	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	RESULT_CAST_FROM_DTD_IDENTIFIER	37	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_BODY	15	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_DEFINITION	16	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	ROUTINE_TYPE	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SCHEMA_LEVEL_ROUTINE	24	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SECURITY_TYPE	28	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SQL_DATA_ACCESS	21	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	SQL_PATH	23	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_CATALOG	29	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_NAME	31	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_SCHEMA	30	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	USER_DEFINED_TYPE_CATALOG	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	USER_DEFINED_TYPE_NAME	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINES	USER_DEFINED_TYPE_SCHEMA	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	CATALOG_NAME	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	SCHEMA_NAME	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	SCHEMA_OWNER	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SCHEMATA	SQL_PATH	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	CYCLE_OPTION	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	DTD_IDENTIFIER	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	INCREMENT	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	MAXIMUM_VALUE	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	MINIMUM_VALUE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	SEQUENCE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	SEQUENCE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SEQUENCES	SEQUENCE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	COMMENTS	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	ID	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	IS_SUPPORTED	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	IS_VERIFIED_BY	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	NAME	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	SUB_ID	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	SUB_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_CONFORMANCE	TYPE	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_IMPLEMENTATION_INFO	CHARACTER_VALUE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_IMPLEMENTATION_INFO	COMMENTS	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_ID	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_NAME	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_IMPLEMENTATION_INFO	INTEGER_VALUE	3	integer
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_BINDING_STYLE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_CONFORMANCE	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_IMPLEMENTATION	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_INTEGRITY	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_PROGRAMMING_LANGUAGE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_SOURCE	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_YEAR	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING	COMMENTS	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_ID	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING_PROFILES	SIZING_ID	1	integer
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING	SIZING_ID	1	integer
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING	SIZING_NAME	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	SQL_SIZING	SUPPORTED_VALUE	3	integer
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	INITIALLY_DEFERRED	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	IS_DEFERRABLE	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	TABLE_CATALOG	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	TABLE_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_CONSTRAINTS	TABLE_SCHEMA	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	IS_GRANTABLE	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_CATALOG	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_NAME	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_SCHEMA	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLE_PRIVILEGES	WITH_HIERARCHY	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	COMMIT_ACTION	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	IS_INSERTABLE_INTO	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	IS_TYPED	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	REFERENCE_GENERATION	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	SELF_REFERENCING_COLUMN_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	TABLE_TYPE	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	USER_DEFINED_TYPE_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	USER_DEFINED_TYPE_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TABLES	USER_DEFINED_TYPE_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	GROUP_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	SPECIFIC_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	TRANSFORM_TYPE	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	USER_DEFINED_TYPE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	USER_DEFINED_TYPE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSFORMS	USER_DEFINED_TYPE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_CATALOG	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_NAME	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_SCHEMA	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_CATALOG	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_NAME	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_SCHEMA	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_COLUMN	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_TABLE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_CONDITION	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_ORDER	8	integer
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_ORIENTATION	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_ROW	16	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_TABLE	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_ROW	15	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_TABLE	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_STATEMENT	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	ACTION_TIMING	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	CREATED	17	timestamp
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	EVENT_MANIPULATION	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	EVENT_OBJECT_CATALOG	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	EVENT_OBJECT_SCHEMA	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	EVENT_OBJECT_TABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGERS	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	OBJECT_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	OBJECT_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	OBJECT_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USAGE_PRIVILEGES	OBJECT_TYPE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	USER_DEFINED_TYPE_CATALOG	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	USER_DEFINED_TYPE_NAME	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPE_PRIVILEGES	USER_DEFINED_TYPE_SCHEMA	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	IS_FINAL	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	IS_INSTANTIABLE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	ORDERING_CATEGORY	9	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	ORDERING_FORM	8	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_CATALOG	10	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_NAME	12	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_SCHEMA	11	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	REF_DTD_IDENTIFIER	14	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	REFERENCE_TYPE	13	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	SOURCE_DTD_IDENTIFIER	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATEGORY	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	CHECK_OPTION	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	IS_UPDATABLE	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	TABLE_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	TABLE_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	TABLE_SCHEMA	2	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEWS	VIEW_DEFINITION	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	VIEW_CATALOG	1	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	VIEW_NAME	3	varchar
sql2003	cat_name	DEFINITION_SCHEMA	VIEW_TABLE_USAGE	VIEW_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	GRANTEE	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	IS_GRANTABLE	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMINISTRABLE_ROLE_AUTHORIZATIONS	ROLE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMIN_ROLE_AUTHS	GRANTEE	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMIN_ROLE_AUTHS	IS_GRANTABLE	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ADMIN_ROLE_AUTHS	ROLE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	APPLICABLE_ROLES	GRANTEE	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	APPLICABLE_ROLES	IS_GRANTABLE	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	APPLICABLE_ROLES	ROLE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ASSERTIONS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ASSERTIONS	INITIALLY_DEFERRED	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ASSERTIONS	IS_DEFERRABLE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ATTRIBUTE_DEFAULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ATTRIBUTE_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ATTRIBUTE_UDT_CATALOG	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ATTRIBUTE_UDT_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ATTRIBUTE_UDT_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	CHARACTER_MAXIMUM_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	CHARACTER_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	CHARACTER_SET_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	CHARACTER_SET_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	CHARACTER_SET_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	COLLATION_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	COLLATION_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	COLLATION_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	DATETIME_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	DTD_IDENTIFIER	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	INTERVAL_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	INTERVAL_TYPE	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	IS_DERIVED_REFERENCE_ATTRIBUTE	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	IS_NULLABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	MAXIMUM_CARDINALITY	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	NUMERIC_PRECISION	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	NUMERIC_PRECISION_RADIX	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	NUMERIC_SCALE	19	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	ORDINAL_POSITION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ATTRIBUTE_DEFAULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ATTRIBUTE_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ATT_UDT_CAT	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ATT_UDT_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ATT_UDT_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	CHARACTER_SET_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	CHAR_MAX_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	CHAR_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	CHAR_SET_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	CHAR_SET_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	COLLATION_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	COLLATION_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	COLLATION_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	SCOPE_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	SCOPE_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	SCOPE_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	DATETIME_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	DTD_IDENTIFIER	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	INTERVAL_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	INTERVAL_TYPE	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	IS_DERIVED_REF_ATT	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	IS_NULLABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	MAX_CARDINALITY	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	NUMERIC_PRECISION	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	NUMERIC_PREC_RADIX	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	NUMERIC_SCALE	19	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	ORDINAL_POSITION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	SCOPE_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	SCOPE_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	SCOPE_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	UDT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES_S	UDT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	UDT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ATTRIBUTES	UDT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CATALOG_NAME	CATALOG_NAME	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_REPERTOIRE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	CHARACTER_SET_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	DEFAULT_COLLATE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	FORM_OF_USE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS	NUMBER_OF_CHARACTERS	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	CHARACTER_SET_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	CHAR_REPERTOIRE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	CHAR_SET_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	CHAR_SET_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	DEF_COLLATE_CAT	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	DEF_COLLATE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	DEF_COLLATE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	FORM_OF_USE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHARACTER_SETS_S	NUMBER_OF_CHARS	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINT_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CHECK_CLAUSE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CHECK_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_COL_USAGE	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_COL_USAGE	DEPENDENT_COLUMN	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_COL_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_COL_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_COL_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	DOMAIN_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	DOMAIN_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	DOMAIN_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COL_DOMAIN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	CHAR_SET_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	CHAR_SET_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	COLLATION_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	COLLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_APPLIC_S	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATION_CHARACTER_SET_APPLICABILITY	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_DEFINITION	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_DICTIONARY	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	COLLATION_TYPE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS	PAD_ATTRIBUTE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_DEFN	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_DICT	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	COLLATION_TYPE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLLATIONS_S	PAD_ATTRIBUTE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	DEPENDENT_COLUMN	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_COLUMN_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	DOMAIN_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_DOMAIN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	COLUMN_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	IS_GRANTABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	PRIVILEGE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_MAXIMUM_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	CHARACTER_SET_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	COLLATION_CATALOG	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	COLLATION_NAME	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	COLLATION_SCHEMA	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_DEFAULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DATETIME_PRECISION	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DOMAIN_CATALOG	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DOMAIN_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DOMAIN_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	DTD_IDENTIFIER	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	GENERATION_EXPRESSION	43	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_CYCLE	41	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_GENERATION	36	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_INCREMENT	38	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_MAXIMUM	39	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_MINIMUM	40	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IDENTITY_START	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	INTERVAL_PRECISION	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	INTERVAL_TYPE	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IS_GENERATED	42	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IS_IDENTITY	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IS_NULLABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IS_SELF_REFERENCING	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	IS_UPDATABLE	44	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	MAXIMUM_CARDINALITY	32	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION	11	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_PRECISION_RADIX	12	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	NUMERIC_SCALE	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	ORDINAL_POSITION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	CHARACTER_SET_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	CHAR_MAX_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	CHAR_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	CHAR_SET_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	CHAR_SET_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	COLLATION_CATALOG	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	COLLATION_NAME	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	COLLATION_SCHEMA	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	COLUMN_DEFAULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	SCOPE_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	SCOPE_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	SCOPE_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DATETIME_PRECISION	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DOMAIN_CATALOG	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DOMAIN_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DOMAIN_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	DTD_IDENTIFIER	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	GENERATION_EXPR	43	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_CYCLE	41	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_GENERATION	36	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_INCREMENT	38	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_MAXIMUM	39	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_MINIMUM	40	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ID_START	37	unk
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	INTERVAL_PRECISION	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	INTERVAL_TYPE	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	IS_GENERATED	42	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	IS_IDENTITY	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	IS_NULLABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	IS_SELF_REF	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	IS_UPDATABLE	44	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	MAX_CARDINALITY	32	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	NUMERIC_PRECISION	11	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	NUMERIC_PREC_RADIX	12	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	NUMERIC_SCALE	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	ORDINAL_POSITION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	SCOPE_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	SCOPE_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	SCOPE_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	UDT_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	UDT_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS_S	UDT_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	UDT_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	UDT_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMNS	UDT_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	COLUMN_UDT_USAGE	UDT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_CATALOG	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	CONSTRAINT_SCHEMA	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_COLUMN_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	CONSTRAINT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTRAINT_TABLE_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	COLUMN_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	COLUMN_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_CATALOG	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	CONSTRAINT_SCHEMA	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_COL_USAGE	TABLE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_ROUT_USE_S	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	CONSTRAINT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	CONSTRAINT_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	CONSTRAINT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	CONSTR_TABLE_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	DTD_IDENTIFIER	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DATA_TYPE_PRIVILEGES	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTABLES	SUPERTABLE_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTABLES	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTABLES	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTABLES	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	SUPERTYPE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	UDT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DIRECT_SUPERTYPES	UDT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	DOMAIN_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	INITIALLY_DEFERRED	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAIN_CONSTRAINTS	IS_DEFERRABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	CHARACTER_MAXIMUM_LENGTH	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	CHARACTER_OCTET_LENGTH	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	CHARACTER_SET_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	COLLATION_CATALOG	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	COLLATION_NAME	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	COLLATION_SCHEMA	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DATA_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DATETIME_PRECISION	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_DEFAULT	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DOMAIN_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	DTD_IDENTIFIER	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	INTERVAL_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	INTERVAL_TYPE	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	MAXIMUM_CARDINALITY	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	NUMERIC_PRECISION_RADIX	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS	NUMERIC_SCALE	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	CHARACTER_SET_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	CHAR_MAX_LENGTH	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	CHAR_OCTET_LENGTH	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	CHAR_SET_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	CHAR_SET_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	COLLATION_CATALOG	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	COLLATION_NAME	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	COLLATION_SCHEMA	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DATA_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DATETIME_PRECISION	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DOMAIN_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DOMAIN_DEFAULT	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DOMAIN_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DOMAIN_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	DTD_IDENTIFIER	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	INTERVAL_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	INTERVAL_TYPE	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	MAX_CARDINALITY	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	NUMERIC_PRECISION	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	NUMERIC_PREC_RADIX	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	DOMAINS_S	NUMERIC_SCALE	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_MAXIMUM_LENGTH	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_OCTET_LENGTH	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	CHARACTER_SET_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_CATALOG	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLATION_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	COLLECTION_TYPE_IDENTIFIER	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	DATA_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	DATETIME_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	DTD_IDENTIFIER	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	INTERVAL_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	INTERVAL_TYPE	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	MAXIMUM_CARDINALITY	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_PRECISION	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_PRECISION_RADIX	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	NUMERIC_SCALE	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	CHARACTER_SET_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	CHAR_MAX_LENGTH	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	CHAR_OCTET_LENGTH	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	CHAR_SET_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	CHAR_SET_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	COLLATION_CATALOG	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	COLLATION_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	COLLATION_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	COLLECTION_TYPE_ID	5	unk
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_CATALOG	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_NAME	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	SCOPE_SCHEMA	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	DATA_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	DATETIME_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	DTD_IDENTIFIER	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	INTERVAL_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	INTERVAL_TYPE	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	MAX_CARDINALITY	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	NUMERIC_PRECISION	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	NUMERIC_PREC_RADIX	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	NUMERIC_SCALE	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	SCOPE_CATALOG	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	SCOPE_NAME	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	SCOPE_SCHEMA	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	UDT_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	UDT_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES_S	UDT_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ELEMENT_TYPES	UDT_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ENABLED_ROLES	ROLE_NAME	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	CHARACTER_MAXIMUM_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	CHARACTER_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	CHARACTER_SET_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	CHARACTER_SET_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	CHARACTER_SET_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	COLLATION_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	COLLATION_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	COLLATION_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	DATETIME_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	DTD_IDENTIFIER	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	FIELD_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	INTERVAL_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	INTERVAL_TYPE	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	MAXIMUM_CARDINALITY	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	NUMERIC_PRECISION	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	NUMERIC_PRECISION_RADIX	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	NUMERIC_SCALE	19	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	ORDINAL_POSITION	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	ROW_IDENTIFIER	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	CHARACTER_SET_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	CHAR_MAX_LENGTH	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	CHAR_OCTET_LENGTH	10	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	CHAR_SET_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	CHAR_SET_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	COLLATION_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	COLLATION_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	COLLATION_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	SCOPE_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	SCOPE_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	SCOPE_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	DATA_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	DATETIME_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	DTD_IDENTIFIER	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	FIELD_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	INTERVAL_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	INTERVAL_TYPE	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	MAX_CARDINALITY	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	NUMERIC_PRECISION	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	NUMERIC_PREC_RADIX	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	NUMERIC_SCALE	19	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	ORDINAL_POSITION	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	ROW_IDENTIFIER	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	SCOPE_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	SCOPE_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	SCOPE_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	UDT_CATALOG	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	UDT_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS_S	UDT_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	UDT_CATALOG	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	UDT_NAME	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	FIELDS	UDT_SCHEMA	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	INFORMATION_SCHEMA_CATALOG_NAME	CATALOG_NAME	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	ORDINAL_POSITION	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	POSITION_IN_UNIQUE_CONSTRAINT	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	ORDINAL_POSITION	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	POSITION_IN_UC	9	integer
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE_S	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	KEY_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	AS_LOCATOR	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	CHARACTER_MAXIMUM_LENGTH	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	CHARACTER_OCTET_LENGTH	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	CHARACTER_SET_CATALOG	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	CHARACTER_SET_NAME	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	CHARACTER_SET_SCHEMA	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	COLLATION_CATALOG	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	COLLATION_NAME	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	COLLATION_SCHEMA	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	DATA_TYPE	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	DATETIME_PRECISION	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	DTD_IDENTIFIER	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	FROM_SQL_SPECIFIC_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	INTERVAL_PRECISION	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	INTERVAL_TYPE	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	IS_RESULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	MAXIMUM_CARDINALITY	33	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	NUMERIC_PRECISION	21	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	NUMERIC_PRECISION_RADIX	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	NUMERIC_SCALE	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	ORDINAL_POSITION	4	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_MODE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_UDT_CATALOG	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_UDT_NAME	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	PARAMETER_UDT_SCHEMA	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SCOPE_CATALOG	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SCOPE_NAME	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SCOPE_SCHEMA	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATION_PARAMETERS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CHARACTER_MAXIMUM_LENGTH	12	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CHARACTER_OCTET_LENGTH	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CHARACTER_SET_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CHARACTER_SET_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CHARACTER_SET_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	COLLATION_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	COLLATION_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	COLLATION_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	CREATED	42	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	DATA_TYPE	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	DATETIME_PRECISION	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	DTD_IDENTIFIER	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	INTERVAL_PRECISION	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	INTERVAL_TYPE	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	IS_CONSTRUCTOR	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	IS_DETERMINISTIC	36	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	IS_NULL_CALL	38	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	IS_OVERRIDING	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	IS_STATIC	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	LAST_ALTERED	43	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	MAXIMUM_CARDINALITY	32	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	METHOD_LANGUAGE	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	METHOD_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	NUMERIC_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	NUMERIC_PRECISION_RADIX	21	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	NUMERIC_SCALE	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	PARAMETER_STYLE	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_AS_LOCATOR	45	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_CHAR_MAX_LENGTH	46	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_CHAR_OCTET_LENGTH	47	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_CHAR_SET_CATALOG	48	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_CHAR_SET_NAME	50	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_CHAR_SET_SCHEMA	49	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_COLLATION_CATALOG	51	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_COLLATION_NAME	53	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_COLLATION_SCHEMA	52	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_DATETIME_PRECISION	57	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_DTD_IDENTIFIER	67	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_FROM_DATA_TYPE	44	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_INTERVAL_PRECISION	59	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_INTERVAL_TYPE	58	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_MAX_CARDINALITY	66	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_NUMERIC_PRECISION	54	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_NUMERIC_RADIX	55	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_NUMERIC_SCALE	56	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_SCOPE_CATALOG	63	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_SCOPE_NAME	65	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_SCOPE_SCHEMA	64	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_TYPE_UDT_CATALOG	60	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_TYPE_UDT_NAME	62	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RESULT_CAST_TYPE_UDT_SCHEMA	61	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RETURN_UDT_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RETURN_UDT_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	RETURN_UDT_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SCOPE_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SCOPE_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SCOPE_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	SQL_DATA_ACCESS	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_CATALOG	39	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_NAME	41	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	TO_SQL_SPECIFIC_SCHEMA	40	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	UDT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	UDT_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECIFICATIONS	UDT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	AS_LOCATOR	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	CHARACTER_SET_NAME	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	CHAR_MAX_LENGTH	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	CHAR_OCTET_LENGTH	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	CHAR_SET_CATALOG	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	CHAR_SET_SCHEMA	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	COLLATION_CATALOG	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	COLLATION_NAME	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	COLLATION_SCHEMA	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	DATA_TYPE	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	DATETIME_PRECISION	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	DTD_IDENTIFIER	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	FROM_SQL_SPEC_CAT	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	FROM_SQL_SPEC_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	FROM_SQL_SPEC_SCH	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	INTERVAL_PRECISION	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	INTERVAL_TYPE	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	IS_RESULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	MAX_CARDINALITY	33	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	NUMERIC_PRECISION	21	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	NUMERIC_PREC_RADIX	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	NUMERIC_SCALE	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	ORDINAL_POSITION	4	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	PARAMETER_MODE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	PARAMETER_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	PARM_UDT_CATALOG	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	PARM_UDT_NAME	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	PARM_UDT_SCHEMA	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SCOPE_CATALOG	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SCOPE_NAME	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SCOPE_SCHEMA	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPEC_PARAMS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	AS_LOCATOR	42	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CHARACTER_SET_NAME	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CHAR_MAX_LENGTH	12	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CHAR_OCTET_LENGTH	13	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CHAR_SET_CATALOG	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CHAR_SET_SCHEMA	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	COLLATION_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	COLLATION_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	COLLATION_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	CREATED	43	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	DATA_TYPE	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	DATETIME_PRECISION	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	DTD_IDENTIFIER	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	INTERVAL_PRECISION	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	INTERVAL_TYPE	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	IS_CONSTRUCTOR	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	IS_DETERMINISTIC	36	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	IS_NULL_CALL	38	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	IS_OVERRIDING	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	IS_STATIC	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	LAST_ALTERED	44	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	MAX_CARDINALITY	32	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	METHOD_LANGUAGE	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	METHOD_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	NUMERIC_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	NUMERIC_PREC_RADIX	21	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	NUMERIC_SCALE	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	PARAMETER_STYLE	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_AS_LOCATOR	46	unk
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_CHAR_MAX_LENGTH	47	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_CHAR_OCT_LENGTH	48	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_CHAR_SET_CAT	49	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_CHAR_SET_NAME	51	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_CHAR_SET_SCHEMA	50	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_COLLATION_CAT	52	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_COLLATION_NAME	54	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_COLLATION_SCH	53	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_DATETIME_PREC	58	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_DTD_IDENTIFIER	68	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_FROM_DATA_TYPE	45	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_INTERVAL_PREC	60	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_INTERVAL_TYPE	59	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_MAX_CARDINALITY	67	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_NUMERIC_PREC	55	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_NUMERIC_RADIX	56	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_NUMERIC_SCALE	57	integer
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_SCOPE_CATALOG	64	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_SCOPE_NAME	66	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_SCOPE_SCHEMA	65	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_TYPE_UDT_CAT	61	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_TYPE_UDT_NAME	63	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RC_TYPE_UDT_SCHEMA	62	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RETURN_UDT_CATALOG	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RETURN_UDT_NAME	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	RETURN_UDT_SCHEMA	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SCOPE_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SCOPE_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SCOPE_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	SQL_DATA_ACCESS	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	TO_SQL_SPEC_CAT	39	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	TO_SQL_SPEC_NAME	41	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	TO_SQL_SPEC_SCHEMA	40	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	UDT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	UDT_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	METHOD_SPECS	UDT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	AS_LOCATOR	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_MAXIMUM_LENGTH	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_OCTET_LENGTH	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_CATALOG	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_NAME	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	CHARACTER_SET_SCHEMA	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	COLLATION_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	COLLATION_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	COLLATION_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	DATA_TYPE	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	DATETIME_PRECISION	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	DTD_IDENTIFIER	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	FROM_SQL_SPECIFIC_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_PRECISION	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	INTERVAL_TYPE	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	IS_RESULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	MAXIMUM_CARDINALITY	36	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_PRECISION_RADIX	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	NUMERIC_SCALE	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	ORDINAL_POSITION	4	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_MODE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	PARAMETER_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	AS_LOCATOR	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	CHARACTER_SET_NAME	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	CHAR_MAX_LENGTH	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	CHAR_OCTET_LENGTH	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	CHAR_SET_CATALOG	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	CHAR_SET_SCHEMA	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	COLLATION_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	COLLATION_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	COLLATION_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SCOPE_CATALOG	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SCOPE_NAME	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SCOPE_SCHEMA	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	DATA_TYPE	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	DATETIME_PRECISION	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	DTD_IDENTIFIER	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	FROM_SQL_SPEC_CAT	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	FROM_SQL_SPEC_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	FROM_SQL_SPEC_SCH	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	INTERVAL_PRECISION	29	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	INTERVAL_TYPE	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	IS_RESULT	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	MAX_CARDINALITY	36	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	NUMERIC_PRECISION	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	NUMERIC_PREC_RADIX	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	NUMERIC_SCALE	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	ORDINAL_POSITION	4	integer
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	PARAMETER_MODE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	PARAMETER_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SCOPE_CATALOG	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SCOPE_NAME	35	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SCOPE_SCHEMA	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	TO_SQL_SPEC_CAT	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	TO_SQL_SPEC_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	TO_SQL_SPEC_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	UDT_CATALOG	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	UDT_NAME	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS_S	UDT_SCHEMA	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_CATALOG	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	TO_SQL_SPECIFIC_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	UDT_CATALOG	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	UDT_NAME	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	PARAMETERS	UDT_SCHEMA	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	DELETE_RULE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	MATCH_OPTION	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	UNIQUE_CONSTR_CAT	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	UNIQUE_CONSTR_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	UNIQUE_CONSTR_SCH	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REF_CONSTRAINTS	UPDATE_RULE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	CHARACTER_MAXIMUM_LENGTH	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	CHARACTER_OCTET_LENGTH	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	CHARACTER_SET_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	CHARACTER_SET_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	CHARACTER_SET_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	COLLATION_CATALOG	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	COLLATION_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	COLLATION_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	DATA_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	DATETIME_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	DTD_IDENTIFIER	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	INTERVAL_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	INTERVAL_TYPE	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	MAXIMUM_CARDINALITY	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	NUMERIC_PRECISION	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	NUMERIC_PRECISION_RADIX	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	NUMERIC_SCALE	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	REFERENCE_TYPE_IDENTIFIER	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	CHARACTER_SET_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	CHAR_MAX_LENGTH	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	CHAR_OCTET_LENGTH	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	CHAR_SET_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	CHAR_SET_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	COLLATION_CATALOG	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	COLLATION_NAME	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	COLLATION_SCHEMA	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	SCOPE_CATALOG	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	SCOPE_NAME	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	SCOPE_SCHEMA	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	DATA_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	DATETIME_PRECISION	18	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	DTD_IDENTIFIER	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	INTERVAL_PRECISION	20	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	INTERVAL_TYPE	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	MAX_CARDINALITY	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	NUMERIC_PRECISION	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	NUMERIC_PREC_RADIX	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	NUMERIC_SCALE	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	OBJECT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	OBJECT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	OBJECT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	OBJECT_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	REFERENCE_TYPE_ID	5	unk
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	SCOPE_CATALOG	24	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	SCOPE_NAME	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	SCOPE_SCHEMA	25	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	UDT_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	UDT_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES_S	UDT_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	UDT_CATALOG	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	UDT_NAME	23	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENCED_TYPES	UDT_SCHEMA	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	DELETE_RULE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	MATCH_OPTION	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UNIQUE_CONSTRAINT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	REFERENTIAL_CONSTRAINTS	UPDATE_RULE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	COLUMN_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	IS_GRANTABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	PRIVILEGE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_COLUMN_GRANTS	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	IS_GRANTABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	SPECIFIC_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUT_GRANTS	SPECIFIC_SCHEMA	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	IS_GRANTABLE	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	PRIVILEGE_TYPE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	ROUTINE_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_ROUTINE_GRANTS	SPECIFIC_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	IS_GRANTABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_GRANTS	WITH_HIERARCHY	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	IS_GRANTABLE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	SPECIFIC_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	SPECIFIC_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	SPECIFIC_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_TABLE_METHOD_GRANTS	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	IS_GRANTABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_UDT_GRANTS	UDT_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	IS_GRANTABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	OBJECT_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROLE_USAGE_GRANTS	PRIVILEGE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	IS_GRANTABLE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	SPECIFIC_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	SPECIFIC_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	SPECIFIC_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROL_TAB_METH_GRNTS	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	COLUMN_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COLUMN_USAGE	TABLE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	COLUMN_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	TABLE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_COL_USAGE	TABLE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	IS_GRANTABLE	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	PRIVILEGE_TYPE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	ROUTINE_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_PRIVILEGES	SPECIFIC_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_ROUTINE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	AS_LOCATOR	54	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CHARACTER_MAXIMUM_LENGTH	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CHARACTER_OCTET_LENGTH	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CHARACTER_SET_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	COLLATION_CATALOG	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	COLLATION_NAME	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	COLLATION_SCHEMA	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	CREATED	55	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	DATA_TYPE	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	DATETIME_PRECISION	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	DTD_IDENTIFIER	36	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_SEQUENCE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_LANGUAGE	40	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	EXTERNAL_NAME	39	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	INTERVAL_PRECISION	28	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	INTERVAL_TYPE	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	IS_DETERMINISTIC	42	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	IS_IMPLICITLY_INVOCABLE	49	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	IS_NULL_CALL	44	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	IS_UDT_DEPENDENT	58	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	IS_USER_DEFINED_CAST	48	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	LAST_ALTERED	56	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	MAX_DYNAMIC_RESULT_SETS	47	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	MAXIMUM_CARDINALITY	35	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	MODULE_CATALOG	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	MODULE_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	MODULE_SCHEMA	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	NEW_SAVEPOINT_LEVEL	57	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	NUMERIC_PRECISION_RADIX	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	NUMERIC_SCALE	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	PARAMETER_STYLE	41	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_AS_LOCATOR	60	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHARACTER_SET_NAME	65	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_MAX_LENGTH	61	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_OCTET_LENGTH	62	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_SET_CATALOG	63	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_CHAR_SET_SCHEMA	64	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_CATALOG	66	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_NAME	68	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_COLLATION_SCHEMA	67	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DATETIME_PRECISION	72	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_DTD_IDENTIFIER	82	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_FROM_DATA_TYPE	59	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_INTERVAL_PRECISION	74	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_INTERVAL_TYPE	73	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_MAX_CARDINALITY	81	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_PRECISION	69	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_RADIX	70	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_NUMERIC_SCALE	71	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_CATALOG	78	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_NAME	80	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_SCOPE_SCHEMA	79	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_CATALOG	75	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_NAME	77	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	RESULT_CAST_TYPE_UDT_SCHEMA	76	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_BODY	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_DEFINITION	38	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	ROUTINE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	AS_LOCATOR	54	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CHARACTER_SET_NAME	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CHAR_MAX_LENGTH	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CHAR_OCTET_LENGTH	16	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CHAR_SET_CATALOG	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CHAR_SET_SCHEMA	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SCHEMA_LEVEL_ROUTINE	46	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	COLLATION_CATALOG	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	COLLATION_NAME	22	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	COLLATION_SCHEMA	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SCOPE_CATALOG	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SCOPE_NAME	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SCOPE_SCHEMA	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	CREATED	55	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	DATA_TYPE	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	DATETIME_PRECISION	26	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	DTD_IDENTIFIER	36	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SECURITY_TYPE	50	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	EXTERNAL_LANGUAGE	40	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	EXTERNAL_NAME	39	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	INTERVAL_PRECISION	28	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	INTERVAL_TYPE	27	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	IS_DETERMINISTIC	42	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	IS_IMP_INVOCABLE	49	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	IS_NULL_CALL	44	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	IS_UDT_DEPENDENT	58	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	IS_USER_DEFND_CAST	48	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	LAST_ALTERED	56	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	MAX_CARDINALITY	35	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	MAX_DYN_RESLT_SETS	47	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	MODULE_CATALOG	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	MODULE_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	MODULE_SCHEMA	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	NEW_SAVEPOINT_LVL	57	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	NUMERIC_PRECISION	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	NUMERIC_PREC_RADIX	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	NUMERIC_SCALE	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	PARAMETER_STYLE	41	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SQL_DATA_ACCESS	43	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	SQL_PATH	45	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_AS_LOCATOR	60	unk
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_CHAR_MAX_LENGTH	61	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_CHAR_OCT_LENGTH	62	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_CHAR_SET_CAT	63	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_CHAR_SET_NAME	65	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_CHAR_SET_SCHEMA	64	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_COLLATION_CAT	66	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_COLLATION_NAME	68	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_COLLATION_SCH	67	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_DATETIME_PREC	72	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_DTD_IDENTIFIER	82	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_FROM_DATA_TYPE	59	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_INTERVAL_PREC	74	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_INTERVAL_TYPE	73	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_MAX_CARDINALITY	81	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_NUMERIC_RADIX	70	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_NUMERIC_SCALE	71	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_NUM_PREC	69	integer
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_SCOPE_CATALOG	78	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_SCOPE_NAME	80	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_SCOPE_SCHEMA	79	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_TYPE_UDT_CAT	75	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_TYPE_UDT_NAME	77	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	RC_TYPE_UDT_SCHEMA	76	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_BODY	37	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_DEFINITION	38	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	ROUTINE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SCH_LEVEL_ROUTINE	46	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SCOPE_CATALOG	32	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SCOPE_NAME	34	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SCOPE_SCHEMA	33	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SECURITY_TYPE	50	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SQL_DATA_ACCESS	43	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	SQL_PATH	45	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TO_SQL_SPEC_CAT	51	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TO_SQL_SPEC_NAME	53	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TO_SQL_SPEC_SCHEMA	52	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TYPE_UDT_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TYPE_UDT_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	TYPE_UDT_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	UDT_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	UDT_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES_S	UDT_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_CATALOG	51	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_NAME	53	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TO_SQL_SPECIFIC_SCHEMA	52	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_CATALOG	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_NAME	31	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	TYPE_UDT_SCHEMA	30	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	UDT_CATALOG	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	UDT_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINES	UDT_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUTINE_TABLE_USAGE	TABLE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_ROUT_USAGE_S	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SEQUENCE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_SEQ_USAGE_S	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	ROUTINE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	ROUTINE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	ROUTINE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	SPECIFIC_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	SPECIFIC_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	SPECIFIC_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	TABLE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	ROUT_TABLE_USAGE	TABLE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	CATALOG_NAME	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	DEFAULT_CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	CATALOG_NAME	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	SCHEMA_OWNER	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	DEF_CHAR_SET_CAT	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	DEF_CHAR_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	DEF_CHAR_SET_SCH	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA	SQL_PATH	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	SCHEMA_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	SCHEMA_OWNER	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SCHEMATA_S	SQL_PATH	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	CYCLE_OPTION	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	DATA_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	INCREMENT	10	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	MAXIMUM_VALUE	8	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	MINIMUM_VALUE	9	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_PRECISION_RADIX	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	NUMERIC_SCALE	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	CYCLE_OPTION	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	DATA_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES	SEQUENCE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	INCREMENT	10	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	MAXIMUM_VALUE	8	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	MINIMUM_VALUE	9	unk
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	NUMERIC_PRECISION	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	NUMERIC_PREC_RADIX	6	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	NUMERIC_SCALE	7	integer
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	SEQUENCE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	SEQUENCE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SEQUENCES_S	SEQUENCE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	COMMENTS	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	FEATURE_ID	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	FEATURE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	IS_SUPPORTED	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	IS_VERIFIED_BY	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	SUB_FEATURE_ID	3	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_FEATURES	SUB_FEATURE_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	CHARACTER_VALUE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	COMMENTS	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_ID	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	IMPLEMENTATION_INFO_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPLEMENTATION_INFO	INTEGER_VALUE	3	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPL_INFO	CHARACTER_VALUE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPL_INFO	COMMENTS	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPL_INFO	IMPL_INFO_ID	1	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPL_INFO	IMPL_INFO_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_IMPL_INFO	INTEGER_VALUE	3	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	BINDING_STYLE	6	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	CONFORMANCE	3	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	IMPLEMENTATION	5	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	INTEGRITY	4	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	PROGRAMMING_LANG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_BINDING_STYLE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_CONFORMANCE	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_IMPLEMENTATION	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_INTEGRITY	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_PROGRAMMING_LANGUAGE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_SOURCE	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES	SQL_LANGUAGE_YEAR	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	SOURCE	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_LANGUAGES_S	SQL_LANGUAGE_YEAR	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PACKAGES	COMMENTS	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PACKAGES	FEATURE_ID	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PACKAGES	FEATURE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PACKAGES	IS_SUPPORTED	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PACKAGES	IS_VERIFIED_BY	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PARTS	COMMENTS	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PARTS	FEATURE_ID	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PARTS	FEATURE_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PARTS	IS_SUPPORTED	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_PARTS	IS_VERIFIED_BY	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING	COMMENTS	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	COMMENTS	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_ID	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	PROFILE_NAME	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	REQUIRED_VALUE	5	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	SIZING_ID	1	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFILES	SIZING_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	COMMENTS	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	PROFILE_ID	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	PROFILE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	PROFILE_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	REQUIRED_VALUE	4	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	REQUIRED_VALUE	9	unk
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	SIZING_ID	1	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	SIZING_ID	5	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	SIZING_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING_PROFS	SIZING_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING	SIZING_ID	1	integer
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING	SIZING_NAME	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	SQL_SIZING	SUPPORTED_VALUE	3	unk
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	CONSTRAINT_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	INITIALLY_DEFERRED	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	IS_DEFERRABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_CONSTRAINTS	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	IS_GRANTABLE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	SPECIFIC_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	IS_GRANTABLE	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	SPECIFIC_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	SPECIFIC_NAME	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	SPECIFIC_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_METHOD_PRIVS	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	TABLE_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLE_PRIVILEGES	WITH_HIERARCHY	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	COMMIT_ACTION	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	IS_INSERTABLE_INTO	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	IS_TYPED	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	REFERENCE_GENERATION	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	COMMIT_ACTION	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	SELF_REFERENCING_COLUMN_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	IS_INSERTABLE_INTO	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	IS_TYPED	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	REF_GENERATION	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	SELF_REF_COL_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	TABLE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	TABLE_TYPE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	UDT_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	UDT_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES_S	UDT_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	TABLE_TYPE	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TABLES	USER_DEFINED_TYPE_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	GROUP_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	TRANSFORM_TYPE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	UDT_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSFORMS	UDT_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	SOURCE_CHARACTER_SET_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	SRC_CHAR_SET_CAT	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	SRC_CHAR_SET_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	SRC_CHAR_SET_SCH	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TGT_CHAR_SET_CAT	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TGT_CHAR_SET_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TGT_CHAR_SET_SCH	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANS_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANSLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANSLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANS_SRC_CATALOG	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANS_SRC_NAME	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS_S	TRANS_SRC_SCHEMA	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_CATALOG	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_NAME	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TARGET_CHARACTER_SET_SCHEMA	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_CATALOG	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_NAME	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRANSLATIONS	TRANSLATION_SOURCE_SCHEMA	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_COLUMN_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_COLUMN_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_COLUMN	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	EVENT_OBJECT_TABLE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERED_UPDATE_COLUMNS	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_ROUTINE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_CONDITION	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_ORDER	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_ORIENTATION	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_ROW	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_NEW_TABLE	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_ROW	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_REFERENCE_OLD_TABLE	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_STATEMENT	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	ACTION_TIMING	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	CREATED	17	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_SEQUENCE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	EVENT_MANIPULATION	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_CATALOG	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_SCHEMA	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	EVENT_OBJECT_TABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACTION_CONDITION	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACTION_ORDER	8	integer
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACTION_ORIENTATION	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACTION_STATEMENT	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACTION_TIMING	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACT_REF_NEW_ROW	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACT_REF_NEW_TABLE	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACT_REF_OLD_ROW	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	ACT_REF_OLD_TABLE	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	CREATED	17	timestamp
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	EVENT_MANIPULATION	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	EVENT_OBJECT_CAT	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	EVENT_OBJECT_SCH	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	EVENT_OBJECT_TABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS_S	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGERS	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIGGER_TABLE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_ROUT_USAGE_S	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	SEQUENCE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	SEQUENCE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	SEQUENCE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_SEQ_USAGE_S	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_TABLE_USAGE	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	EVENT_OBJECT_CAT	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	EVENT_OBJECT_COL	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	EVENT_OBJECT_SCH	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	EVENT_OBJECT_TABLE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	TRIGGER_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	TRIGGER_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	TRIG_UPDATE_COLS	TRIGGER_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	IS_GRANTABLE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	PRIVILEGE_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_PRIVILEGES	UDT_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	CHARACTER_SET_NAME	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	CHAR_MAX_LENGTH	11	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	CHAR_OCTET_LENGTH	17	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	CHAR_SET_CATALOG	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	CHAR_SET_SCHEMA	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	COLLATION_CATALOG	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	COLLATION_NAME	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	COLLATION_SCHEMA	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	DATA_TYPE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	DATETIME_PRECISION	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	INTERVAL_PRECISION	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	INTERVAL_TYPE	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	IS_FINAL	14	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	IS_INSTANTIABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	NUMERIC_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	NUMERIC_PREC_RADIX	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	NUMERIC_SCALE	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	ORDERING_CATEGORY	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	ORDERING_FORM	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	ORDERING_ROUT_CAT	15	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	ORDERING_ROUT_NAME	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	ORDERING_ROUT_SCH	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	REF_DTD_IDENTIFIER	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	REFERENCE_TYPE	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	SOURCE_DTD_ID	28	unk
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	UDT_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	UDT_CATEGORY	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	UDT_NAME	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	UDT_S	UDT_SCHEMA	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	GRANTEE	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	GRANTOR	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	IS_GRANTABLE	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_CATALOG	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_NAME	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_SCHEMA	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	OBJECT_TYPE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USAGE_PRIVILEGES	PRIVILEGE_TYPE	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_MAXIMUM_LENGTH	14	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_OCTET_LENGTH	15	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_CATALOG	16	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_NAME	18	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	CHARACTER_SET_SCHEMA	17	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_CATALOG	19	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_NAME	21	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	COLLATION_SCHEMA	20	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DATA_TYPE	13	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	DATETIME_PRECISION	25	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	INTERVAL_PRECISION	27	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	INTERVAL_TYPE	26	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	IS_FINAL	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	IS_INSTANTIABLE	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_PRECISION	22	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_PRECISION_RADIX	23	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	NUMERIC_SCALE	24	integer
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_CATEGORY	8	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_FORM	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_CATALOG	9	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_NAME	11	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	ORDERING_ROUTINE_SCHEMA	10	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	REF_DTD_IDENTIFIER	29	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	REFERENCE_TYPE	12	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	SOURCE_DTD_IDENTIFIER	28	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_CATEGORY	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	USER_DEFINED_TYPES	USER_DEFINED_TYPE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	COLUMN_NAME	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_COLUMN_USAGE	VIEW_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	SPECIFIC_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_ROUTINE_USAGE	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	CHECK_OPTION	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	INSERTABLE_INTO	7	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	IS_UPDATABLE	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	TABLE_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	TABLE_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	TABLE_SCHEMA	2	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEWS	VIEW_DEFINITION	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_CATALOG	4	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_NAME	6	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	TABLE_SCHEMA	5	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_CATALOG	1	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_NAME	3	varchar
sql2003	cat_name	INFORMATION_SCHEMA	VIEW_TABLE_USAGE	VIEW_SCHEMA	2	varchar
\.

ALTER TABLE ONLY schemata.data_types
    ADD CONSTRAINT data_types_pkey PRIMARY KEY (sql_type);

ALTER TABLE ONLY schemata.db_engines_ranking
    ADD CONSTRAINT db_engines_ranking_pkey PRIMARY KEY (engine_name);

ALTER TABLE ONLY schemata.engines
    ADD CONSTRAINT engines_pkey PRIMARY KEY (engine_name);