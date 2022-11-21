import csv
import matplotlib.pyplot as plt

x = []
y = []
  
f = input("Input the file name with file format: ")
f = "C:/samson/HSU/Hackathron/" + f
with open(f,'r',encoding="utf-8") as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')

    rowx = int(input("Input the row number of x-axis variable in the file: "))
    rowy = int(input("Input the row number of y-axis variable in the file: "))
      
    
    for row in plots:
        x.append(row[rowx])
        y.append(row[rowy])




a = input("Input the variable of x-axis: ")
b = input("Input the variable of y-axis: ")
plt.bar(x, y, color = 'g', width = 0.72, label = "b")
plt.xlabel(a)
plt.ylabel(b)
plt.title(a,'vs',b)
plt.legend()
plt.show()