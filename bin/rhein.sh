#!/bin/sh
PEGEL=`wget https://www.steb-koeln.de/Weiterleitung-Pegel.jsp -q -O -`
say der rhein bei köln steht bei $PEGEL meter
