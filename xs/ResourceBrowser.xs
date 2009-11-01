#include "perl_gssdp.h"

MODULE = Net::SSDP::ResourceBrowser  PACKAGE = Net::SSDP::ResourceBrowser  PREFIX = gssdp_resource_browser_

PROTOTYPES: DISABLE

GSSDPResourceBrowser *
gssdp_resource_browser_new (class, client, target)
		GSSDPClient *client
		const char *target
    INIT:
        if (!target || !strchr (target, ':')) {
            croak ("Net::SSDP::ResourceBrowser->new: target needs to be defined and contain a colon");
        }
	C_ARGS:
		client, target

GSSDPClient *
gssdp_resource_browser_get_client (resource_browser)
		GSSDPResourceBrowser *resource_browser

void
gssdp_resource_browser_set_target (resource_browser, target)
		GSSDPResourceBrowser *resource_browser
		const char *target

const char *
gssdp_resource_browser_get_target (resource_browser)
		GSSDPResourceBrowser *resource_browser

void
gssdp_resource_browser_set_mx (resource_browser, mx)
		GSSDPResourceBrowser *resource_browser
		gushort mx

void
gssdp_resource_browser_set_active (resource_browser, active)
		GSSDPResourceBrowser *resource_browser
		gboolean active

gboolean
gssdp_resource_browser_get_active (resource_browser)
		GSSDPResourceBrowser *resource_browser
