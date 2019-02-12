// Package up a few functions for easier swig wrapping to Python
//

#include "indigo_bus.h"
#include "indigo_client.h"
#include "indigo_xml.h"
#include <string.h>

indigo_server_entry *indigo_adapter_connect_server(char *hostname, int port) {
  
  indigo_server_entry *server;
  indigo_result result;
  result = indigo_connect_server(hostname, hostname, port, &server);
  return(server);
}

// Create and attach an indigo_client (see indigo_bus.h) with Python callbacks

static indigo_client client;

indigo_client *indigo_adapter_attach_client(char *client_name, indigo_result (*attach_callback)(indigo_client *client),
					    indigo_result (*define_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
					    indigo_result (*update_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
					    indigo_result (*delete_property_callback)(indigo_client *client, indigo_device *device, indigo_property *property, const char *message),
					    indigo_result (*send_message_callback)(indigo_client *client, indigo_device *device, const char *message),
					    indigo_result (*detach_callback)(indigo_client *client))
{

  strncpy(client.name, client_name, INDIGO_NAME_SIZE);
  client.is_remote = false;
  client.client_context = NULL;
  client.last_result = INDIGO_OK;
  client.version = INDIGO_VERSION_CURRENT;
  client.enable_blob_mode_records = NULL;
  client.attach = attach_callback;
  client.define_property = define_property_callback;
  client.update_property = update_property_callback;
  client.delete_property = delete_property_callback;
  client.send_message = send_message_callback;
  client.detach = detach_callback;
  indigo_attach_client(&client);
  return &client;
}
