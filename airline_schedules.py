# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import sys
from suds import null, WebFault
from suds.client import Client
import logging
import pandas as pd
import numpy as np
import time


username = 'mu529'
apiKey = 'dd5c0b3406652d4c0cf1bcc8e94fa541b5a8507d'
url = 'http://flightxml.flightaware.com/soap/FlightXML2/wsdl'


logging.basicConfig(level=logging.INFO)
api = Client(url, username=username, password=apiKey)
maxsize = api.service.SetMaximumResultSize(max_size = 20000)
#print api

"""
# Get the weather
result = api.service.Metar('KAUS')
print result

# Get the flights enroute
result = api.service.Enroute('KJFK', 10, '', 0)
flights = result['enroute']

print ("Aircraft en route to KJFK:")
for flight in flights:
    print ("%s (%s) \t%s (%s)") % ( flight['ident'], flight['aircrafttype'],
                                  flight['originName'], flight['origin'])
                                  """

effdate = int(time.mktime(time.strptime('2016-06-07 04:00:00', '%Y-%m-%d %H:%M:%S'))) - time.timezone
discdate = int(time.mktime(time.strptime('2016-06-13 03:59:00', '%Y-%m-%d %H:%M:%S'))) - time.timezone

result = api.service.AirlineFlightSchedules(startDate=effdate, endDate=discdate, destination='KJFK', howMany=19999, offset=0)
# result[1][1]


schedules = pd.DataFrame(0, index=np.arange(result[0]), columns=np.arange(11))
schedules.columns = ['ident', 'actual_ident', 'departuretime', 'arrivaltime', 'origin', 'destination', 'aircrafttype', 'meal_service', 'seats_cabin_first', 'seats_cabin_business', 'seats_cabin_coach']

# time.strftime("%Y-%m-%d %H:%M", time.localtime(result[1][row]['departuretime']))

for row in np.arange(len(result[1])):
    for column in schedules.columns:
        try:
            schedules.loc[row,column] = result[1][row][column]
        except:
            continue
        
schedules.to_csv('jun16_jfk_flight_schedules_import.csv')