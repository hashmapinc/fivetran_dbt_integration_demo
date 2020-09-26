SELECT
  START_TIME,
  END_TIME,
  WAREHOUSE_ID,
  WAREHOUSE_NAME,
  CREDITS_USED,
  CREDITS_USED_COMPUTE,
  CREDITS_USED_CLOUD_SERVICES

FROM
  {{source('snowflake_account_usage', 'warehouse_metering_history')}}

{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  WHERE 
    END_TIME > (SELECT MAX(END_TIME) FROM {{ this }})
{% endif %}