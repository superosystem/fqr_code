import socket
import threading

# Username
Username = input("Masukan Username: ")
# Client
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('127.0.0.1', 8080))


# Koneksi Server
def receive():
    while True:
        try:
            message = client.recv(1024).decode('ascii')
            if message == 'NAME':
                client.send(Username.encode('ascii'))
            else:
                print(message)
        except:
            # Tutup Koneksi
            print("Koneksi Terputus")
            client.close()
            break


# Kirim Pesan
def write():
    while True:
        message = '{}: {}'.format(Username, input(''))
        client.send(message.encode('ascii'))


# Membuat Thread
receive_thread = threading.Thread(target=receive)
receive_thread.start()
write_thread = threading.Thread(target=write)
write_thread.start()