import matplotlib.pyplot as plt
import json

f = input("Input the file name with file format: ")
f = "C:/samson/HSU/Hackathron/" + f
dictionary = json.load(open(f, 'r', encoding="utf-8"))
xAxis = [key for key, value in dictionary.items()]
yAxis = [value for key, value in dictionary.items()]
plt.grid(True)

## LINE GRAPH ##
plt.plot(xAxis,yAxis, color='maroon', marker='o')
plt.xlabel('variable')
plt.ylabel('value')

## BAR GRAPH ##
fig = plt.figure()
plt.bar(xAxis,yAxis, color='maroon')
plt.xlabel('variable')
plt.ylabel('value')

plt.show()