# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 01:04:49 2022

@author: User
"""

  
import json
 
# Opening JSON file
f = open('data.json')
  
# returns JSON object as 
# a dictionary
data = json.load(f)
  
# Iterating through the json
# list
# Pretty Printing JSON string back
#print(json.dumps(data, indent = 4, sort_keys=True))
countrylist= list()
categorylist= list()
for counts in range(646):
    country = data['articles'][counts]['country']
    category = data['articles'][counts]['category']
    countrylist.append(country)
    categorylist.append(category)
    print(countrylist)
    print(categorylist)
import matplotlib.pyplot as plt
R = 1
max_theta = 2* np.pi
list_t = list(np.arange(0,max_theta,0.0001))
x_circle = [(R*math.cos(x_y)) for x_y  in list_t]
y_circle = [(R*math.sin(x_y)) for x_y  in list_t]
#Plot
fig = plt.figure()
fig.set_size_inches(8, 8)
ax = fig.add_axes([0.15,0.2,0.7,0.7]) 
ax.plot(x_circle, y_circle, linestyle = 'solid', color = 'black')
# Closing file
f.close()
