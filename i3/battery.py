import subprocess
import time

while (True):
    
    output = subprocess.check_output("acpi", shell=True)

    if (int(output[24:26]) <= 10):
        subprocess.check_output("notify-send PLUGIN", shell=True)
        time.sleep(1)
    
    else:
        time.sleep(120)
