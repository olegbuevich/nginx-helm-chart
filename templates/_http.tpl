{{- /*
generic template for every nginx http config file
*/}}
{{- define "nginx.http_generic_config" -}}
  {{- with .config -}}
    {{- with .upstreams -}}
      {{- include "nginx.http-upstream" . -}}
    {{- end -}}
    {{- with .core -}}
      {{- include "nginx.ngx_http_core_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .http2 -}}
      {{- include "nginx.ngx_http_v2_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .http3 -}}
      {{- include "nginx.ngx_http_v3_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .ssl -}}
      {{- include "nginx.ssl" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .proxy -}}
      {{- include "nginx.http_proxy" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- /*
      # TODO grpc
    */ -}}
    {{- with .access -}}
      {{- include "nginx.http_access" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .auth_basic -}}
      {{- include "nginx.http_auth_basic" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .auth_request -}}
      {{- include "nginx.http_auth_request" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .autoindex -}}
      {{- include "nginx.ngx_http_autoindex_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .gunzip -}}
      {{- include "nginx.ngx_http_gunzip_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .gzip -}}
      {{- include "nginx.ngx_http_gzip_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .headers -}}
      {{- include "nginx.ngx_http_headers_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .limit_req -}}
      {{- include "nginx.ngx_http_limit_req_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .log -}}
      {{- include "nginx.ngx_http_log_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .map -}}
      {{- include "nginx.ngx_http_map_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .realip -}}
      {{- include "nginx.ngx_http_realip_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .rewrite -}}
      {{- include "nginx.ngx_http_rewrite_module" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .custom_directives -}}
      {{- include "nginx.custom_directives" (dict "directives" . "scope" "http") -}}
    {{- end -}}
    {{- with .servers -}}
      {{- range . -}}
        {{- print "server {" | nindent 0 -}}
          {{- with .core -}}
            {{- include "nginx.ngx_http_core_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .http2 -}}
            {{- include "nginx.ngx_http_v2_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .http3 -}}
            {{- include "nginx.ngx_http_v3_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .ssl -}}
            {{- include "nginx.ssl" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .proxy -}}
            {{- include "nginx.http_proxy" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- /*
            # TODO grpc
          */ -}}
          {{- with .access -}}
            {{- include "nginx.http_access" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .auth_basic -}}
            {{- include "nginx.http_auth_basic" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .auth_request -}}
            {{- include "nginx.http_auth_request" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .autoindex -}}
            {{- include "nginx.ngx_http_autoindex_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .gunzip -}}
            {{- include "nginx.ngx_http_gunzip_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .gzip -}}
            {{- include "nginx.ngx_http_gzip_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .headers -}}
            {{- include "nginx.ngx_http_headers_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .limit_req -}}
            {{- include "nginx.ngx_http_limit_req_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .log -}}
            {{- include "nginx.ngx_http_log_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .realip -}}
            {{- include "nginx.ngx_http_realip_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .rewrite -}}
            {{- include "nginx.ngx_http_rewrite_module" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .custom_directives -}}
            {{- include "nginx.custom_directives" (dict "directives" . "scope" "server") | indent 2 -}}
          {{- end -}}
          {{- with .locations -}}
            {{- range . -}}
              {{- print "location " .location " {" | nindent 2 -}}
                {{- with .core -}}
                  {{- include "nginx.ngx_http_core_module" (dict "directives" . "scope" "location") | indent 4 -}}
                {{- end -}}
                {{- with .http2 -}}
                  {{- include "nginx.ngx_http_v2_module" (dict "directives" . "scope" "location") | indent 4 -}}
                {{- end -}}
                {{- with .proxy -}}
                  {{- include "nginx.http_proxy" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- /*
                  # TODO grpc
                */ -}}
                {{- with .access -}}
                  {{- include "nginx.http_access" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .auth_basic -}}
                  {{- include "nginx.http_auth_basic" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .auth_request -}}
                  {{- include "nginx.http_auth_request" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .autoindex -}}
                  {{- include "nginx.ngx_http_autoindex_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .gunzip -}}
                  {{- include "nginx.ngx_http_gunzip_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .gzip -}}
                  {{- include "nginx.ngx_http_gzip_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .headers -}}
                  {{- include "nginx.ngx_http_headers_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .limit_req -}}
                  {{- include "nginx.ngx_http_limit_req_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .log -}}
                  {{- include "nginx.ngx_http_log_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .realip -}}
                  {{- include "nginx.ngx_http_realip_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .rewrite -}}
                  {{- include "nginx.ngx_http_rewrite_module" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
                {{- with .custom_directives -}}
                  {{- include "nginx.custom_directives" (dict "directives" . "scope" "server") | indent 4 -}}
                {{- end -}}
              {{- print "}" | nindent 2 -}}
            {{- end -}}
          {{- end -}}
        {{- print "}" | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
