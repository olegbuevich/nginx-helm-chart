{{- /* ngx_http_proxy_module */}}
{{- define "nginx.http_proxy" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if hasKey . "bind" -}}
      {{- print "proxy_bind" | nindent 0 -}}
      {{- if and (kindIs "bool" .bind) (not .bind) -}}
        {{- print " off" -}}
      {{- else if hasKey .bind "address" -}}
        {{- print " " .bind.address -}}
        {{- if and (hasKey .bind "transparent") (kindIs "bool" .bind.transparent) .bind.transparent -}}
          {{- print " transparent" -}}
        {{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "buffer_size" -}}
      {{- print "proxy_buffer_size " .buffer_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "buffering") (kindIs "bool" .buffering) -}}
      {{- print "proxy_buffering " (.buffering | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- with .buffers -}}
      {{- if and (hasKey . "number") (kindIs "float64" .number) (hasKey . "size") -}}
        {{- print "proxy_buffers " .number " " .size ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "busy_buffers_size" -}}
      {{- print "proxy_busy_buffers_size " .busy_buffers_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache" -}}
      {{- print "proxy_cache" | nindent 0 -}}
      {{- if and (kindIs "bool" .cache) (not .cache) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- print " " .cache -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "cache_background_update") (kindIs "bool" .cache_background_update) -}}
      {{- print "proxy_cache_background_update " (.cache_background_update | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_bypass" -}}
      {{- if kindIs "slice" .cache_bypass -}}
        {{- range .cache_bypass -}}
          {{- print "proxy_cache_bypass" | nindent 0 -}}
          {{- if kindIs "slice" . -}}{{- print " " (. | join " ") -}}{{- else -}}{{- print " " . -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "string" .cache_bypass -}}
        {{- print "proxy_cache_bypass " .cache_bypass ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "cache_convert_head") (kindIs "bool" .cache_convert_head) -}}
      {{- print "proxy_cache_convert_head " (.cache_convert_head | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_key" -}}
      {{- print "proxy_cache_key " .cache_key ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "cache_lock") (kindIs "bool" .cache_lock) -}}
      {{- print "proxy_cache_lock " (.cache_lock | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_lock_age" -}}
      {{- print "proxy_cache_lock_age " .cache_lock_age ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_lock_timeout" -}}
      {{- print "proxy_cache_lock_timeout " .cache_lock_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "cache_max_range_offset") (kindIs "float64" .cache_max_range_offset) -}}
      {{- print "proxy_cache_max_range_offset " .cache_max_range_offset ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_methods" -}}
      {{- print "proxy_cache_methods" | nindent 0 -}}
      {{- if kindIs "slice" .cache_methods -}}{{- print " " (.cache_methods | join " ") -}}{{- else -}}{{- print " " .cache_methods -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "cache_min_uses") (kindIs "float64" .cache_min_uses) -}}
      {{- print "proxy_cache_min_uses " .cache_min_uses ";" | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' contex */ -}}
    {{- if and (hasKey . "cache_path") (eq $scope "http") -}}
      {{- with .cache_path -}}
        {{- range . -}}
          {{- print "proxy_cache_path " .path | nindent 0 -}}
          {{- if hasKey . "levels" -}}{{- print " levels=" .levels -}}{{- end -}}
          {{- if and (hasKey . "use_temp_path") (kindIs "bool" .use_temp_path) -}}{{- print " use_temp_path=" (.use_temp_path | ternary "on" "off") -}}{{- end -}}
          {{- with .keys_zone -}}
            {{- if and (hasKey . "name") (hasKey . "size") -}}{{- print " keys_zone=" .name ":" .size -}}{{- end -}}
          {{- end -}}
          {{- if hasKey . "inactive" -}}{{- print " inactive=" .inactive -}}{{- end -}}
          {{- if hasKey . "max_size" -}}{{- print " max_size=" .max_size -}}{{- end -}}
          {{- if hasKey . "min_free" -}}{{- print " min_free=" .min_free -}}{{- end -}}
          {{- if and (hasKey . "manager_files") (kindIs "float64" .manager_files) -}}{{- print " manager_files=" .manager_files -}}{{- end -}}
          {{- if hasKey . "manager_sleep" -}}{{- print " manager_sleep=" .manager_sleep -}}{{- end -}}
          {{- if hasKey . "manager_threshold" -}}{{- print " manager_threshold=" .manager_threshold -}}{{- end -}}
          {{- if and (hasKey . "loader_files") (kindIs "float64" .loader_files) -}}{{- print " loader_files=" .loader_files -}}{{- end -}}
          {{- if hasKey . "loader_sleep" -}}{{- print " loader_sleep=" .loader_sleep -}}{{- end -}}
          {{- if hasKey . "loader_threshold" -}}{{- print " loader_threshold=" .loader_threshold -}}{{- end -}}
          {{- if and (hasKey . "purger") (kindIs "bool" .purger) -}}{{- print " purger=" (.purger | ternary "on" "off") -}}{{- end -}}
          {{- if and (hasKey . "purger_files") (kindIs "float64" .purger_files) -}}{{- print " purger_files=" .purger_files -}}{{- end -}}
          {{- if hasKey . "purger_sleep" -}}{{- print " purger_sleep=" .purger_sleep -}}{{- end -}}
          {{- if hasKey . "purger_threshold" -}}{{- print " purger_threshold=" .purger_threshold -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "cache_purge" -}}
      {{- print "proxy_cache_purge" | nindent 0 -}}
      {{- if kindIs "slice" .cache_purge -}}{{- print " " (.cache_purge | join " ") -}}{{- else -}}{{- print " " .cache_purge -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "cache_revalidate") (kindIs "bool" .cache_revalidate) -}}
      {{- print "proxy_cache_revalidate " (.cache_revalidate | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cache_use_stale" -}}
      {{- print "proxy_cache_use_stale" | nindent 0 -}}
      {{- if and (kindIs "bool" .cache_use_stale) (not .cache_use_stale) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- if kindIs "slice" .cache_use_stale -}}{{- print " " (.cache_use_stale | join " ") -}}{{- else -}}{{- print " " .cache_use_stale -}}{{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- with .cache_valid -}}
      {{- if kindIs "string" . -}}
        {{- print "proxy_cache_valid " . | nindent 0 -}}
      {{- else if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "proxy_cache_valid" | nindent 0 -}}
          {{- if and (kindIs "map" .) (hasKey . "code") -}}
            {{- if or (kindIs "float64" .code) (eq .code "any") -}}
              {{- print " " .code -}}
            {{- else -}}
              {{- print " " (.code | join " ") -}}
            {{- end -}}
          {{- end -}}
          {{- if kindIs "string" . -}}
            {{- print " " . -}}
          {{- else if and (kindIs "map" .) (hasKey . "time") -}}
            {{- print " " .time -}}
          {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "connect_timeout" -}}
      {{- print "proxy_connect_timeout " .connect_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "cookie_domain" -}}
      {{- if and (kindIs "bool" .cookie_domain) (not .cookie_domain) -}}
        {{- print "proxy_cookie_domain off;" | nindent 0 -}}
      {{- else if kindIs "map" .cookie_domain -}}
        {{- print "proxy_cookie_domain " .cookie_domain.domain " " .cookie_domain.replacement ";" | nindent 0 -}}
      {{- else if kindIs "slice" .cookie_domain -}}
        {{- range .cookie_domain -}}
          {{- print "proxy_cookie_domain " .domain " " .replacement ";" | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "cookie_flags" -}}
      {{- if and (kindIs "bool" .cookie_flags) (not .cookie_flags) -}}
        {{- print "proxy_cookie_flags off;" | nindent 0 -}}
      {{- else if kindIs "map" .cookie_flags -}}
        {{- print "proxy_cookie_flags " .cookie_flags.cookie | nindent 0 -}}
        {{- if kindIs "slice" .cookie_flags.flag -}}{{- print " " (.cookie_flags.flag | join " ") -}}{{- else -}}{{- print " " .cookie_flags.flag -}}{{- end -}}
        {{- print ";" -}}
      {{- else if kindIs "slice" .cookie_flags -}}
        {{- range .cookie_flags -}}
          {{- print "proxy_cookie_flags " .cookie | nindent 0 -}}
          {{- if kindIs "slice" .flag -}}{{- print " " (.flag | join " ") -}}{{- else -}}{{- print " " .flag -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "cookie_path" -}}
      {{- if and (kindIs "bool" .cookie_path) (not .cookie_path) -}}
        {{- print "proxy_cookie_path off;" | nindent 0 -}}
      {{- else if kindIs "map" .cookie_path -}}
        {{- print "proxy_cookie_path " .cookie_path.path " " .cookie_path.replacement ";" | nindent 0 -}}
      {{- else if kindIs "slice" .cookie_path -}}
        {{- range .cookie_path -}}
          {{- print "proxy_cookie_path " .path " " .replacement ";" | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "force_ranges") (kindIs "bool" .force_ranges) -}}
      {{- print "proxy_force_ranges " (.force_ranges | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "headers_hash_bucket_size" -}}
      {{- print "proxy_headers_hash_bucket_size " .headers_hash_bucket_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "headers_hash_max_size" -}}
      {{- print "proxy_headers_hash_max_size " .headers_hash_max_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "hide_header" -}}
      {{- if kindIs "slice" .hide_header -}}
        {{- range .hide_header -}}
          {{- print "proxy_hide_header " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .hide_header -}}
        {{- print "proxy_hide_header " .hide_header ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "http_version") (has (.http_version | toString) (list "1.0" "1.1")) -}}
      {{- print "proxy_http_version " .http_version ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "ignore_client_abort") (kindIs "bool" .ignore_client_abort) -}}
      {{- print "proxy_ignore_client_abort " (.ignore_client_abort | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "ignore_headers") (has .ignore_headers (list "X-Accel-Redirect" "X-Accel-Expires" "X-Accel-Limit-Rate" "X-Accel-Buffering" "X-Accel-Charset" "Expires" "Cache-Control" "Set-Cookie" "Vary")) -}}
      {{- print "proxy_ignore_headers " .ignore_headers ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "intercept_errors") (kindIs "bool" .intercept_errors) -}}
      {{- print "proxy_intercept_errors " (.intercept_errors | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "limit_rate" -}}
      {{- print "proxy_limit_rate " .limit_rate ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "max_temp_file_size" -}}
      {{- print "proxy_max_temp_file_size " .max_temp_file_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "method" -}}
      {{- print "proxy_method " .method ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "next_upstream" -}}
      {{- print "proxy_next_upstream" | nindent 0 -}}
      {{- if and (kindIs "bool" .next_upstream) (not .next_upstream) -}}
        {{- print " off" -}}
      {{- else -}}
        {{- if kindIs "slice" .next_upstream -}}{{- print " " (.next_upstream | join " ") -}}{{- else -}}{{- print " " .next_upstream -}}{{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "next_upstream_timeout" -}}
      {{- print "proxy_next_upstream_timeout " .next_upstream_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "next_upstream_tries") (kindIs "float64" .next_upstream_tries) -}}
      {{- print "proxy_next_upstream_tries " .next_upstream_tries ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "no_cache" -}}
      {{- if kindIs "slice" .no_cache -}}
        {{- range .no_cache -}}
          {{- print "proxy_no_cache" | nindent 0 -}}
          {{- if kindIs "slice" . -}}{{- print " " (. | join " ") -}}{{- else -}}{{- print " " . -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if kindIs "string" .no_cache -}}
        {{- print "proxy_no_cache " .no_cache ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- /* directive is only available in the 'location' context */ -}}
    {{- if and (hasKey . "pass") (eq $scope "location") -}}
      {{- print "proxy_pass " .pass ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "pass_header" -}}
      {{- if kindIs "slice" .pass_header -}}
        {{- range .pass_header -}}
          {{- print "proxy_pass_header " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .pass_header -}}
        {{- print "proxy_pass_header " .pass_header ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "pass_request_body") (kindIs "bool" .pass_request_body) -}}
      {{- print "proxy_pass_request_body " (.pass_request_body | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "pass_request_headers") (kindIs "bool" .pass_request_headers) -}}
      {{- print "proxy_pass_request_headers " (.pass_request_headers | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "read_timeout" -}}
      {{- print "proxy_read_timeout " .read_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "redirect" -}}
      {{- if and (kindIs "bool" .redirect) (not .redirect) -}}
        {{- print "proxy_redirect off;" | nindent 0 -}}
      {{- else if and (kindIs "string" .redirect) (eq .redirect "default" ) -}}
        {{- print "proxy_redirect default;" | nindent 0 -}}
      {{- else if kindIs "map" .redirect -}}
        {{- print "proxy_redirect" | nindent 0 -}}
        {{- if and (hasKey .redirect "original") (hasKey .redirect "replacement") -}}{{- print " " .redirect.original " " .redirect.replacement -}}{{- end -}}
        {{- print ";" -}}
      {{- else if kindIs "slice" .redirect -}}
        {{- range .redirect -}}
          {{- print "proxy_redirect" | nindent 0 -}}
          {{- if and (kindIs "string" .) (eq . "default") -}}
            {{- print " " . -}}
          {{ else if kindIs "map" . }}
            {{- if and (hasKey . "original") (hasKey . "replacement") -}}{{- print " " .original " " .replacement -}}{{- end -}}
          {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "request_buffering") (kindIs "bool" .request_buffering) -}}
      {{- print "proxy_request_buffering " (.request_buffering | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "send_lowat" -}}
      {{- print "proxy_send_lowat " .send_lowat ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "send_timeout" -}}
      {{- print "proxy_send_timeout " .send_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "set_body" -}}
      {{- print "proxy_set_body " .set_body ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "set_header" -}}
      {{- if kindIs "slice" .set_header -}}
        {{- range .set_header -}}
          {{- print "proxy_set_header " .field " " .value ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "map" .set_header -}}
        {{- print "proxy_set_header " .set_header.field " " .set_header.value ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "socket_keepalive") (kindIs "bool" .socket_keepalive) -}}
      {{- print "proxy_socket_keepalive " (.socket_keepalive | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_certificate" -}}
      {{- print "proxy_ssl_certificate " .ssl_certificate ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_certificate_key" -}}
      {{- print "proxy_ssl_certificate_key " .ssl_certificate_key ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_ciphers" -}}
      {{- print "proxy_ssl_ciphers" | nindent 0 -}}
      {{- if kindIs "slice" .ssl_ciphers -}}
        {{- print " " (.ssl_ciphers | join ":") -}}
      {{- else if kindIs "string" .ssl_ciphers -}}
        {{- print " " .ssl_ciphers -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "ssl_conf_command" -}}
      {{- if kindIs "slice" .ssl_conf_command -}}
        {{- range .ssl_conf_command -}}
          {{- print "proxy_ssl_conf_command " . ";" | nindent 0 -}}
        {{- end -}}
      {{- else if kindIs "string" .ssl_conf_command -}}
        {{- print "proxy_ssl_conf_command " .ssl_conf_command ";" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "ssl_crl" -}}
      {{- print "proxy_ssl_crl " .ssl_crl ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_name" -}}
      {{- print "proxy_ssl_name " .ssl_name ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_password_file" -}}
      {{- print "proxy_ssl_password_file " .ssl_password_file ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_protocols" -}}
      {{- print "proxy_ssl_protocols" | nindent 0 -}}
      {{- if kindIs "slice" .ssl_protocols -}}
        {{- print " " (.ssl_protocols | join " ") -}}
      {{- else if kindIs "string" .ssl_protocols -}}
        {{- print " " .ssl_protocols -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "ssl_server_name") (kindIs "bool" .ssl_server_name) -}}
      {{- print "proxy_ssl_server_name " (.ssl_server_name | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "ssl_session_reuse") (kindIs "bool" .ssl_session_reuse) -}}
      {{- print "proxy_ssl_session_reuse " (.ssl_session_reuse | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_trusted_certificate" -}}
      {{- print "proxy_ssl_trusted_certificate " .ssl_trusted_certificate ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_verify" -}}
      {{- print "proxy_ssl_verify " .ssl_verify ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "ssl_verify_depth") (kindIs "float64" .ssl_verify_depth) -}}
      {{- print "proxy_ssl_verify_depth " .ssl_verify_depth ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "store" -}}
      {{- print "proxy_store" | nindent 0 -}}
      {{- if kindIs "bool" .store -}}{{- print " " (.store | ternary "on" "off") -}}{{- else -}}{{ print " " .store }}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- with .store_access -}}
      {{- print "proxy_store_access" | nindent 0 -}}
      {{- if hasKey . "user" -}}{{- print " user:" .user -}}{{- end -}}
      {{- if hasKey . "group" -}}{{- print " group:" .group -}}{{- end -}}
      {{- if hasKey . "all" -}}{{- print " all:" .all -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "temp_file_write_size" -}}
      {{- print "proxy_temp_file_write_size " .temp_file_write_size ";" | nindent 0 -}}
    {{- end -}}
    {{- with .temp_path -}}
      {{- print "proxy_temp_path " .path | nindent 0 -}}
      {{- if and (hasKey . "level") (kindIs "float64" .level) -}}{{- print " " (seq (.level | int) ) -}}{{- end -}}
      {{- print ";" -}}
    {{- end -}}
  {{- end -}}
{{- /* END OF MODULE */ -}}
{{- end -}}
