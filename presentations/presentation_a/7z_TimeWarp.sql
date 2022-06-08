
-- the current system date time - based on UTC (the setting for dedicated SQL Pool)
SELECT getdate () 

-- same time, but you get the timezone + added
SELECT getdate () AT TIME ZONE 'Central European Standard Time';

-- convert into datetime - still the same time!!!
select convert(datetime2, i.val)
from
( SELECT getdate () AT TIME ZONE 'Central European Standard Time' as val
) as i;

-- now the time is correct!!! But the + is still there
SELECT GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Central European Standard Time'

-- 
select convert(datetime2,  GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Central European Standard Time' )











