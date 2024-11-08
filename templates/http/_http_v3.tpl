{{- /* ngx_http_v3_module */ -}}
{{- define "nginx.ngx_http_v3_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if and (hasKey . "enable") (kindIs "bool" .enable) -}}
      {{- print "http3 " (.enable | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "hq") (kindIs "bool" .hq) -}}
      {{- print "http3_hq " (.hq | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "max_concurrent_streams") (kindIs "float64" .max_concurrent_streams) -}}
      {{- print "http3_max_concurrent_streams " .max_concurrent_streams ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "stream_buffer_size" -}}
      {{- print "http3_stream_buffer_size " .stream_buffer_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "quic_active_connection_id_limit") (kindIs "float64" .quic_active_connection_id_limit) -}}
      {{- print "quic_active_connection_id_limit " .quic_active_connection_id_limit ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "quic_bpf") (kindIs "bool" .quic_bpf) (eq $scope "main") -}}
      {{- print "quic_bpf " (.quic_bpf | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "quic_gso") (kindIs "bool" .quic_gso) -}}
      {{- print "quic_gso " (.quic_gso | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "quic_host_key" -}}
      {{- print "quic_host_key " .quic_host_key ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "quic_retry") (kindIs "bool" .quic_retry) -}}
      {{- print "quic_retry " (.quic_retry | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
