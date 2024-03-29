
DROP VIEW IF EXISTS "DATA_WAREHOUSE"."FACT_VST_VISITORS_TRANS";
CREATE  VIEW "DATA_WAREHOUSE"."FACT_VST_VISITORS_TRANS"  AS 
	WITH "MIV" AS 
	( 
		SELECT 
			  "NHL_SRC"."CUSTOMERS_HKEY" AS "CUSTOMERS_HKEY"
			, "NHL_SRC"."SHOPS_HKEY" AS "SHOPS_HKEY"
			, DATE_TRUNC('DAY',"NHL_SRC"."SHOP_ENTER_TIME") AS "TRANSACTION_DAY"
			, avg(timediff(minutes,"NHL_SRC"."SHOP_ENTER_TIME","NHL_SRC"."SHOP_EXIT_TIME")) AS "TRANSACTION_DURATION"
			, avg(timediff(minutes,"NHL_SRC"."PARKING_LOT_ENTER_TIME","NHL_SRC"."PARKING_LOT_EXIT_TIME")) AS "SECONDARY_TRANSACTION_DURATION"
			, count(distinct "NHL_SRC"."VISIT_ID") AS "NUMBER_OF_TRANSACTIONS"
			, SUM("NHL_SRC"."NUMBER_OF_PRODUCT_INTERACTIONS") AS "SUM_OF_NUMBER_OF_PRODUCT_INTERACTIONS"
			, SUM("NHL_SRC"."NUMBER_OF_STAFF_INTERACTIONS") AS "SUM_OF_NUMBER_OF_STAFF_INTERACTIONS"
			, SUM("NHL_SRC"."NUMBER_OF_SERVICE_REQUESTS") AS "SUM_OF_NUMBER_OF_SERVICE_REQUESTS"
			, AVG("NHL_SRC"."NUMBER_OF_PRODUCT_INTERACTIONS") AS "AVG_NUMBER_OF_PRODUCT_INTERACTIONS"
			, AVG("NHL_SRC"."NUMBER_OF_STAFF_INTERACTIONS") AS "AVG_NUMBER_OF_STAFF_INTERACTIONS"
			, AVG("NHL_SRC"."NUMBER_OF_SERVICE_REQUESTS") AS "AVG_NUMBER_OF_SERVICE_REQUESTS"
		FROM "VS_DEMO_DV_SNW_FL"."NHL_VST_VISITORS" "NHL_SRC"
		GROUP BY  "NHL_SRC"."CUSTOMERS_HKEY",  "NHL_SRC"."SHOPS_HKEY",  DATE_TRUNC('DAY',"NHL_SRC"."SHOP_ENTER_TIME")
	)
	SELECT 
		  UPPER(SHA1_HEX(UPPER(REPLACE(COALESCE(TRIM( "MIV"."CUSTOMERS_HKEY"),'~'),'\#','\\' || '\#'))|| '\#' || UPPER(REPLACE(COALESCE(TRIM( DATE_TRUNC('DAY',
			"MIV"."TRANSACTION_DAY")),'~'),'\#','\\' || '\#'))|| '\#' )) AS "DIM_CUSTOMERS_HKEY"
		, UPPER(SHA1_HEX(UPPER(REPLACE(COALESCE(TRIM( "MIV"."SHOPS_HKEY"),'~'),'\#','\\' || '\#'))|| '\#' || UPPER(REPLACE(COALESCE(TRIM( DATE_TRUNC('DAY',
			"MIV"."TRANSACTION_DAY")),'~'),'\#','\\' || '\#'))|| '\#' )) AS "DIM_SHOPS_HKEY"
		, "MIV"."TRANSACTION_DAY" AS "TRANSACTION_DAY"
		, "MIV"."TRANSACTION_DURATION" AS "TRANSACTION_DURATION"
		, "MIV"."SECONDARY_TRANSACTION_DURATION" AS "SECONDARY_TRANSACTION_DURATION"
		, "MIV"."NUMBER_OF_TRANSACTIONS" AS "NUMBER_OF_TRANSACTIONS"
		, "MIV"."SUM_OF_NUMBER_OF_PRODUCT_INTERACTIONS" AS "SUM_OF_NUMBER_OF_PRODUCT_INTERACTIONS"
		, "MIV"."SUM_OF_NUMBER_OF_STAFF_INTERACTIONS" AS "SUM_OF_NUMBER_OF_STAFF_INTERACTIONS"
		, "MIV"."SUM_OF_NUMBER_OF_SERVICE_REQUESTS" AS "SUM_OF_NUMBER_OF_SERVICE_REQUESTS"
		, "MIV"."AVG_NUMBER_OF_PRODUCT_INTERACTIONS" AS "AVG_NUMBER_OF_PRODUCT_INTERACTIONS"
		, "MIV"."AVG_NUMBER_OF_STAFF_INTERACTIONS" AS "AVG_NUMBER_OF_STAFF_INTERACTIONS"
		, "MIV"."AVG_NUMBER_OF_SERVICE_REQUESTS" AS "AVG_NUMBER_OF_SERVICE_REQUESTS"
	FROM "MIV" "MIV"
	;

 