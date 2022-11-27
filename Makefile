CPP = g++
SRC = main.cpp
TARGET = chat.out
MYLIB = ChatLib
PREF = /usr/local/bin
OBJ1 = AuthData.o Chat.o Message.o Connection.o Server.o Client.o 
OBJ2 = Errors.o InOut.o OS_info.o DefaultHandler.o 
OBJ3 = SQLdataBase.cpp
LIBS = -static-libgcc  "/lib/libmariadb.dll.a"
INCS = -I"/usr/include/mysql"
FLAGS = -std=c++17 
#$(INCS) -Wall -Wextra -Wpedantic -g3 
$(TARGET): $(OBJ1) $(OBJ2) lib clean
	$(CPP) -o $(TARGET) $(OBJ3) $(SRC) $(INCS) $(LIBS) -L. -l$(MYLIB)	

AuthData.o: AuthData.cpp
	$(CPP) -c AuthData.cpp -o AuthData.o $(FLAGS)
	
Chat.o: Chat.cpp
	$(CPP) -c Chat.cpp -o Chat.o $(FLAGS)
	
Message.o: Message.cpp
	$(CPP) -c Message.cpp -o Message.o $(FLAGS)

Connection.o: Connection.cpp
	$(CPP) -c Connection.cpp -o Connection.o $(FLAGS)
	
Server.o: Server.cpp
	$(CPP) -c Server.cpp -o Server.o $(FLAGS) $(INCS)
	
Client.o: Client.cpp
	$(CPP) -c Client.cpp -o Client.o $(FLAGS)	
	
Errors.o: Errors.h
	$(CPP) -c Errors.h -o Errors.o $(FLAGS)
	
InOut.o: InOut.h
	$(CPP) -c InOut.h -o InOut.o $(FLAGS)
	
OS_info.o: OS_info.h
	$(CPP) -c OS_info.h -o OS_info.o $(FLAGS) 
	
DefaultHandler.o: DefaultHandler.cpp
	$(CPP) -c DefaultHandler.cpp -o DefaultHandler.o  $(FLAGS) $(INCS)
	
lib : $(OBJ1) $(OBJ2) 	
	ar rc lib$(MYLIB).a $(OBJ1) $(OBJ2) 
	export LD_LIBRARY_PATH=.	
				
clean : 
	rm -rf *.o 

install :
	sudo install -v $(TARGET) $(PREF)

uninstall :
	sudo rm -rfv $(PREF)/$(TARGET)
