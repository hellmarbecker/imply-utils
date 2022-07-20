SELECT 
  timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00'),
  mean_timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00', 'PT15M'),
  delta_timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00', 'PT15M'),
  linear_interpolation(timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00'), 'PT5M'),
  padding_interpolation(mean_timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00', 'PT15M', 100), 'PT5M'),
  time_weighted_average(timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00'), 'linear', 'PT15M'), 
  time_weighted_average(backfill_interpolation(delta_timeseries(__time, val, '2022-07-19T11:00:00/2022-07-19T12:00:00', 'PT15M', 100), 'PT5M'), 'linear', 'PT15M')
FROM timeseries_small
GROUP BY var
