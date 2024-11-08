{{- /* ngx_http_v2_module */ -}}
{{- define "nginx.http_v2" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if not (eq $scope "location") -}}
      {{- /* The following scoped directives are not available in the 'location' context */ -}}
      {{- if and (hasKey . "enable") (kindIs "bool" .enable) -}}
        {{- print "http2 " (.enable | ternary "on" "off") ";" | nindent 0 -}}
      {{- end -}}
      {{- if hasKey . "body_preread_size" -}}
        {{- print "http2_body_preread_size " .body_preread_size ";" | nindent 0 -}}
      {{- end -}}
      {{- if and (hasKey . "max_concurrent_streams") (kindIs "float64" .max_concurrent_streams) -}}
        {{- print "http2_max_concurrent_streams " .max_concurrent_streams ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if eq $scope "http" -}}
      {{- /* The following scoped directives are only available in the 'http' context */ -}}
      {{- if hasKey . "recv_buffer_size" -}}
        {{- print "http2_recv_buffer_size " .recv_buffer_size ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "chunk_size" -}}
      {{- print "http2_chunk_size " .chunk_size ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- /* ngx_http_v3_module */ -}}
{{- define "nginx.http_v3" -}}
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
  {{- end -}}
{{- end -}}

{{- /* ngx_event_quic */ -}}
{{- define "nginx.quic" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if eq $scope "global" -}}
      {{- if and (hasKey . "bpf") (kindIs "bool" .bpf) -}}
        {{- print "quic_bpf " (.bpf | ternary "on" "off") ";" | nindent 0 -}}
      {{- end -}}
    {{- else -}}
      {{- if and (hasKey . "active_connection_id_limit") (kindIs "float64" .active_connection_id_limit) -}}
        {{- print "quic_active_connection_id_limit " .active_connection_id_limit ";" | nindent 0 -}}
      {{- end -}}
      {{- if and (hasKey . "gso") (kindIs "bool" .gso) -}}
        {{- print "quic_gso " (.gso | ternary "on" "off") ";" | nindent 0 -}}
      {{- end -}}
      {{- if hasKey . "host_key" -}}
        {{- print "quic_host_key " .host_key ";" | nindent 0 -}}
      {{- end -}}
      {{- if and (hasKey . "retry") (kindIs "bool" .retry) -}}
        {{- print "quic_retry " (.retry | ternary "on" "off") ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
