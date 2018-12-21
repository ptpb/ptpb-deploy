vcl 4.0;

backend default {
	.host = "pb";
	.port = "8080";
}

acl purge {
	"localhost";
}

sub vcl_recv {
	if (req.method == "BAN") {
		if (!client.ip ~ purge) {
			return(synth(405, "Not allowed."));
		}

		ban("req.http.host == " + req.http.host +
				" && req.url ~ " + req.url);

		return(synth(200, "Ban added."));
	}
}

sub vcl_backend_error {
	set beresp.http.Content-Type = "text/plain; charset=utf-8";
	set beresp.http.Retry-After = "5";
	synthetic(beresp.status + " " + beresp.reason + ".");
	return (deliver);
}
