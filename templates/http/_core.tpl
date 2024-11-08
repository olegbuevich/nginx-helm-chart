{{- /* ngx_http_core_module */}}
{{- define "nginx.ngx_http_core_module" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- if and (hasKey . "absolute_redirect") (kindIs "bool" .absolute_redirect) -}}
    {{- printf "absolute_redirect %s;" (.absolute_redirect | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "aio" -}}
    {{- print "aio" | nindent 0 -}}
    {{- if kindIs "bool" .aio -}}{{- printf " %s" (.aio | ternary "on" "off") -}}{{- end -}}
    {{- if hasKey .aio "threads" -}}
    {{- if and (kindIs "bool" .aio.threads) .aio.threads -}}{{- print " threads" -}}{{- end -}}
    {{- if not (kindIs "bool" .aio.threads) -}}{{- printf " threads=%s" (.aio.threads | toString) -}}{{- end -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "aio_write") (kindIs "bool" .aio_write) -}}
    {{- printf "aio_write %s;" (.aio_write | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'location' context */ -}}
    {{- if and (hasKey . "alias") (eq $scope "location") -}}
    {{- printf "alias %s;" .alias | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "auth_delay" -}}
    {{- printf "auth_delay %s;" .auth_delay | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "chunked_transfer_encoding") (kindIs "bool" .chunked_transfer_encoding) -}}
    {{- printf "chunked_transfer_encoding %s;" (.chunked_transfer_encoding | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "client_body_buffer_size" -}}
    {{- printf "client_body_buffer_size %s;" .client_body_buffer_size | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "client_body_in_file_only" -}}
    {{- print "client_body_in_file_only" | nindent 0 -}}
    {{- if kindIs "bool" .client_body_in_file_only -}}
    {{- printf " %s" (.client_body_in_file_only | ternary "on" "off") -}}
    {{- else if eq "clean" .client_body_in_file_only -}}
    {{- print " clean" -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "client_body_in_single_buffer") (kindIs "bool" .client_body_in_single_buffer) -}}
    {{- printf "client_body_in_single_buffer %s;" (.client_body_in_single_buffer | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "client_body_temp_path") (hasKey .client_body_temp_path "path") (hasKey .client_body_temp_path "level") -}}
    {{- printf "client_body_in_single_buffer %s" .client_body_temp_path.path | nindent 0 -}}
    {{- printf " %s" (seq (.client_body_temp_path.level | int)) -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "client_body_timeout" -}}
    {{- printf "client_body_timeout %s;" .client_body_timeout | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */ -}}
    {{- if and (hasKey . "client_header_buffer_size") (not (eq $scope "location")) -}}
    {{- printf "client_header_buffer_size %s;" .client_header_buffer_size | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */ -}}
    {{- if and (hasKey . "client_header_timeout") (not (eq $scope "location")) -}}
    {{- printf "client_header_timeout %s;" .client_header_timeout | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "client_max_body_size" -}}
    {{- printf "client_max_body_size %s;" .client_max_body_size | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */ -}}
    {{- if and (hasKey . "connection_pool_size") (not (eq $scope "location")) -}}
    {{- print "connection_pool_size " .connection_pool_size ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "default_type" -}}
    {{- printf "default_type %s;" .default_type | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "directio" -}}
    {{- printf "directio %s;" (.directio | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "directio_alignment" -}}
    {{- printf "directio_alignment %s;" (.directio_alignment | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "disable_symlinks" -}}
    {{- print "disable_symlinks" | nindent 0 -}}
    {{- if kindIs "bool" .disable_symlinks -}}
    {{- printf " %s" (.disable_symlinks | ternary "on" "off") -}}
    {{- else if and (kindIs "string" .disable_symlinks) (has .disable_symlinks (list "on" "if_not_owner")) -}}
    {{- printf " %s" .disable_symlinks -}}
    {{- end -}}
    {{- if kindIs "map" .disable_symlinks -}}
    {{- if and (hasKey .disable_symlinks "check") (has .disable_symlinks.check (list "on" "if_not_owner") ) -}}
    {{- printf " %s" .disable_symlinks.check -}}
    {{- end -}}
    {{- if hasKey .disable_symlinks "from" -}}
    {{- printf " from=%s" .disable_symlinks.from -}}
    {{- end -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "error_page" -}}
    {{- if kindIs "slice" .error_page -}}
    {{- range .error_page -}}
    {{- print "error_page" | nindent 0 -}}
    {{- if kindIs "slice" .code -}}{{- print " " (.code | join " ") -}}{{- else -}}{{- print " " .code -}}{{- end -}}
    {{- if hasKey . "response" -}}{{- print " " .response -}}{{- end -}}
    {{- if hasKey . "uri" -}}{{- print " " .uri -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- else if kindIs "map" .error_page -}}
    {{- print "error_page" | nindent 0 -}}
    {{- if kindIs "slice" .error_page.code -}}{{- print " " (.error_page.code | join " ") -}}{{- else -}}{{- print " " .error_page.code -}}{{- end -}}
    {{- if hasKey .error_page "response" -}}{{- print " " .error_page.response -}}{{- end -}}
    {{- if hasKey .error_page "uri" -}}{{- print " " .error_page.uri -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "etag") (kindIs "bool" .etag) -}}
    {{- printf "etag %s;" (.etag | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "if_modified_since" -}}
    {{- print "if_modified_since" | nindent 0 -}}
    {{- if and (kindIs "bool" .if_modified_since) (not .if_modified_since) -}}
    {{- print " off" -}}
    {{- else -}}
    {{- printf " %s" .if_modified_since -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */ -}}
    {{- if and (hasKey . "ignore_invalid_headers") (kindIs "bool" .ignore_invalid_headers) (not (eq $scope "location")) -}}
    {{- printf "ignore_invalid_headers %s;" (.ignore_invalid_headers | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* This does not belong here but lets keep it to simplify configuration (part of ngx_core_module) */}}
    {{- if hasKey . "include" -}}
    {{- if kindIs "slice" .include -}}
    {{- range .include }}
    {{- printf "include %s;" . | nindent 0 -}}
    {{- end }}
    {{- else }}
    {{- printf "include %s;" .include | nindent 0 -}}
    {{- end }}
    {{- end }}
    {{- /* directive is only available in the 'location' context */ -}}
    {{- if and (eq $scope "location") (hasKey . "internal") (kindIs "bool" .internal) .internal -}}
    {{- print "internal;" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "keepalive_disable" -}}
    {{- print "keepalive_disable" | nindent 0 -}}
    {{- if kindIs "slice" .keepalive_disable -}}{{- print " " (.keepalive_disable | join " ") -}}{{- else -}}{{- print " " .keepalive_disable -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "keepalive_requests") (typeIs "float64" .keepalive_requests) -}}
    {{- printf "keepalive_requests %s;" (.keepalive_requests | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "keepalive_time" -}}
    {{- printf "keepalive_time %s;" .keepalive_time | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "keepalive_timeout" -}}
    {{- print "keepalive_timeout" | nindent 0 -}}
    {{- if kindIs "string" .keepalive_timeout -}}
    {{- printf " %s" .keepalive_timeout -}}
    {{- else -}}
    {{- print " " .keepalive_timeout.timeout -}}
    {{- if hasKey .keepalive_timeout "header_timeout" -}}{{- print " " .keepalive_timeout.header_timeout -}}{{- end -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */ -}}
    {{- if not (eq $scope "location") -}}
      {{- with .large_client_header_buffers -}}
        {{- if and (hasKey . "number") (typeIs "float64" .number) (hasKey . "size") -}}
          {{- printf "large_client_header_buffers %s %s;" (.number | toString) (.size | toString) | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- /* directive is only available in the 'location' context */ -}}
    {{- if eq $scope "location" -}}
      {{- with .limit_except -}}
        {{- print "limit_except" | nindent 0 -}}
        {{- if kindIs "slice" .method -}}{{- print " " (.method | join " ") -}}{{- else -}}{{- print " " .method -}}{{- end -}}
        {{- print " {" -}}
        {{- if kindIs "slice" .directive -}}
          {{- range .directive -}}
            {{- print . ";" | nindent 2 -}}
          {{- end -}}
        {{- else -}}
          {{- print .directive ";" | nindent 2 -}}
        {{- end -}}
        {{- print "}" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "limit_rate" -}}
    {{- printf "limit_rate %s;" (.limit_rate | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "limit_rate_after" -}}
    {{- printf "limit_rate_after %s;" (.limit_rate_after | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "lingering_close" -}}
    {{- print "lingering_close" | nindent 0 -}}
    {{- if kindIs "bool" .lingering_close -}}
    {{- print " " (.lingering_close | ternary "on" "off") -}}
    {{- else if eq "always" .lingering_close -}}
    {{- print " " .lingering_close -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "lingering_time" -}}
    {{- printf "lingering_time %s;" (.lingering_time | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "lingering_timeout" -}}
    {{- printf "lingering_timeout %s;" (.lingering_timeout | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'server' context */ -}}
    {{- if eq $scope "server" -}}
      {{- with .listen -}}
        {{- range . -}}
          {{- print "listen" | nindent 0 -}}
          {{- if hasKey . "address" -}}
            {{- print " " .address -}}
            {{- if hasKey . "port" -}}{{- print ":" .port -}}{{- end -}}
          {{- else if hasKey . "port" -}}
            {{- print " " .port -}}
          {{- end -}}
          {{- if and (hasKey . "default_server") (kindIs "bool" .default_server) .default_server -}}{{- print " default_server" -}}{{- end -}}
          {{- if and (hasKey . "ssl") (kindIs "bool" .ssl) .ssl -}}{{- print " ssl" -}}{{- end -}}
          {{- if and (hasKey . "quic") (kindIs "bool" .quic) .quic -}}{{- print " quic" -}}{{- end -}}
          {{- if and (hasKey . "proxy_protocol") (kindIs "bool" .proxy_protocol) .proxy_protocol -}}{{- print " proxy_protocol" -}}{{- end -}}
          {{- if hasKey . "setfib" -}}{{- print " setfib=" (.setfib | toString) -}}{{- end -}}
          {{- if and (hasKey . "fastopen") (typeIs "float64" .fastopen) -}}{{- print " fastopen=" (.fastopen | toString) -}}{{- end -}}
          {{- if and (hasKey . "backlog") (typeIs "float64" .backlog) -}}{{- print " backlog=" (.backlog | toString) -}}{{- end -}}
          {{- if hasKey . "rcvbuf" -}}{{- print " rcvbuf=" (.rcvbuf | toString) -}}{{- end -}}
          {{- if hasKey . "sndbuf" -}}{{- print " sndbuf=" (.sndbuf | toString) -}}{{- end -}}
          {{- if hasKey . "accept_filter" -}}{{- print " accept_filter=" (.accept_filter | toString) -}}{{- end -}}
          {{- if and (hasKey . "deferred") (kindIs "bool" .deferred) .deferred -}}{{- print " deferred" -}}{{- end -}}
          {{- if and (hasKey . "bind") (kindIs "bool" .bind) .bind -}}{{- print " bind" -}}{{- end -}}
          {{- if and (hasKey . "ipv6only") (kindIs "bool" .ipv6only) -}}{{- print " ipv6only=" (.ipv6only | ternary "on" "off") -}}{{- end -}}
          {{- if and (hasKey . "reuseport") (kindIs "bool" .reuseport) .reuseport -}}{{- print " reuseport" -}}{{- end -}}
          {{- if and (hasKey . "so_keepalive") (not (and (hasKey . "quic") (kindIs "bool" .quic) .quic)) -}}
            {{- print " so_keepalive=" -}}
            {{- if kindIs "bool" .so_keepalive -}}
              {{- print (.so_keepalive | ternary "on" "off") -}}
            {{- else if kindIs "map" .so_keepalive -}}
              {{- with .so_keepalive -}}
                {{- if hasKey . "keepidle" -}}{{- print (.keepidle | toString) -}}{{- end -}}
                {{- print ":" -}}
                {{- if hasKey . "keepintvl" -}}{{- print (.keepintvl | toString) -}}{{- end -}}
                {{- print ":" -}}
                {{- if hasKey . "keepcnt" -}}{{- print (.keepcnt | toString) -}}{{- end -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "log_not_found") (kindIs "bool" .log_not_found) -}}
    {{- printf "log_not_found %s;" (.log_not_found | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "log_subrequest") (kindIs "bool" .log_subrequest) -}}
    {{- printf "log_subrequest %s;" (.log_subrequest | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "max_ranges") (typeIs "float64" .max_ranges) -}}
    {{- printf "max_ranges %s;" (.max_ranges | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'location' context */ -}}
    {{- if and (eq $scope "location") (hasKey . "merge_slashes") (kindIs "bool" .merge_slashes) -}}
    {{- printf "merge_slashes %s;" (.merge_slashes | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "msie_padding") (kindIs "bool" .msie_padding) -}}
    {{- printf "msie_padding %s;" (.msie_padding | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "msie_refresh") (kindIs "bool" .msie_refresh) -}}
    {{- printf "msie_refresh %s;" (.msie_refresh | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "open_file_cache" -}}
    {{- print "open_file_cache" | nindent 0 -}}
    {{- if and (kindIs "bool" .open_file_cache) (not .open_file_cache) -}}
    {{- print " off" -}}
    {{- else if kindIs "map" .open_file_cache -}}
    {{- with .open_file_cache -}}
    {{- print " max=" (.max | toString) -}}
    {{- if hasKey . "inactive" -}}{{- print " inactive=" (.inactive | toString) -}}{{- end -}}
    {{- end -}}
    {{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "open_file_cache_errors") (kindIs "bool" .open_file_cache_errors) -}}
    {{- printf "open_file_cache_errors %s;" (.open_file_cache_errors | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "open_file_cache_min_uses") (typeIs "float64" .open_file_cache_min_uses) -}}
    {{- printf "open_file_cache_min_uses %s;" (.open_file_cache_min_uses | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "open_file_cache_valid" -}}
    {{- printf "open_file_cache_valid %s;" (.open_file_cache_valid | toString) | nindent 0 -}}
    {{- end -}}
    {{- with .output_buffers -}}
    {{- printf "output_buffers %s %s;" (.number | toString) (.size | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "port_in_redirect") (kindIs "bool" .port_in_redirect) -}}
    {{- printf "port_in_redirect %s;" (.port_in_redirect | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "postpone_output" -}}
    {{- printf "postpone_output %s;" (.postpone_output | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "read_ahead" -}}
    {{- printf "read_ahead %s;" (.read_ahead | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "recursive_error_pages") (kindIs "bool" .recursive_error_pages) -}}
    {{- printf "recursive_error_pages %s;" (.recursive_error_pages | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */}}
    {{- if and (not (eq $scope "location")) (hasKey . "request_pool_size") -}}
    {{- printf "request_pool_size %s;" (.request_pool_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "reset_timedout_connection") (kindIs "bool" .reset_timedout_connection) -}}
    {{- printf "reset_timedout_connection %s;" (.reset_timedout_connection | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- with .resolver -}}
    {{- print "resolver" | nindent 0 -}}
    {{- if kindIs "slice" .address -}}{{- print " " (.address | join " ") -}}{{- else -}}{{- print " " .address -}}{{- end -}}
    {{- if hasKey . "valid" -}}{{- print " valid=" (.valid | toString) -}}{{- end -}}
    {{- if and (hasKey . "ipv6") (kindIs "bool" .ipv6) -}}{{- print " ipv6=" (.ipv6 | ternary "on" "off") -}}{{- end -}}
    {{- if hasKey . "status_zone" -}}{{- print " status_zone=" (.status_zone | toString) -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "resolver_timeout" -}}
    {{- printf "resolver_timeout %s;" (.resolver_timeout | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "root" -}}
    {{- printf "root %s;" (.root | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* This does not belong here but lets keep it to simplify configuration (part of ngx_http_index_module) */}}
    {{- if hasKey . "index" -}}
    {{- printf "index %s;" (.root | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "satisfy") (has .satisfy (list "all" "any")) -}}
    {{- printf "satisfy %s;" .satisfy | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "send_lowat" -}}
    {{- printf "send_lowat %s;" (.send_lowat | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "send_timeout" -}}
    {{- printf "send_timeout %s;" (.send_timeout | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "sendfile") (kindIs "bool" .sendfile) -}}
    {{- printf "sendfile %s;" (.sendfile | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "sendfile_max_chunk" -}}
    {{- printf "sendfile_max_chunk %s;" (.sendfile_max_chunk | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'server' context */}}
    {{- if and (eq $scope "server") (hasKey . "server_name") -}}
    {{- print "server_name" | nindent 0 -}}
    {{- if kindIs "slice" .server_name -}}{{- print " " (.server_name | join " ") -}}{{- else -}}{{- print " " .server_name -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- if and (hasKey . "server_name_in_redirect") (kindIs "bool" .server_name_in_redirect) -}}
    {{- printf "server_name_in_redirect %s;" (.server_name_in_redirect | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' context */}}
    {{- if and (eq $scope "http") (hasKey . "server_names_hash_bucket_size") -}}
    {{- printf "server_names_hash_bucket_size %s;" (.server_names_hash_bucket_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' context */}}
    {{- if and (eq $scope "http") (hasKey . "server_names_hash_max_size") -}}
    {{- printf "server_names_hash_max_size %s;" (.server_names_hash_max_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "server_tokens" -}}
    {{- if kindIs "bool" .server_tokens -}}
    {{- printf "server_tokens %s;" (.server_tokens | ternary "on" "off") | nindent 0 -}}
    {{- else -}}
    {{- printf "server_tokens %s;" (.server_tokens | toString) | nindent 0 -}}
    {{- end -}}
    {{- end -}}
    {{- if hasKey . "subrequest_output_buffer_size" -}}
    {{- printf "subrequest_output_buffer_size %s;" (.subrequest_output_buffer_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "tcp_nodelay") (kindIs "bool" .tcp_nodelay) -}}
    {{- printf "tcp_nodelay %s;" (.tcp_nodelay | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "tcp_nopush") (kindIs "bool" .tcp_nopush) -}}
    {{- printf "tcp_nopush %s;" (.tcp_nopush | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'http' context */}}
    {{- if not (eq $scope "http") -}}
      {{- with .try_files -}}
        {{- print "try_files" | nindent 0 -}}
        {{- if kindIs "slice" .files -}}{{- print " " (.files | join " ") -}}{{- else -}}{{- print " " .files -}}{{- end -}}
        {{- if hasKey . "uri" -}}
          {{- print " " .uri -}}
        {{- else if hasKey . "code" -}}
          {{- print " " .code -}}
        {{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if and (hasKey . "types") (or (kindIs "slice" .types) (kindIs "map" .types)) -}}
    {{- print "types {" | nindent 0 -}}
    {{- if kindIs "slice" .types -}}
    {{- range .types -}}
    {{- print .mime | nindent 2 -}}
    {{- if kindIs "slice" .extensions -}}{{- print " " (.extensions | join " ") -}}{{- else -}}{{- print " " .extensions -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- else if kindIs "map" .types -}}
    {{- print .types.mime | nindent 2 -}}
    {{- if kindIs "slice" .types.extensions -}}{{- print " " (.types.extensions | join " ") -}}{{- else -}}{{- print " " .types.extensions -}}{{- end -}}
    {{- print ";" -}}
    {{- end -}}
    {{- print "}" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "types_hash_bucket_size" -}}
    {{- printf "types_hash_bucket_size %s;" (.types_hash_bucket_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "types_hash_max_size" -}}
    {{- printf "types_hash_max_size %s;" (.types_hash_max_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is not available in the 'location' context */}}
    {{- if and (not (eq $scope "location")) (hasKey . "underscores_in_headers") (kindIs "bool" .underscores_in_headers) -}}
      {{- printf "underscores_in_headers %s;" (.underscores_in_headers | ternary "on" "off") | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' context */}}
    {{- if and (eq $scope "http") (hasKey . "variables_hash_bucket_size") -}}
      {{- printf "variables_hash_bucket_size %s;" (.variables_hash_bucket_size | toString) | nindent 0 -}}
    {{- end -}}
    {{- /* directive is only available in the 'http' context */}}
    {{- if and (eq $scope "http") (hasKey . "variables_hash_max_size") -}}
      {{- printf "variables_hash_max_size %s;" (.variables_hash_max_size | toString) | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
