{{/*
Expand the name of the chart.
*/}}
{{- define "nginx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nginx.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx.labels" -}}
helm.sh/chart: {{ include "nginx.chart" . }}
{{ include "nginx.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nginx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nginx.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nginx.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "nginx.imageRegistry" -}}
{{- if eq . "" -}}
  {{- print . -}}
{{- else -}}
  {{- printf "%s/" (. | trimSuffix "/") -}}
{{- end -}}
{{- end -}}

{{- define "nginx.containerPorts" -}}
  {{- range ((include "nginx.allContainerPorts" .) | fromYamlArray | uniq) -}}
    {{- print (include "nginx.containerPortTemplate" .) | nindent 0 -}}
  {{- end -}}
{{- end -}}

{{- define "nginx.servicePorts" -}}
  {{- range ((include "nginx.allContainerPorts" .) | fromYamlArray | uniq) -}}
    {{- print (include "nginx.servicePortTemplate" .) | nindent 0 -}}
  {{- end -}}
{{- end -}}

{{- /*
nginx -> http -> config -> servers[]
nginx -> http -> config[] -> servers[]
nginx -> http -> config_files{} -> servers[]
*/ -}}
{{- define "nginx.allContainerPorts" -}}
  {{- with .Values.nginx -}}
    {{- with .http -}}
      {{- with .config -}}
        {{- if kindIs "map" . -}}
          {{- with .servers -}}
            {{- include "nginx.containerPortFromServers" . | indent 2 -}}
          {{- end -}}
        {{- else if kindIs "slice" . -}}
          {{- range . -}}
            {{- with .servers -}}
              {{- include "nginx.containerPortFromServers" . | indent 2 -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
      {{- with .config_files -}}
        {{- range $filename, $content := . }}
          {{- with .config -}}
            {{- if kindIs "map" . -}}
              {{- with .servers -}}
                {{- include "nginx.containerPortFromServers" . | indent 2 -}}
              {{- end -}}
            {{- else if kindIs "slice" . -}}
              {{- range . -}}
                {{- with .servers -}}
                  {{- include "nginx.containerPortFromServers" . | indent 2 -}}
                {{- end -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "nginx.containerPortFromServers" -}}
  {{- range . -}}
    {{- if and (hasKey . "core") (hasKey .core "listen") -}}
      {{- range .core.listen -}}
        {{- if hasKey . "port" -}}{{- print "- " .port | nindent 0 -}}{{- end -}}
      {{- end -}}
    {{- else -}}
      {{- print "- 80" | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- /*  */ -}}
{{- define "nginx.containerPortTemplate" -}}
- name: http{{ . }}
  containerPort: {{ . }}
  protocol: TCP
{{- end -}}

{{- /*  */ -}}
{{- define "nginx.servicePortTemplate" -}}
- name: http{{ . }}
  targetPort: http{{ . }}
  port: {{ . }}
  protocol: TCP
{{- end -}}
