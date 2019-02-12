INDIGOLIB = ../indigo_libs

all: indigo_py_adapter.o _indigo_bus.so _indigo_client.so

indigo_py_adapter.o: indigo_py_adapter.c
	gcc -fPIC -DINDIGO_LINUX -I.. -c indigo_py_adapter.c

_indigo_bus.so:	indigo_bus.i
	swig -python -I${INDIGOLIB} indigo_bus.i
	gcc -fPIC -DINDIGO_LINUX -c ${INDIGOLIB}/indigo_bus.c indigo_bus_wrap.c -I${INDIGOLIB} -I/usr/include/python3.5m
	ld -shared  ${INDIGOLIB}/indigo_bus.o ${INDIGOLIB}/indigo_io.o indigo_bus_wrap.o -o _indigo_bus.so

_indigo_client.so: indigo_client.i indigo_py_adapter.o
	swig -python -I${INDIGOLIB} indigo_client.i
	gcc -fPIC -DINDIGO_LINUX -c ${INDIGOLIB}/indigo_client.c indigo_client_wrap.c -I${INDIGOLIB} -I/usr/include/python3.5m
	ld -shared ${INDIGOLIB}/indigo_client.o ${INDIGOLIB}/indigo_client_xml.o indigo_py_adapter.o ${INDIGOLIB}/indigo_bus.o ${INDIGOLIB}/indigo_io.o ${INDIGOLIB}/indigo_xml.o ${INDIGOLIB}/indigo_version.o ${INDIGOLIB}/indigo_base64.o indigo_client_wrap.o -o _indigo_client.so
