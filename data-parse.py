import re
f = open("merged-file", "r")
frequencyMap = {}
for line in f:
	m = re.match(r"2020-\d\d-\d\d\s\d\d:\d\d:\d\d\.\d\d\d\s\-\s\[Debug]\s\[EXEC]\sNoninteractive mode attacker command:\s(.*)", line)
	if m: 
                words = set(m.group(1).split(" "))
                for word in words:
                     if word not in frequencyMap: frequencyMap[word] = 1
                     else: frequencyMap[word] += 1
for x in sorted(frequencyMap.items(), key = lambda k: k[1])[::-1]:
	if x[1] > 1:
		print(x)
