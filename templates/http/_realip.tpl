{{- /* ngx_http_realip_module */ -}}
{{- define "nginx.ngx_http_realip_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "set_real_ip_from" -}}
      {{- print "set_real_ip_from " .set_real_ip_from ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "real_ip_header" -}}
      {{- print "real_ip_header " .real_ip_header ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "real_ip_recursive") (kindIs "bool" .real_ip_recursive) -}}
      {{- print "real_ip_recursive " (.real_ip_recursive | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
