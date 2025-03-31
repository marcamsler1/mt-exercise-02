import numpy as np
import matplotlib.pyplot as plt
import sys
import os

logfiles = sys.argv[1:]

train_data = {}
val_data = {}

for filepath in logfiles:
    
    train_ppl = []
    val_ppl = []
    
    with open(filepath, 'r') as logfile:
        for line in logfile:
            if line.strip().startswith("Test"):
                continue
            else:
                train, val = map(float, line.strip().split('\t'))
                train_ppl.append(train)
                val_ppl.append(val)
                
        label = filepath.replace("logs/log_", "").replace(".txt", "").replace("_", " = ")
        train_data[label] = train_ppl
        val_data[label] = val_ppl
        
        
#Training perplexity
plt.figure(figsize=(10, 6))
for label, values in train_data.items():
    plt.plot(values, label=label, linestyle='--')
plt.xlabel('Epoch')
plt.ylabel('Training Perplexity')
plt.title('Training Perplexity over Epochs')
plt.legend()
plt.grid(True)
plt.show()

#Validation perplexity
plt.figure(figsize=(10, 6))
for label, values in val_data.items():
    plt.plot(values, label=label)
plt.xlabel('Epoch')
plt.ylabel('Validation Perplexity')
plt.title('Validation Perplexity over Epochs')
plt.legend()
plt.grid(True)
plt.show()