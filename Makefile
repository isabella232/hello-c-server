C_SERVER_PATH = c-server-sdk
C_SERVER_REPO = https://github.com/launchdarkly/c-server-sdk
CC = gcc
CFLAGS = -g -Wall -I$(C_SERVER_PATH)/include
LFLAGS = $(C_SERVER_PATH)/build/libldserverapi.a -lcurl -lpthread -lm -lpcre

TARGET = hello

all: $(TARGET)

clean:
	rm -rf $(TARGET) $(C_SERVER_PATH)

$(TARGET): $(TARGET).c $(C_SERVER_PATH)/build/libldserverapi.a
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c $(LFLAGS)

$(C_SERVER_PATH)/build/libldserverapi.a: $(C_SERVER_PATH)
	cd $(C_SERVER_PATH) && \
		mkdir -p build && \
		cd build && \
		cmake .. && \
		make

$(C_SERVER_PATH):
	git clone $(C_SERVER_REPO) $(C_SERVER_PATH)
