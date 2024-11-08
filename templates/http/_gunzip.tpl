{{- /* ngx_http_gunzip_module */ -}}
{{- define "nginx.ngx_http_gunzip_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if and (hasKey . "enable") (kindIs "bool" .enable) -}}
      {{- print "gunzip " (.enable | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- with .buffers -}}
      {{- if and (hasKey . "number") (hasKey . "size") -}}
      {{- print "gunzip_buffers " .number " " .size ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
