import sys

filename = sys.argv[1]

averageAccuracy = [0, 0, 0, 0]
expectedAccuracy = [0.9484, 0.9513, 0.9531, 0.9512]
keys = ['2400', '6400', '9999', '32000']	

lines = open(filename, 'r').readlines()
buildindex = lines.index("BUILD SUCCESSFUL\n")
lines = lines[buildindex+1:]
buildindex = lines.index("BUILD SUCCESSFUL\n")
lines = lines[buildindex+1:]
buildindex = lines.index("BUILD SUCCESSFUL\n")
lines = lines[buildindex+2:]
	
i = 0
total = 0
for x in range(2, len(lines), 3):
	total += float(lines[x].strip().split()[-1])
	i += 1
	if i%5 == 0:
		averageAccuracy[i // 5 - 1] = total / 5
		total = 0

for key, expected, avg in zip(keys, expectedAccuracy, averageAccuracy):
	print("predictor:", key)
	print("expected:", expected)
	print("averageAccuracy:", avg)
	print()