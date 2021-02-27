# -*- coding: utf-8 -*-
"""
Created on Thu Feb 25 17:45:10 2021

@author: yonic
"""

import serial
port = serial.Serial('/dev/ttyS3',115200)
while True:
    c = port.read()
    print('was readen::',c.hex(), c.decode('ascii'))