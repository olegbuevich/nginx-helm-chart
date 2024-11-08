{{- /* ngx_http_limit_req_module */ -}}
{{- define "nginx.ngx_http_limit_req_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- with .limit_reqs -}}
      {{- range . -}}
        {{- print "limit_req" | nindent 0 -}}
        {{- print " zone=" .zone -}}
        {{- if hasKey . "burst" -}}{{- print " burst=" .burst -}}{{- end -}}
        {{- if hasKey . "delay" -}}
          {{- if and (kindIs "bool" .delay) (not .delay) -}}{{- print " nodelay" -}}{{- else -}}{{- print " delay=" .delay -}}{{- end -}}
        {{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "dry_run") (kindIs "bool" .dry_run) -}}
      {{- print "limit_req_dry_run " (.dry_run | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "log_level" -}}
      {{- print "limit_req_log_level " .log_level ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "status" -}}
      {{- print "limit_req_status " .status ";" | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' context */ -}}
    {{- if and (hasKey . "zones") (eq $scope "http") -}}
      {{ range .zones }}
        {{- print "limit_req_zone" | nindent 0 -}}
        {{- print " " .key -}}
        {{- print " zone=" .name ":" .size -}}
        {{- print " rate=" .rate -}}
        {{- if and (hasKey . "sync") (kindIs "bool" .sync) .sync -}}{{- print " sync" -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
