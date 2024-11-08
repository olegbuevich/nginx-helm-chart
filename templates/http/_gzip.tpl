{{- /* ngx_http_gzip_module */ -}}
{{- define "nginx.ngx_http_gzip_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if and (hasKey . "enable") (kindIs "bool" .enable) -}}
      {{- print "gzip " (.enable | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- with .buffers -}}
      {{- if and (hasKey . "number") (hasKey . "size") -}}
      {{- print "gzip_buffers " .number " " .size ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "comp_level" -}}
      {{- print "gzip_comp_level " .comp_level ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "disable" -}}
      {{- print "gzip_disable" | nindent 0 -}}
      {{- if kindIs "slice" .disable -}}{{- print " " (.disable | join " ") -}}{{- else -}}{{- print " " .disable -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "http_version" -}}
      {{- print "gzip_http_version " .http_version ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "min_length" -}}
      {{- print "gzip_min_length " .min_length ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "proxied" -}}
      {{- print "gzip_proxied" | nindent 0 -}}
      {{- if and (kindIs "bool" .proxied) (not .proxied) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- if kindIs "slice" .proxied -}}{{- print " " (.proxied | join " ") -}}{{- else -}}{{- print " " .proxied -}}{{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "types" -}}
      {{- print "gzip_types" | nindent 0 -}}
      {{- if kindIs "slice" .types -}}{{- print " " (.types | join " ") -}}{{- else -}}{{- print " " .types -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "vary") (kindIs "bool" .vary) -}}
      {{- print "gzip_vary " (.vary | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
