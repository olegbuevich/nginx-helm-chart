{{- /* ngx_http_auth_basic_module */ -}}
{{- define "nginx.http_auth_basic" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "realm" -}}
      {{- print "auth_basic" | nindent 0 -}}
      {{- if and (kindIs "bool" .realm) (not .realm) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- print " " .realm -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "user_file" -}}
      {{- print "auth_basic_user_file " .user_file ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- /* ngx_http_auth_request_module */ -}}
{{- define "nginx.http_auth_request" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "uri" -}}
      {{- print "auth_request" | nindent 0 -}}
      {{- if and (kindIs "bool" .uri) (not .uri) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- print " " .uri -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- with .set -}}
      {{- if and (hasKey . "variable") (hasKey . "value") -}}
      {{- print "auth_request_set " .variable " " .value ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
