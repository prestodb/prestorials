# Example of connecting to two MySQL instances

## Start a Presto cluster
Open a terminal, and change into this directory ($REPO_ROOT/docker-compose/mysql).

    docker compose -f docker-compose.yaml up
You can monitor the logs of different containers in the terminal and Docker Desktop UI.

## Run Presto CLI
    docker exec -it coordinator /opt/presto-cli --server http://127.0.0.1:8080

## Stop and delete the cluster
    ctrl-c
    docker compose -f docker-compose.yaml down


## Commands and Outputs
```
dind26:~/gh/prestorials/docker-compose# docker compose ps
NAME          IMAGE                   COMMAND                  SERVICE       CREATED       STATUS                 PORTS
coordinator   prestodb/presto:0.286   "/opt/entrypoint.sh"     coordinator   9 hours ago   Up 9 hours (healthy)   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp
mysql_1       mysql:8.0.37            "docker-entrypoint.s…"   mysql_1       9 hours ago   Up 9 hours             3306/tcp, 33060/tcp
mysql_2       mysql:8.0.37            "docker-entrypoint.s…"   mysql_2       9 hours ago   Up 9 hours             3306/tcp, 33060/tcp
worker_1      prestodb/presto:0.286   "/opt/entrypoint.sh"     worker_1      9 hours ago   Up 9 hours             8080/tcp
worker_2      prestodb/presto:0.286   "/opt/entrypoint.sh"     worker_2      9 hours ago   Up 9 hours             8080/tcp
dind26:~/gh/prestorials/docker-compose# docker exec -it coordinator /opt/presto-cli --server http://127.0.0.1:8080
presto> show catalogs;
 Catalog
---------
 jmx
 mysql_1
 mysql_2
 system
 tpcds
 tpch
(6 rows)

Query 20240507_185018_00002_i47ge, FINISHED, 2 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 178ms, server-side: 157ms] [0 rows, 0B] [0 rows/s, 0B/s]

presto> show schemas in mysql_1;
       Schema
--------------------
 information_schema
 performance_schema
 testdb_1
(3 rows)

Query 20240507_185041_00003_i47ge, FINISHED, 3 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 197ms, server-side: 186ms] [3 rows, 59B] [16 rows/s, 317B/s]

presto> show schemas in mysql_2;
       Schema
--------------------
 information_schema
 performance_schema
 testdb_2
(3 rows)

Query 20240507_185059_00004_i47ge, FINISHED, 3 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 163ms, server-side: 152ms] [3 rows, 59B] [19 rows/s, 388B/s]

presto> use mysql_1.testdb_1;
USE
presto:testdb_1> show tables in tpch.sf1;
  Table
----------
 customer
 lineitem
 nation
 orders
 part
 partsupp
 region
 supplier
(8 rows)

Query 20240507_185407_00006_i47ge, FINISHED, 3 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 286ms, server-side: 280ms] [8 rows, 158B] [28 rows/s, 564B/s]

presto:testdb_1> create table customer as select * from tpch.sf1.customer limit 100;
CREATE TABLE: 100 rows

Query 20240507_185519_00007_i47ge, FINISHED, 3 nodes
Splits: 84 total, 75 done (89.29%)
[Latency: client-side: 0:03, server-side: 0:03] [128K rows, 0B] [47.8K rows/s, 0B/s]

presto:testdb_1> show tables in mysql_1.testdb_1;
  Table
----------
 customer
(1 row)

Query 20240507_185538_00008_i47ge, FINISHED, 3 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 172ms, server-side: 167ms] [1 rows, 26B] [5 rows/s, 155B/s]

presto:testdb_1> select * from customer limit 5;
 custkey |        name        |               address               | nationkey |      phone      | acctbal | mktsegment |                                                    comment
---------+--------------------+-------------------------------------+-----------+-----------------+---------+------------+----------------------------------------------------------------------------------------------------------------
  117176 | Customer#000117176 | iR5d6qVKVnkHfX42,WXDEOyHqa4 D       |         4 | 14-855-663-6049 | 1490.81 | HOUSEHOLD  | slyly. quickly final asymptotes nag furiously slyly regular requests. pending accounts against the pending req
  117177 | Customer#000117177 | CLqdOfPgJ8sq12IR431J1sHelTNKS5 llDN |        22 | 32-892-903-8189 | 6959.11 | AUTOMOBILE | old ideas sleep blithely alongside of the ironic, even packages. bold deposits wake alo
  117178 | Customer#000117178 | F9BwgSfJ2wYN5,F467bu3,7PSKoWsp frKW |         2 | 12-243-351-4764 | 7724.29 | BUILDING   | ular deposits. furiously regular asymptotes haggle above the packages. deposits haggle b
  117179 | Customer#000117179 | U0L4YKNUsFsDUccOBDNfb               |        13 | 23-257-425-2856 | 9176.78 | HOUSEHOLD  | use bold, regular dependencies. slyly silent accounts wake against the quickly fina
  117180 | Customer#000117180 | gHr8jqZYvbQJbcTigRs7YNGGDm1hVCH3Qb  |        24 | 34-293-502-2416 | 1167.34 | AUTOMOBILE | he carefully permanent packages. special deposits
(5 rows)

Query 20240507_185554_00009_i47ge, FINISHED, 2 nodes
Splits: 18 total, 18 done (100.00%)
[Latency: client-side: 204ms, server-side: 195ms] [100 rows, 0B] [512 rows/s, 0B/s]

presto:testdb_1> use mysql_2.testdb_2;
USE
presto:testdb_2> create table orders as select * from tpch.sf1.orders limit 1000;
CREATE TABLE: 1000 rows

Query 20240507_185655_00013_i47ge, FINISHED, 3 nodes
Splits: 84 total, 67 done (79.76%)
[Latency: client-side: 0:02, server-side: 0:02] [191K rows, 0B] [101K rows/s, 0B/s]

presto:testdb_2> show tables in mysql_2.testdb_2;
 Table
--------
 orders
(1 row)

Query 20240507_185715_00014_i47ge, FINISHED, 3 nodes
Splits: 36 total, 36 done (100.00%)
[Latency: client-side: 151ms, server-side: 146ms] [1 rows, 24B] [6 rows/s, 164B/s]

presto:testdb_2> select * from orders limit 10;
 orderkey | custkey | orderstatus | totalprice | orderdate  |  orderpriority  |      clerk      | shippriority |                                    comment
----------+---------+-------------+------------+------------+-----------------+-----------------+--------------+-------------------------------------------------------------------------------
  2624995 |   66061 | O           |   61712.62 | 1996-06-23 | 3-MEDIUM        | Clerk#000000074 |            0 | ding deposits wake. blithely ir
  2624996 |  108433 | O           |   37472.99 | 1997-09-08 | 2-HIGH          | Clerk#000000568 |            0 | ely stealthy accounts. furiously unusual pinto beans alongside of the slyly r
  2624997 |   76349 | F           |  201675.73 | 1993-04-01 | 1-URGENT        | Clerk#000000152 |            0 | tions. foxes are carefully according
  2624998 |   83758 | F           |  237126.34 | 1992-12-03 | 4-NOT SPECIFIED | Clerk#000000871 |            0 | es use slyly slyly express packages. special pinto beans n
  2624999 |   96457 | F           |  202474.33 | 1992-04-17 | 2-HIGH          | Clerk#000000732 |            0 | ntil the thin hockey players. brave, unusual tithes accord
  2625024 |   91769 | F           |  149695.97 | 1993-10-03 | 3-MEDIUM        | Clerk#000000148 |            0 | es might sleep furiously furiously regular deposits. pending
  2625025 |   54925 | F           |  124045.77 | 1993-02-22 | 3-MEDIUM        | Clerk#000000101 |            0 | tegrate furiously along the carefully final dependencies. thin ideas h
  2625026 |  149776 | O           |   77502.33 | 1996-09-02 | 3-MEDIUM        | Clerk#000000454 |            0 | all have to detect across the special, blithe package
  2625027 |  103403 | F           |  194859.95 | 1993-07-20 | 2-HIGH          | Clerk#000000030 |            0 | c packages are. permanently unusua
  2625028 |  134899 | F           |  147262.29 | 1992-06-11 | 1-URGENT        | Clerk#000000962 |            0 | ly across the braids. slyly special dependencies beyond th
(10 rows)

Query 20240507_185725_00015_i47ge, FINISHED, 1 node
Splits: 18 total, 18 done (100.00%)
[Latency: client-side: 146ms, server-side: 139ms] [1000 rows, 0B] [7.19K rows/s, 0B/s]

presto:testdb_2> select t1.name, t2.totalprice, t2.orderdate from mysql_1.testdb_1.customer as t1, mysql_2.testdb_2.orders as t2 where t1.custkey = t2.custkey;
        name        | totalprice | orderdate
--------------------+------------+------------
 Customer#000117223 |  122055.57 | 1998-03-01
(1 row)

Query 20240507_190008_00016_i47ge, FINISHED, 2 nodes
Splits: 114 total, 114 done (100.00%)
[Latency: client-side: 483ms, server-side: 461ms] [1.1K rows, 0B] [2.39K rows/s, 0B/s]

presto:testdb_2>
```
