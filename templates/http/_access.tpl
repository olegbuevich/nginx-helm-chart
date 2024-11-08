{{- /* ngx_http_access_module */ -}}
{{- define "nginx.http_access" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- with .allow -}}
      {{- if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "allow " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" . -}}
        {{- print "allow " . ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- with .deny -}}
      {{- if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "deny " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" . -}}
        {{- print "deny " . ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
