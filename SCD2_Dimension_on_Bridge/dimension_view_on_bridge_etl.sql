CREATE  VIEW "INFORMATION_MARTS"."DIM_SHOP_LOCATION_EMPLOYEERANGE"  AS 
	WITH "DVO_BASE1" AS 
	( 
		SELECT 
			  "DVO_SRC1"."EMPLOYEE_RANGE_HKEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_SRC1"."NUMBER_OF_EMPLOYEES_BK" AS "NUMBER_OF_EMPLOYEES_BK"
		FROM "VS_DEMO_DV_SNW_FL"."HUB_EMPLOYEE_RANGE" "DVO_SRC1"
	)
	, "DVO_BASE3" AS 
	( 
		SELECT 
			  "DVO_SRC3"."SHOPS_HKEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_SRC3"."SHOP_CODE_BK" AS "SHOP_CODE_BK"
			, "DVO_SRC3"."SHOP_NAME_BK" AS "SHOP_NAME_BK"
			, "DVO_SRC3"."SHOPPING_CENTER_ID_BK" AS "SHOPPING_CENTER_ID_BK"
			, "PIT_SRC3_2"."SNAPSHOT_TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
		FROM "VS_DEMO_DV_SNW_FL"."HUB_SHOPS" "DVO_SRC3"
		INNER JOIN "VS_DEMO_DV_SNW_BV"."PIT_DETAIL_TRANS_SHOPS" "PIT_SRC3_2" ON  "DVO_SRC3"."SHOPS_HKEY" = "PIT_SRC3_2"."SHOPS_HKEY"
		INNER JOIN "VS_DEMO_DV_SNW_FL"."SAT_PRD_SHOPS" "SAT_SRC3_2_1" ON  "PIT_SRC3_2"."SAT_PRD_SHOPS_HKEY" = "SAT_SRC3_2_1"."SHOPS_HKEY"
		INNER JOIN "VS_DEMO_DV_SNW_FL"."SAT_SLS_SHOPS" "SAT_SRC3_2_2" ON  "PIT_SRC3_2"."SAT_SLS_SHOPS_HKEY" = "SAT_SRC3_2_2"."SHOPS_HKEY"
		INNER JOIN "VS_DEMO_DV_SNW_FL"."SAT_VST_SHOPS" "SAT_SRC3_2_3" ON  "PIT_SRC3_2"."SAT_VST_SHOPS_HKEY" = "SAT_SRC3_2_3"."SHOPS_HKEY"
	)
	, "DVO_BASE5" AS 
	( 
		SELECT 
			  "DVO_SRC5"."LOCATION_HKEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_SRC5"."SHOP_LOCATION_BK" AS "SHOP_LOCATION_BK"
		FROM "VS_DEMO_DV_SNW_FL"."HUB_LOCATION" "DVO_SRC5"
	)
	, "DVO_BASE2" AS 
	( 
		SELECT 
			  "DVO_SRC2"."SHOPS_HKEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_SRC2"."LNK_SHOPS_EMPLOYEERANGE_HKEY" AS "BASE_OBJECT_L_H_KEY"
			, "DVO_SRC2"."EMPLOYEE_RANGE_HKEY" AS "BASE_OBJECT_F_H_KEY"
			, "PIT_SRC2_1"."SNAPSHOT_TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
		FROM "VS_DEMO_DV_SNW_FL"."LNK_SHOPS_EMPLOYEERANGE" "DVO_SRC2"
		INNER JOIN "VS_DEMO_DV_SNW_BV"."PIT_DETAIL_TRANS_SHOPS_EMPLOYEERANGE" "PIT_SRC2_1" ON  "DVO_SRC2"."LNK_SHOPS_EMPLOYEERANGE_HKEY" = "PIT_SRC2_1"."LNK_SHOPS_EMPLOYEERANGE_HKEY"
		INNER JOIN "VS_DEMO_DV_SNW_FL"."LKS_SLS_SHOPS_EMPLOYEERANGE" "SAT_SRC2_1_1" ON  "PIT_SRC2_1"."LKS_SLS_SHOPS_EMPLOYEERANGE_HKEY" = "SAT_SRC2_1_1"."LNK_SHOPS_EMPLOYEERANGE_HKEY"
	)
	, "DVO_BASE4" AS 
	( 
		SELECT 
			  "DVO_SRC4"."SHOPS_HKEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_SRC4"."LNK_SHOPS_LOCATION_HKEY" AS "BASE_OBJECT_L_H_KEY"
			, "DVO_SRC4"."LOCATION_HKEY" AS "BASE_OBJECT_F_H_KEY"
			, "PIT_SRC4_1"."SNAPSHOT_TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
		FROM "VS_DEMO_DV_SNW_FL"."LNK_SHOPS_LOCATION" "DVO_SRC4"
		INNER JOIN "VS_DEMO_DV_SNW_BV"."PIT_DETAIL_TRANS_SHOPS_LOCATION" "PIT_SRC4_1" ON  "DVO_SRC4"."LNK_SHOPS_LOCATION_HKEY" = "PIT_SRC4_1"."LNK_SHOPS_LOCATION_HKEY"
		INNER JOIN "VS_DEMO_DV_SNW_FL"."LKS_SLS_SHOPS_LOCATION" "SAT_SRC4_1_1" ON  "PIT_SRC4_1"."LKS_SLS_SHOPS_LOCATION_HKEY" = "SAT_SRC4_1_1"."LNK_SHOPS_LOCATION_HKEY"
	)
	, "COMBINE_SNAPSHOTS" AS 
	( 
		SELECT 
			  "DVO_BASE3"."BASE_OBJECT_H_KEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_BASE3"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
		FROM "DVO_BASE3" "DVO_BASE3"
	)
	, "SNAPSHOT_DATES" AS 
	( 
		SELECT 
			  "COMBINE_SNAPSHOTS"."BASE_OBJECT_H_KEY" AS "BASE_OBJECT_H_KEY"
			, "COMBINE_SNAPSHOTS"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
			, COALESCE(LEAD("COMBINE_SNAPSHOTS"."SNAPSHOT__TIMESTAMP")OVER(PARTITION BY "COMBINE_SNAPSHOTS"."BASE_OBJECT_H_KEY" ORDER BY "COMBINE_SNAPSHOTS"."SNAPSHOT__TIMESTAMP")
				, TO_TIMESTAMP('31/12/2999 23:59:59' , 'DD/MM/YYYY HH24:MI:SS')) AS "END_SNAPSHOT__TIMESTAMP"
		FROM "COMBINE_SNAPSHOTS" "COMBINE_SNAPSHOTS"
	)
	, "DATA_SET" AS 
	( 
		SELECT 
			  "DVO_BASE3"."BASE_OBJECT_H_KEY" AS "BASE_OBJECT_H_KEY"
			, "DVO_BASE3"."SHOP_CODE_BK" AS "SHOP_CODE_BK"
			, "DVO_BASE3"."SHOP_NAME_BK" AS "SHOP_NAME_BK"
			, "DVO_BASE3"."SHOPPING_CENTER_ID_BK" AS "SHOPPING_CENTER_ID_BK"
			, "DVO_BASE3"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
			, "SNAPSHOT_DATES"."END_SNAPSHOT__TIMESTAMP" AS "END_SNAPSHOT__TIMESTAMP"
			, UPPER(SHA1_HEX(  UPPER(REPLACE(COALESCE(TRIM( "DVO_BASE3"."BASE_OBJECT_H_KEY"),'~'),'\#','\\' || '\#'))|| 
				'\#'                  )) AS "DIM_HASH_DIFF"
		FROM "VS_DEMO_DV_SNW_BV"."BRIDGE_SHOP_LOCATION_EMPLOYEERANGE" "BRIDGE_SRC"
		INNER JOIN "SNAPSHOT_DATES" "SNAPSHOT_DATES" ON  "BRIDGE_SRC"."SHOPS_HKEY" = "SNAPSHOT_DATES"."BASE_OBJECT_H_KEY"
		INNER JOIN "DVO_BASE1" "DVO_BASE1" ON  "BRIDGE_SRC"."EMPLOYEE_RANGE_HKEY" = "DVO_BASE1"."BASE_OBJECT_H_KEY" AND "DVO_BASE1"."SNAPSHOT__TIMESTAMP" >= 
			"SNAPSHOT_DATES"."SNAPSHOT__TIMESTAMP" AND "DVO_BASE1"."SNAPSHOT__TIMESTAMP" < "SNAPSHOT_DATES"."END_SNAPSHOT__TIMESTAMP"
		INNER JOIN "DVO_BASE2" "DVO_BASE2" ON  "BRIDGE_SRC"."LNK_SHOPS_EMPLOYEERANGE_HKEY" = "DVO_BASE2"."BASE_OBJECT_L_H_KEY" AND "DVO_BASE2"."SNAPSHOT__TIMESTAMP" >=
			 "SNAPSHOT_DATES"."SNAPSHOT__TIMESTAMP" AND "DVO_BASE2"."SNAPSHOT__TIMESTAMP" < "SNAPSHOT_DATES"."END_SNAPSHOT__TIMESTAMP"
		INNER JOIN "DVO_BASE3" "DVO_BASE3" ON  "BRIDGE_SRC"."SHOPS_HKEY" = "DVO_BASE3"."BASE_OBJECT_H_KEY" AND "DVO_BASE3"."SNAPSHOT__TIMESTAMP" = 
			"SNAPSHOT_DATES"."SNAPSHOT__TIMESTAMP"
		INNER JOIN "DVO_BASE4" "DVO_BASE4" ON  "BRIDGE_SRC"."LNK_SHOPS_LOCATION_HKEY" = "DVO_BASE4"."BASE_OBJECT_L_H_KEY" AND "DVO_BASE4"."SNAPSHOT__TIMESTAMP" >=
			 "SNAPSHOT_DATES"."SNAPSHOT__TIMESTAMP" AND "DVO_BASE4"."SNAPSHOT__TIMESTAMP" < "SNAPSHOT_DATES"."END_SNAPSHOT__TIMESTAMP"
		INNER JOIN "DVO_BASE5" "DVO_BASE5" ON  "BRIDGE_SRC"."LOCATION_HKEY" = "DVO_BASE5"."BASE_OBJECT_H_KEY" AND "DVO_BASE5"."SNAPSHOT__TIMESTAMP" >= 
			"SNAPSHOT_DATES"."SNAPSHOT__TIMESTAMP" AND "DVO_BASE5"."SNAPSHOT__TIMESTAMP" < "SNAPSHOT_DATES"."END_SNAPSHOT__TIMESTAMP"
	)
	, "HASH_DIFF_DATA_SET" AS 
	( 
		SELECT 
			  "DATA_SET"."BASE_OBJECT_H_KEY" AS "BASE_OBJECT_H_KEY"
			, "DATA_SET"."SHOP_CODE_BK" AS "SHOP_CODE_BK"
			, "DATA_SET"."SHOP_NAME_BK" AS "SHOP_NAME_BK"
			, "DATA_SET"."SHOPPING_CENTER_ID_BK" AS "SHOPPING_CENTER_ID_BK"
			, "DATA_SET"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
			, "DATA_SET"."END_SNAPSHOT__TIMESTAMP" AS "END_SNAPSHOT__TIMESTAMP"
			, CASE WHEN COALESCE(LEAD("DATA_SET"."DIM_HASH_DIFF")OVER(PARTITION BY "DATA_SET"."BASE_OBJECT_H_KEY" ORDER BY "DATA_SET"."SNAPSHOT__TIMESTAMP")
				,'XXX')!= "DATA_SET"."DIM_HASH_DIFF" THEN 1 ELSE 0 END AS "CHANGE_FLAG"
		FROM "DATA_SET" "DATA_SET"
	)
	, "FILTERED_DATA_SET" AS 
	( 
		SELECT 
			  "HASH_DIFF_DATA_SET"."BASE_OBJECT_H_KEY" AS "SHOPS_HKEY"
			, "HASH_DIFF_DATA_SET"."SHOP_CODE_BK" AS "SHOP_CODE_BK"
			, "HASH_DIFF_DATA_SET"."SHOP_NAME_BK" AS "SHOP_NAME_BK"
			, "HASH_DIFF_DATA_SET"."SHOPPING_CENTER_ID_BK" AS "SHOPPING_CENTER_ID_BK"
			, "HASH_DIFF_DATA_SET"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
			, "HASH_DIFF_DATA_SET"."END_SNAPSHOT__TIMESTAMP" AS "END_SNAPSHOT__TIMESTAMP"
		FROM "HASH_DIFF_DATA_SET" "HASH_DIFF_DATA_SET"
		WHERE  "HASH_DIFF_DATA_SET"."CHANGE_FLAG" = 1
	)
	SELECT 
		  UPPER(SHA1_HEX(  UPPER(REPLACE(COALESCE(TRIM( "FILTERED_DATA_SET"."SHOP_CODE_BK"),'~'),'\#','\\' || '\#'))|| 
			'\#' ||  UPPER(REPLACE(COALESCE(TRIM( "FILTERED_DATA_SET"."SHOP_NAME_BK"),'~'),'\#','\\' || '\#'))|| '\#' ||  UPPER(REPLACE(COALESCE(TRIM( "FILTERED_DATA_SET"."SHOPPING_CENTER_ID_BK"),'~'),'\#','\\' || '\#'))|| '\#' || UPPER(REPLACE(COALESCE(TRIM( TO_CHAR("FILTERED_DATA_SET"."SNAPSHOT__TIMESTAMP", 'DD/MM/YYYY HH24:MI:SS')),'~'),'\#','\\' || '\#'))|| '\#'  )) AS "DIMENSION_KEY"
		, "FILTERED_DATA_SET"."SHOPS_HKEY" AS "SHOPS_HKEY"
		, "FILTERED_DATA_SET"."SHOP_CODE_BK" AS "SHOP_CODE_BK"
		, "FILTERED_DATA_SET"."SHOP_NAME_BK" AS "SHOP_NAME_BK"
		, "FILTERED_DATA_SET"."SHOPPING_CENTER_ID_BK" AS "SHOPPING_CENTER_ID_BK"
		, "FILTERED_DATA_SET"."SNAPSHOT__TIMESTAMP" AS "SNAPSHOT__TIMESTAMP"
		, COALESCE(LEAD("FILTERED_DATA_SET"."SNAPSHOT__TIMESTAMP")OVER(PARTITION BY "FILTERED_DATA_SET"."SHOPS_HKEY" ORDER BY "FILTERED_DATA_SET"."SNAPSHOT__TIMESTAMP")
			, TO_TIMESTAMP('31/12/2999 23:59:59' , 'DD/MM/YYYY HH24:MI:SS')) AS "END_SNAPSHOT__TIMESTAMP"
	FROM "FILTERED_DATA_SET" "FILTERED_DATA_SET"
	;
