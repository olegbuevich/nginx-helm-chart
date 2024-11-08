{{- /* ngx_http_ssl_module */}}
{{- define "nginx.ssl" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "buffer_size" -}}
      {{- print "ssl_buffer_size " .buffer_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "certificate" -}}
      {{- if kindIs "slice" .certificate -}}
        {{- range .certificate -}}
          {{- print "ssl_certificate " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .certificate -}}
        {{- print "ssl_certificate " .certificate ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "certificate_key" -}}
      {{- if kindIs "slice" .certificate_key -}}
        {{- range .certificate_key -}}
          {{- print "ssl_certificate_key " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .certificate_key -}}
        {{- print "ssl_certificate_key " .certificate_key ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "ciphers" -}}
      {{- print "ssl_ciphers" | nindent 0 -}}
      {{- if kindIs "slice" .ciphers -}}
        {{- print " " (.ciphers | join ":") -}}
      {{- else if kindIs "string" .ciphers -}}
        {{- print " " .ciphers -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "client_certificate" -}}
      {{- print "ssl_client_certificate " .client_certificate ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "conf_command" -}}
      {{- if kindIs "slice" .conf_command -}}
        {{- range .conf_command -}}
          {{- print "ssl_conf_command " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .conf_command -}}
        {{- print "ssl_conf_command " .conf_command ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "crl" -}}
      {{- print "ssl_crl " .crl ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "dhparam" -}}
      {{- print "ssl_dhparam " .dhparam ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "early_data") (kindIs "bool" .early_data) -}}
      {{- print "ssl_early_data " (.early_data | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ecdh_curve" -}}
      {{- print "ssl_ecdh_curve" | nindent 0 -}}
      {{- if kindIs "slice" .ecdh_curve -}}
        {{- print " " (.ecdh_curve | join ":") -}}
      {{- else if kindIs "string" .ecdh_curve -}}
        {{- print " " .ecdh_curve -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "ocsp" -}}
      {{- print "ssl_ocsp" | nindent 0 -}}
      {{- if kindIs "bool" .ocsp -}}
        {{- print " " (.ocsp | ternary "on" "off") -}}
      {{- else if eq "leaf" .ocsp -}}
        {{- print " " .ocsp -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "ocsp_cache" -}}
      {{- print "ssl_ocsp_cache" | nindent 0 -}}
      {{- if and (kindIs "bool" .ocsp_cache) (not .ocsp_cache) -}}
        {{- print " off" -}}
      {{- else if and (hasKey .ocsp_cache "name") (hasKey .ocsp_cache "size") -}}
        {{- printf " shared:%s:%s" (.ocsp_cache.name | toString) (.ocsp_cache.size | toString) -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "ocsp_responder" -}}
      {{- print "ssl_ocsp_responder " .ocsp_responder ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "password_file" -}}
      {{- print "ssl_password_file " .password_file ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "prefer_server_ciphers") (kindIs "bool" .prefer_server_ciphers) -}}
      {{- print "ssl_prefer_server_ciphers " (.prefer_server_ciphers | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "protocols" -}}
      {{- print "ssl_protocols" | nindent 0 -}}
      {{- if kindIs "slice" .protocols -}}
        {{- print " " (.protocols | join " ") -}}
      {{- else if kindIs "string" .protocols -}}
        {{- print " " .protocols -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "reject_handshake") (kindIs "bool" .reject_handshake) -}}
      {{- print "ssl_reject_handshake " (.reject_handshake | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "session_cache" -}}
      {{- print "ssl_session_cache" | nindent 0 -}}
      {{- if and (kindIs "bool" .session_cache) (not .session_cache) -}}
        {{- print " off" -}}
      {{- else if and (kindIs "string" .session_cache ) (eq .session_cache "none") -}}
        {{- print " none" -}}
      {{- else -}}
        {{- with .session_cache.builtin -}}
          {{- if and (hasKey . "enable") (kindIs "bool" .enable) .enable -}}
            {{- print " builtin" -}}
            {{- if hasKey . "size" -}}{{- print ":" .size -}}{{- end -}}
          {{- end -}}
        {{- end -}}
        {{- with .session_cache.shared -}}
          {{- if and (hasKey . "name") (hasKey . "size") -}}
            {{- printf " shared:%s:%s" (.name | toString) (.size | toString) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "session_ticket_key" -}}
      {{- if kindIs "slice" .session_ticket_key -}}
        {{- range .session_ticket_key -}}
          {{- print "ssl_session_ticket_key " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .session_ticket_key -}}
        {{- print "ssl_session_ticket_key " .session_ticket_key ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "session_tickets") (kindIs "bool" .session_tickets) -}}
      {{- print "ssl_session_tickets " (.session_tickets | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "session_timeout" -}}
      {{- print "ssl_session_timeout " .session_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "stapling") (kindIs "bool" .stapling) -}}
      {{- print "ssl_stapling " (.stapling | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "stapling_file" -}}
      {{- print "ssl_stapling_file " .stapling_file ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "stapling_responder" -}}
      {{- print "ssl_stapling_responder " .stapling_responder ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "stapling_verify") (kindIs "bool" .stapling_verify) -}}
      {{- print "ssl_stapling_verify " (.stapling_verify | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "trusted_certificate" -}}
      {{- print "ssl_trusted_certificate " .trusted_certificate ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "verify_client" -}}
      {{- print "ssl_verify_client" | nindent 0 -}}
      {{- if kindIs "bool" .verify_client -}}
        {{- print " " (.verify_client | ternary "on" "off") -}}
      {{- else if has .verify_client (list "optional" "optional_no_ca") -}}
        {{- print " " .verify_client -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "verify_depth") (kindIs "float64" .verify_depth) -}}
      {{- print "ssl_verify_depth " .verify_depth ";" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- /* END OF MODULE */ -}}
{{- end -}}
