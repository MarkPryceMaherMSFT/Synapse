CREATE LOGIN perftest WITH PASSWORD = ''; -- run on master

-- switch to normal DW
 CREATE USER perftest FOR LOGIN perftest;
 GRANT control TO perftest;

CREATE WORKLOAD GROUP smallresource
   WITH ( 
       MIN_PERCENTAGE_RESOURCE = 0
       ,CAP_PERCENTAGE_RESOURCE = 100
       ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
);
ALTER WORKLOAD GROUP smallresource WITH
(   MIN_PERCENTAGE_RESOURCE = 0
       ,CAP_PERCENTAGE_RESOURCE = 100
       ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100 );

CREATE WORKLOAD CLASSIFIER [wgsmallresource]
   WITH (
	     WORKLOAD_GROUP = 'smallresource'
       ,MEMBERNAME = 'perftest'
   );
CREATE WORKLOAD CLASSIFIER [wgsmallresource5]
   WITH (
	     WORKLOAD_GROUP = 'smallresource'
       ,MEMBERNAME = 'power_range'
   );


   CREATE WORKLOAD GROUP thing2
   WITH ( 
       MIN_PERCENTAGE_RESOURCE = 0
       ,CAP_PERCENTAGE_RESOURCE = 100
       ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
);