{{- /* ngx_http_v2_module */ -}}
{{- define "nginx.ngx_http_v2_module" -}}
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
