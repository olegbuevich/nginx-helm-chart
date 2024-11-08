{{- /*
Provides the configuration file context in which the directives that affect connection processing are specified.
*/}}
{{- define "nginx.events" -}}
{{- if and (hasKey . "accept_mutex") (kindIs "bool" .accept_mutex) }}
accept_mutex {{ .accept_mutex | ternary "on" "off" }};
{{- end }}
{{- if hasKey . "accept_mutex_delay" }}
accept_mutex_delay {{ .accept_mutex_delay }};
{{- end }}
{{- if hasKey . "debug_connection" }}
  {{- if kindIs "slice" .debug_connection }}
    {{- range .debug_connection }}
debug_connection {{ . }};
    {{- end }}
  {{- else }}
debug_connection {{ .debug_connection }};
  {{- end }}
{{- end }}
{{- if and (hasKey . "multi_accept") (kindIs "bool" .multi_accept) }}
multi_accept {{ .multi_accept | ternary "on" "off" }};
{{- end }}
{{- if hasKey . "use" }}
use {{ .use }};
{{- end }}
{{- if and (hasKey . "worker_aio_requests") (kindIs "float64" .worker_aio_requests) }}
worker_aio_requests {{ .worker_aio_requests }};
{{- end }}
{{- if and (hasKey . "worker_connections") (kindIs "float64" .worker_connections) }}
worker_connections {{ .worker_connections }};
{{- end }}
{{- end -}}
