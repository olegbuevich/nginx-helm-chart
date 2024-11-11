{{- /* nginx config */ -}}
{{- define "nginx.config" -}}
# managed by HELM
  {{- with .core -}}
    {{- include "nginx.core" (dict "directives" . "scope" "main") | indent 0 -}}
  {{- end -}}
  {{- with .http3 -}}
    {{- include "nginx.ngx_http_v3_module" (dict "directives" . "scope" "main") | indent 0 -}}
  {{- end -}}
  {{- with .http -}}
    {{- print "http {" | nindent 0 -}}
      {{- if hasKey . "include" -}}
        {{- with .include.before -}}
          {{- if kindIs "slice" . -}}
            {{- range . -}}
              {{- print "include " . ";" | nindent 2 -}}
            {{- end -}}
          {{- else -}}
            {{- print "include " . ";" | nindent 2 -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
      {{- include "nginx.http" . | indent 2 -}}
      {{- if hasKey . "include" -}}
        {{- with .include.after -}}
          {{- if kindIs "slice" . -}}
            {{- range . -}}
              {{- print "include " . ";" | nindent 2 -}}
            {{- end -}}
          {{- else -}}
            {{- print "include " . ";" | nindent 2 -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- print "}" | nindent 0 -}}
  {{- end -}}
  {{- with .stream -}}
    {{- print "stream {" | nindent 0 -}}
      {{- if hasKey . "include" -}}
        {{- if kindIs "slice" .include -}}
          {{- range .include -}}
            {{- print "include " . ";" | nindent 2 -}}
          {{- end -}}
        {{- else -}}
          {{- print "include " .include ";" | nindent 2 -}}
        {{- end -}}
      {{- end -}}
    {{- print "}" | nindent 0 -}}
  {{- end -}}
{{- end -}}
