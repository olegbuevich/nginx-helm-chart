{{- /* custom directives */ -}}
{{- define "nginx.custom_directives" -}}
  {{- with .directives -}}
    {{- if kindIs "slice" . -}}
      {{- range . -}}
        {{- print . | nindent 0 -}}
      {{- end -}}
    {{- else if kindIs "string" . -}}
      {{- print . | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
