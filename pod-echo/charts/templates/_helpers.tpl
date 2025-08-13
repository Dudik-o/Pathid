{{- define "pod-echo.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "pod-echo.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "pod-echo.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "pod-echo.labels" -}}
app.kubernetes.io/name: {{ include "pod-echo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default .Chart.Version }}
app.kubernetes.io/part-of: {{ include "pod-echo.name" . }}
{{- end -}}
