%module indigo_client
%{

#include "indigo_client.h"
  extern  indigo_server_entry *indigo_adapter_connect_server(char *hostname, int port);
  extern indigo_client *indigo_adapter_attach_client(char *client_name, indigo_result (*attach_callback)(indigo_client *client),
						     indigo_result (*define_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						     indigo_result (*update_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						     indigo_result (*delete_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						     indigo_result (*send_message_callback)(indigo_client *client, indigo_device *device, const char *message),
						     indigo_result (*detach_callback)(indigo_client *client));
%}

%include "typemaps.i"
%include "indigo_client.h"
extern indigo_server_entry *indigo_adapter_connect_server(char *hostname, int port);
extern indigo_client *indigo_adapter_attach_client(char *client_name, indigo_result (*attach_callback)(indigo_client *client),
						   indigo_result (*define_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						   indigo_result (*update_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						   indigo_result (*delete_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
						   indigo_result (*send_message_callback)(indigo_client *client, indigo_device *device, const char *message),
						   indigo_result (*detach_callback)(indigo_client *client));


