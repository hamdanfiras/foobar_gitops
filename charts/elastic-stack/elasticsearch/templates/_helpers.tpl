{{- define "elasticsearch.name" -}}
elasticsearch
{{- end -}}

{{- define "elasticsearch.fullname" -}}
{{ include "elasticsearch.name" . }}-{{ .Release.Name }}
{{- end -}}
