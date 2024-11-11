{{- /*
nginx core functionality
*/}}
{{- define "nginx.core" -}}
  {{- $scope := .scope -}}
  {{- with .directives -}}
    {{- with .load_module -}}
      {{- if typeIs "string" . -}}
        {{- print "load_module " . ";" | nindent 0 -}}
      {{- else -}}
        {{- range . -}}
          {{- print "load_module " . ";" | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- with .user -}}
      {{- if typeIs "string" . -}}
        {{- print "user " . ";" | nindent 0 -}}
      {{- else -}}
        {{- print "user " .username | nindent 0 -}}
        {{- if hasKey . "group" -}}{{- print " " .group -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- with .worker_cpu_affinity -}}
      {{- print "worker_cpu_affinity" | nindent 0 -}}
      {{- if and (hasKey . "auto") (kindIs "bool" .auto) .auto -}}{{- print " auto" -}}{{- end -}}
      {{- with .cpumask -}}
        {{- if typeIs "string" . -}}
          {{- print " " . -}}
        {{- else -}}
          {{- range . -}}{{- printf " " . -}}{{- end -}}
        {{- end -}}
      {{- end -}}
      {{- print ";" -}}
    {{- end -}}
    {{- if hasKey . "worker_priority" -}}
      {{- print "worker_priority " .worker_priority ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "worker_processes") (or (typeIs "float64" .worker_processes) (eq (.worker_processes | toString) "auto")) -}}
      {{- print "worker_processes " .worker_processes ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "worker_rlimit_core" -}}
      {{- print "worker_rlimit_core " .worker_rlimit_core ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "worker_rlimit_nofile") (typeIs "float64" .worker_rlimit_nofile) -}}
      {{- print "worker_rlimit_nofile " .worker_rlimit_nofile ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "worker_shutdown_timeout" -}}
      {{- print "worker_shutdown_timeout " .worker_shutdown_timeout ";" | nindent 0 -}}
    {{- end -}}
    {{- with .error_log -}}
      {{- if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "error_log" | nindent 0 -}}
          {{- if typeIs "string" . -}}
            {{- print " " . -}}
          {{- else -}}
            {{- print " " .file -}}
            {{- if hasKey . "level" -}}{{- print " " .level -}}{{- end -}}
          {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if typeIs "string" . -}}
        {{- print "error_log " . ";" | nindent 0 -}}
      {{- else -}}
        {{- print "error_log " .file | nindent 0 -}}
        {{- if hasKey . "level" -}}{{- print " " .level -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- with .events -}}
      {{- print "events {" | nindent 0 -}}
      {{- include "nginx.core_events" . | indent 2 -}}
      {{- print "}" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "pid" -}}
      {{- print "pid " .pid ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "daemon") (kindIs "bool" .daemon) -}}
      {{- print "daemon " (.daemon | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "debug_points") (has .debug_points (list "abort" "stop")) -}}
      {{- print "debug_points " .debug_points ";" | nindent 0 -}}
    {{- end -}}
    {{- with .env -}}
      {{- if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "env" | nindent 0 -}}
          {{- if typeIs "string" . -}}
            {{- print " " . -}}
          {{- else -}}
            {{- print " " .variable -}}
            {{- if hasKey . "value" -}}{{- print " " .value -}}{{- end -}}
          {{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else if typeIs "string" . -}}
        {{- print "env " . ";" | nindent 0 -}}
      {{- else -}}
        {{- print "env " .variable | nindent 0 -}}
        {{- if hasKey . "value" -}}{{- print " " .value -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "lock_file" -}}
      {{- print "lock_file " .lock_file ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "master_process") (kindIs "bool" .master_process) -}}
      {{- print "master_process " (.master_process | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if and (hasKey . "pcre_jit") (kindIs "bool" .pcre_jit) -}}
      {{- print "pcre_jit " (.pcre_jit | ternary "on" "off") ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "ssl_engine" -}}
      {{- print "ssl_engine " .ssl_engine ";" | nindent 0 -}}
    {{- end -}}
    {{- with .thread_pool -}}
      {{- if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "thread_pool " .name | nindent 0 -}}
          {{ if typeIs "float64" .threads -}}{{ print " threads=" .threads -}}{{- end -}}
          {{ if and (hasKey . "max_queue") (typeIs "float64" .max_queue) -}}{{ print " max_queue=" .max_queue -}}{{- end -}}
          {{- print ";" -}}
        {{- end -}}
      {{- else -}}
        {{- print "thread_pool " .name | nindent 0 -}}
        {{ if typeIs "float64" .threads -}}{{ print " threads=" .threads -}}{{- end -}}
        {{ if and (hasKey . "max_queue") (typeIs "float64" .max_queue) -}}{{ print " max_queue=" .max_queue -}}{{- end -}}
        {{- print ";" -}}
      {{- end -}}
    {{- end -}}
    {{- if hasKey . "timer_resolution" -}}
      {{- print "timer_resolution " .timer_resolution ";" | nindent 0 -}}
    {{- end -}}
    {{- if hasKey . "working_directory" -}}
      {{- print "working_directory " .working_directory ";" | nindent 0 -}}
    {{- end -}}
    {{- with .include -}}
      {{- if typeIs "string" . -}}
        {{- print "include " . ";" | nindent 0 -}}
      {{- else if kindIs "slice" . -}}
        {{- range . -}}
          {{- print "include " . ";" | nindent 0 -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
