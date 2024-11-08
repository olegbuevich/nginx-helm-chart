{{- /* ngx_http_autoindex_module */ -}}
{{- define "nginx.ngx_http_autoindex_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if and (hasKey . "enable") (kindIs "bool" .enable) -}}
      {{- print "autoindex " (.enable | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "exact_size") (kindIs "bool" .exact_size) -}}
      {{- print "autoindex_exact_size " (.exact_size | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "format" -}}
      {{- print "autoindex_format " .format ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "localtime") (kindIs "bool" .localtime) -}}
      {{- print "autoindex_localtime " (.localtime | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
