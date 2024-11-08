{{- /* ngx_http_log_module */ -}}
{{- define "nginx.ngx_http_log_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- /* directive is only available in the 'http' context */ -}}
    {{- if and (hasKey . "format") (eq $scope "http") -}}
      {{- range .format -}}
        {{- print "log_format" | nindent 0 -}}
        {{- print " " .name -}}
        {{- if and (hasKey . "escape") (has .escape (list "default" "json" "none")) -}}{{- print " escape=" .escape -}}{{- end -}}
        {{- print " " (.format | squote) -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "access" -}}
      {{- if and (kindIs "bool" .access) (not .access) -}}
        {{- print "access_log off;" | nindent 0 -}}
      {{- else -}}
        {{- range .access -}}
          {{- print "access_log " .path | nindent 0 -}}
          {{- if hasKey . "format" -}}{{- print " " .format -}}{{- end -}}
          {{- if hasKey . "buffer" -}}{{- print " buffer=" .buffer -}}{{- end -}}
          {{- if hasKey . "gzip" -}}
            {{- if kindIs "bool" .gzip -}}
              {{- if .gzip -}}{{- print " gzip" -}}{{- end -}}
            {{- else if kindIs "string" .gzip -}}
              {{- print " gzip=" .gzip -}}
            {{- end -}}
          {{- end -}}
          {{- if hasKey . "flush" -}}{{- print " flush=" .flush -}}{{- end -}}
          {{- if hasKey . "if" -}}{{- print " if=" .if -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- /* This does not belong here but lets keep it to simplify configuration (part of nginx core) */}}
    {{- if hasKey . "error" -}}
      {{- if kindIs "slice" .error -}}
        {{- range .error -}}
          {{- print "error_log" | nindent 0 -}}
            {{- if kindIs "string" .log -}}
              {{- print " " .log -}}
            {{- else -}}
              {{- print " " .log.file -}}
              {{- if hasKey .log "level" -}}{{- print " " .log.level -}}{{- end -}}
            {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "string" .error -}}
        {{- print "error_log " .error ";" | nindent 0 -}}
      {{- else if kindIs "map" .error -}}
        {{- print "error_log " .error.file | nindent 0 -}}
        {{- if hasKey .error "level" -}}{{- print " " .error.level -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "open_log_file_cache" -}}
      {{- print "open_log_file_cache" | nindent 0 -}}
      {{- if kindIs "bool" .open_log_file_cache -}}
        {{- if not .open_log_file_cache -}}
          {{- print " off" -}}
        {{- end -}}
      {{- else -}}
        {{- with .open_log_file_cache -}}
          {{- print " max=" .max -}}
          {{- if hasKey . "inactive" -}}{{- print " inactive=" .inactive -}}{{- end -}}
          {{- if and (hasKey . "min_uses") (kindIs "float64" .min_uses) -}}{{- print " min_uses=" .min_uses -}}{{- end -}}
          {{- if hasKey . "valid" -}}{{- print " valid=" .valid -}}{{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
