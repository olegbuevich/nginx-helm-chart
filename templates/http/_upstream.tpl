{{- /* ngx_http_upstream_module */}}
{{- define "nginx.http-upstream" -}}
{{- range . }}
{{- if hasKey . "name" }}
upstream {{ .name }} {
{{- with .servers }}
  {{- range . }}
    {{- if hasKey . "address" }}
  server {{ .address }}
      {{- if and (hasKey . "weight") (typeIs "float64" .weight) -}}{{- printf " weight=%s" (.weight | toString) -}}{{- end -}}
      {{- if and (hasKey . "max_conns") (typeIs "float64" .max_conns) -}}{{- printf " max_conns=%s" (.max_conns | toString) -}}{{- end -}}
      {{- if and (hasKey . "max_fails") (typeIs "float64" .max_fails) -}}{{- printf " max_fails=%s" (.max_fails | toString) -}}{{- end -}}
      {{- if hasKey . "fail_timeout" -}}{{- printf " fail_timeout=%s" .fail_timeout -}}{{- end -}}
      {{- if and (hasKey . "backup") (typeIs "bool" .backup) .backup -}}{{- print " backup" -}}{{- end -}}
      {{- if and (hasKey . "down") (typeIs "bool" .down) .down -}}{{- print " down" -}}{{- end -}}
      {{- if and (hasKey . "resolve") (typeIs "bool" .resolve) .resolve -}}{{- print " resolve" -}}{{- end -}}
      {{- if hasKey . "route" -}}{{- printf " route=%s" .route -}}{{- end -}}
      {{- if hasKey . "service" -}}{{- printf " service=%s" .service -}}{{- end -}}
      {{- if hasKey . "slow_start" -}}{{- printf " slow_start=%s" .slow_start -}}{{- end -}}
      {{- if and (hasKey . "drain") (typeIs "bool" .drain) .drain -}}{{- print " drain" -}}{{- end -}}
      ;
    {{- end }}
  {{- end }}
{{- end }}
{{- with .zone }}
  {{- if hasKey . "name" }}
  zone {{ .name }}
    {{- if hasKey . "size" -}}{{- printf " %s" .size -}}{{- end -}}
    ;
  {{- end }}
{{- end }}
{{- if hasKey . "hash" -}}
  {{- printf "hash %s" .hash.key | nindent 2 -}}
  {{- if and (hasKey .hash "consistent") (typeIs "bool" .hash.consistent) .hash.consistent -}}{{- print " consistent" -}}{{- end -}}
  {{- print ";" -}}
{{- else if hasKey . "ip_hash" -}}
  {{- if and (typeIs "bool" .ip_hash) .ip_hash -}}{{- print "ip_hash;" | nindent 2 -}}{{- end -}}
{{- else if hasKey . "least_conn" -}}
  {{- if and (typeIs "bool" .least_conn) .least_conn -}}{{- print "least_conn;" | nindent 2 -}}{{- end -}}
{{- else if hasKey . "random" -}}
  {{- print "random" | nindent 2 -}}
  {{- if and (hasKey .random "two") (typeIs "bool" .random.two) .random.two -}}{{- print " two" -}}{{- end -}}
  {{- if hasKey .random "method" -}}{{- printf " %s" .random.method -}}{{- end -}}
  {{- print ";" -}}
{{- end -}}
{{- if and (hasKey . "keepalive") (typeIs "float64" .keepalive) -}}{{- printf "keepalive %s;" (.keepalive | toString) | nindent 2 -}}{{- end -}}
{{- if and (hasKey . "keepalive_requests") (typeIs "float64" .keepalive_requests) -}}{{- printf "keepalive_requests %s;" (.keepalive_requests | toString) | nindent 2 -}}{{- end -}}
{{- if hasKey . "keepalive_time" -}}{{- printf "keepalive_time %s;" (.keepalive_time | toString) | nindent 2 -}}{{- end -}}
{{- if hasKey . "keepalive_timeout" -}}{{- printf "keepalive_timeout %s;" (.keepalive_timeout | toString) | nindent 2 -}}{{- end -}}
{{- print "}" | nindent 0 -}}
{{- end -}}
{{- end -}}
{{- end -}}
*/}}
