{{- /* ngx_http_rewrite_module */ -}}
{{- define "nginx.ngx_http_rewrite_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- /* directive is not available in the 'http' context */ -}}
    {{- if and (hasKey . "return") (not (eq $scope "http" )) -}}
      {{- print "return" | nindent 0 -}}
      {{- if and (kindIs "string" .return) (kindIs "float64" .return) -}}
        {{- print " " .return -}}
      {{- else if kindIs "map" .return -}}
        {{- if hasKey .return "code" -}}{{- print " " .return.code -}}{{- end -}}
        {{- if hasKey .return "text" -}}{{- print " " .return.text -}}{{- end -}}
        {{- if hasKey .return "url" -}}{{- print " " .return.url -}}{{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- /* directive is not available in the 'http' context */ -}}
    {{- if and (hasKey . "rewrites") (not (eq $scope "http" )) -}}
      {{- if kindIs "slice" .rewrites -}}
        {{- range .rewrites -}}
          {{- print "rewrite " .regex " " .replacement | nindent 0 -}}
          {{- if and (hasKey . "flag") (has .flag (list "last" "break" "redirect" "permanent")) -}}{{- print " " .flag -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "map" .rewrites -}}
        {{- with .rewrites -}}
          {{- print "rewrite " .regex " " .replacement | nindent 0 -}}
          {{- if and (hasKey . "flag") (has .flag (list "last" "break" "redirect" "permanent")) -}}{{- print " " .flag -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "log") (kindIs "bool" .log) -}}
      {{- print "rewrite_log " (.log | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'http' context */ -}}
    {{- if and (hasKey . "set") (not (eq $scope "http" )) -}}
      {{- if kindIs "slice" .set -}}
        {{- range .set -}}
          {{- print "set " .variable " " .value ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "map" .set -}}
        {{- with .set -}}
          {{- print "set " .variable " " .value ";" | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "uninitialized_variable_warn") (kindIs "bool" .uninitialized_variable_warn) -}}
      {{- print "uninitialized_variable_warn " (.uninitialized_variable_warn | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
