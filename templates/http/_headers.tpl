{{- /* ngx_http_headers_module */ -}}
{{- define "nginx.ngx_http_headers_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "add_headers" -}}
      {{- if kindIs "slice" .add_headers -}}
        {{- range .add_headers -}}
          {{- print "add_header" | nindent 0 -}}
          {{- print " " .name " " .value -}}
          {{- if and (hasKey . "always") (kindIs "bool" .always) .always -}}{{- print " always" -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "string" .add_headers -}}
        {{- print "add_header " .add_headers.name " " .add_headers.value | nindent 0 -}}
        {{- if and (hasKey .add_headers "always") (kindIs "bool" .add_headers.always) .add_headers.always -}}{{- print " always" -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "add_trailers" -}}
      {{- if kindIs "slice" .add_trailers -}}
        {{- range .add_trailers -}}
          {{- print "add_trailer" | nindent 0 -}}
          {{- print " " .name " " .value -}}
          {{- if and (hasKey . "always") (kindIs "bool" .always) .always -}}{{- print " always" -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "string" .add_trailers -}}
        {{- print "add_trailer " .add_trailers.name " " .add_trailers.value | nindent 0 -}}
        {{- if and (hasKey .add_trailers "always") (kindIs "bool" .add_trailers.always) .add_trailers.always -}}{{- print " always" -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "expires" -}}
      {{- print "expires" | nindent 0 -}}
      {{- if and (kindIs "bool" .expires) (not .expires) -}}
        {{- print " off" -}}
      {{- else if kindIs "string" .expires -}}
        {{- print " " .expires -}}
      {{- else -}}
        {{- if and (hasKey .expires "modified") (kindIs "bool" .expires.modified) .expires.modified -}}{{- print " modified" -}}{{- end -}}
        {{- if hasKey .expires "time" -}}{{- print " " .expires.time -}}{{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
