{{- /*
Provides the configuration file context in which the directives that affect connection processing are specified.
*/ -}}
{{- define "nginx.core_events" -}}
  {{- if and (hasKey . "accept_mutex") (kindIs "bool" .accept_mutex) -}}
    {{- print "accept_mutex " (.accept_mutex | ternary "on" "off") ";" | nindent 0 -}}
  {{- end -}}
  {{- if hasKey . "accept_mutex_delay" -}}
    {{- print "accept_mutex_delay " .accept_mutex_delay ";" | nindent 0 -}}
  {{- end -}}
  {{- if hasKey . "debug_connection" -}}
    {{- if kindIs "slice" .debug_connection -}}
      {{- range .debug_connection -}}
        {{- print "debug_connection " . ";" | nindent 0 -}}
      {{- end -}}
    {{- else -}}
      {{- print "debug_connection " .debug_connection ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
  {{- if and (hasKey . "multi_accept") (kindIs "bool" .multi_accept) -}}
    {{- print "multi_accept " (.multi_accept | ternary "on" "off") ";" | nindent 0 -}}
  {{- end -}}
  {{- if hasKey . "use" -}}
    {{- print "use " .use ";" | nindent 0 -}}
  {{- end -}}
  {{- if and (hasKey . "worker_aio_requests") (kindIs "float64" .worker_aio_requests) -}}
    {{- print "worker_aio_requests " .worker_aio_requests ";" | nindent 0 -}}
  {{- end -}}
  {{- if and (hasKey . "worker_connections") (kindIs "float64" .worker_connections) -}}
    {{- print "worker_connections " .worker_connections ";" | nindent 0 -}}
  {{- end -}}
{{- end -}}
