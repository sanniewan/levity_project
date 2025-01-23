import serial
import time

def main():
    initialize()
    loop()

def initialize():
    global ser
    print("connecting...")
    time.sleep(1)
    ser = serial.Serial('/dev/tty.usbmodem142102', baudrate=115200, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)
    time.sleep(1)
    print("connected")

def loop():
    tx = True

    while (tx):
        print("1 = 39.9kHz, 2 = 40.0kHz, 3 = 40.1kHz")
        selection = int(input("Please enter a number: "))
        if (selection == 1 or selection == 2 or selection == 3):
            byte_to_send = selection.to_bytes(4, 'little')          # Sends 1, 2, or 3
        else:
            selection = 0
            byte_to_send = selection.to_bytes(4, 'little')                  # Sends 0
        

        ser.write(byte_to_send)

        print("Selection sent:", selection)
        print(byte_to_send)    

if __name__ == '__main__' :
    print("hi")
    main()
