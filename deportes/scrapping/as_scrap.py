# -*- coding: utf-8 -*-
"""
Created on Sat Nov 26 22:34:38 2016

@author: GFR
"""

import requests
from bs4 import BeautifulSoup
import urllib2



url = "http://resultados.as.com/resultados/futbol/primera/2016_2017/directo/regular_a_12_179620/estadisticas/"
content = urllib2.urlopen(url).read()

soup = BeautifulSoup(content)

# Eventos equipo local obtenidos desde web
ev_local = soup.find_all("div", class_="eventos-local")
acc_local = ev_local[0].find_all("p", class_="txt-accion")
acciones_equipo_local = []

# Eventos equipo visitante obtenidos desde web
ev_visit = soup.find_all("div", class_="eventos-visit")
acc_visit = ev_visit[0].find_all("p", class_="txt-accion")
acciones_equipo_visit = []


# Función que devuelve las acciones del equipo como lista de diccionarios
def get_acciones_equipo(acc):
    
    acciones_equipo = []
    for e in range(len(acc)):
        data = {"min": None,
                "acc": None,
                "sale": None,
                "fut": None,
                "entra": None,
                }    
        
        data["min"] = acc[e].find("span", class_="min-evento").get_text()
        data["acc"] = acc[e].find("span", class_="hidden-xs").get_text()
    
        if data["acc"] != "Cambio":    
            data["fut"] = acc[e].find("strong").get_text()
        else:
            data["sale"] = acc[e].find_all("strong")[0].get_text()
            data["entra"] = acc[e].find_all("strong")[1].get_text()
            
        acciones_equipo.append(data)
        
    return acciones_equipo


if __name__ == '__main__':
    acciones_equipo_local = get_acciones_equipo(acc_local)
    acciones_equipo_visit = get_acciones_equipo(acc_visit)
