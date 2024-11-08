{{- /* ngx_http_map_module */ -}}
{{- define "nginx.ngx_http_map_module" -}}
  {{- $scope := .scope -}}
  {{- /* 'map' module is only available in the 'http' context */ -}}
  {{- if eq $scope "http" -}}
    {{- with .directives -}}
      {{- if hasKey . "hash_bucket_size" -}}
        {{- print "map_hash_bucket_size " .hash_bucket_size ";" | nindent 0 -}}
      {{- end -}}
      {{- if hasKey . "hash_max_size" -}}
        {{- print "map_hash_max_size " .hash_max_size ";" | nindent 0 -}}
      {{- end -}}
      {{- with .mappings -}}
        {{- range . -}}
          {{- if and (hasKey . "string") (hasKey . "variable") -}}
            {{- print "map " .string " " .variable " {" | nindent 0 -}}
              {{- if and (hasKey . "hostnames") (kindIs "bool" .hostnames) .hostnames -}}
                {{- print "hostnames;" | nindent 2 -}}
              {{- end -}}
              {{- if and (hasKey . "volatile") (kindIs "bool" .volatile) .volatile -}}
                {{- print "volatile;" | nindent 2 -}}
              {{- end -}}
              {{- if hasKey . "content" -}}
                {{- if kindIs "slice" .content -}}
                  {{- range .content -}}
                    {{- print .value " " .new_value ";" | nindent 2 -}}
                  {{- end -}}
                {{- else if kindIs "map" .content -}}
                  {{- print .content.value " " .content.new_value ";" | nindent 2 -}}
                {{- end -}}
              {{- end -}}
            {{- print "}" | nindent 0 -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
