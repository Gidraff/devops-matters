$ttl 86400 
@       IN      SOA  ns.main.com. hostmaster.main.com.(
                     202 ; serial
                     600 ; Refresh
                     3600 ; Retry
                     12378237) ; Expire

@       IN       NS  ns.main.com.
ns      IN       A   12.0.0.1