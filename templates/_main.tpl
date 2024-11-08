{{- /*
nginx main context config
*/}}
{{- define "nginx.main" -}}
{{- with .main -}}
{{- with .load_module -}}
  {{- if typeIs "string" . }}
load_module {{ . }};
  {{- else }}
    {{- range . }}
load_module {{ . }};
    {{- end }}
  {{- end }}
{{- end }}
{{- with .user -}}
  {{- if typeIs "string" . }}
user {{ . }};
  {{- else }}
user {{ printf "%s %s" .username (default "" .group) | trim }};
  {{- end }}
{{- end }}
{{- with .worker_cpu_affinity }}
worker_cpu_affinity
  {{- with .auto -}}
    {{- if typeIs "bool" . -}}
{{- printf " %s" "auto" -}}
    {{- end -}}
  {{- end -}}
  {{- with .cpumask -}}
    {{- if typeIs "string" . }}
{{- printf " %s" . -}}
    {{- else -}}
    {{- range . -}}{{- printf " %s" . -}}{{- end -}}
    {{- end -}}
  {{- end -}}
;
{{- end }}
{{- if hasKey . "worker_priority" }}
worker_priority {{ .worker_priority }};
{{- end }}
{{- if and (hasKey . "worker_processes") (or (typeIs "float64" .worker_processes) (eq (.worker_processes | toString) "auto"))}}
worker_processes {{ .worker_processes }};
{{- end }}
{{- if hasKey . "worker_rlimit_core" }}
worker_rlimit_core {{ .worker_rlimit_core }};
{{- end }}
{{- if and (hasKey . "worker_rlimit_nofile") (typeIs "float64" .worker_rlimit_nofile) }}
worker_rlimit_nofile {{ .worker_rlimit_nofile | int }};
{{- end }}
{{- if hasKey . "worker_shutdown_timeout" }}
worker_shutdown_timeout {{ .worker_shutdown_timeout }};
{{- end }}
{{- with .error_log }}
  {{- if kindIs "slice" . }}
    {{- range . }}
error_log {{ if typeIs "string" . }}{{ . }}{{ else }}{{ .file }}{{- if hasKey . "level"}}{{ printf " %s" (.level | toString) }}{{- end }}{{- end }};
    {{- end }}
  {{- else if typeIs "string" . }}
error_log {{ . }};
  {{- else }}
error_log {{ .file }}{{- if hasKey . "level"}}{{ printf " %s" (.level | toString) }}{{- end }};
  {{- end }}
{{- end }}
{{- if hasKey . "pid" }}
pid {{ .pid }};
{{- end }}
{{- if and (hasKey . "daemon") (kindIs "bool" .daemon) }}
daemon {{ .daemon | ternary "on" "off" }};
{{- end }}
{{- if and (hasKey . "debug_points") (has .debug_points (list "abort" "stop")) }}
debug_points {{ .debug_points }};
{{- end }}
{{- with .env }}
  {{- if kindIs "slice" . }}
    {{- range . }}
env {{ if typeIs "string" . }}{{ . }}{{ else }}{{ .variable }}{{- if hasKey . "value"}}{{ printf "=%s" (.value | toString) }}{{- end }}{{- end }};
    {{- end }}
  {{- else if typeIs "string" . }}
env {{ . }};
  {{- else }}
env {{ .variable }}{{- if hasKey . "value"}}{{ printf "=%s" (.value | toString) }}{{- end }};
  {{- end }}
{{- end }}
{{- if hasKey . "lock_file" }}
lock_file {{ .lock_file }};
{{- end }}
{{- if and (hasKey . "master_process") (kindIs "bool" .master_process) }}
master_process {{ .master_process | ternary "on" "off" }};
{{- end }}
{{- if and (hasKey . "pcre_jit") (kindIs "bool" .pcre_jit) }}
pcre_jit {{ .pcre_jit | ternary "on" "off" }};
{{- end }}
{{- if hasKey . "ssl_engine" }}
ssl_engine {{ .ssl_engine }};
{{- end }}
{{- if and (hasKey . "thread_pool") (not (kindIs "string" .thread_pool)) }}
  {{- if kindIs "slice" .thread_pool }}
    {{- range .thread_pool }}
thread_pool {{ .name }}{{ if typeIs "float64" .threads }}{{ printf " threads=%d" (.threads | int) }}{{- end }}{{ if and (hasKey . "max_queue") (typeIs "float64" .max_queue) }}{{ printf " max_queue=%d" (.max_queue | int) }}{{- end }};
    {{- end }}
  {{- else }}
thread_pool {{ .thread_pool.name }}{{ if typeIs "float64" .thread_pool.threads }}{{ printf " threads=%d" (.thread_pool.threads | int) }}{{- end }}{{ if and (hasKey .thread_pool "max_queue") (typeIs "float64" .thread_pool.max_queue) }}{{ printf " max_queue=%d" (.thread_pool.max_queue | int) }}{{- end }};
  {{- end }}
{{- end }}
{{- if hasKey . "timer_resolution" }}
timer_resolution {{ .timer_resolution }};
{{- end }}
{{- if hasKey . "working_directory" }}
working_directory {{ .working_directory }};
{{- end }}
{{- end }}
{{- with .quic }}
{{- include "nginx.quic" (dict "directives" . "scope" "global" ) -}}
{{- end }}
{{- with .include }}
  {{- if typeIs "string" . }}
include {{ . }};
  {{- else if kindIs "slice" . }}
    {{- range . }}
include {{ . }};
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
