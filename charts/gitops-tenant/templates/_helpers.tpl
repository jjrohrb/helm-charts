{{/*
Expand the name of the chart.
*/}}
{{- define "gitops-tenant.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gitops-tenant.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.gitops-name" -}}
{{- if .Values.gitopsNamespace.nameOverride }}
{{- .Values.gitopsNamespace.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "gitops"  }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.dev-name" -}}
{{- if .Values.devNamespace.nameOverride }}
{{- .Values.devNamespace.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "dev"  }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.test-name" -}}
{{- if .Values.testNamespace.nameOverride }}
{{- .Values.testNamespace.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "test"  }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.prod-name" -}}
{{- if .Values.prodNamespace.nameOverride }}
{{- .Values.prodNamespace.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "prod"  }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.pipelines-name" -}}
{{- if .Values.pipelinesNamespace.nameOverride }}
{{- .Values.pipelinesNamespace.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "pipelines"  }}
{{- end }}
{{- end }}

{{- define "gitops-tenant.admin-group" -}}
{{- if .Values.adminGroup.nameOverride }}
{{- .Values.adminGroup.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $fullname := include "gitops-tenant.fullname" . }}
{{- printf "%s-%s"  $fullname "admins"  }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gitops-tenant.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gitops-tenant.labels" -}}
helm.sh/chart: {{ include "gitops-tenant.chart" . }}
{{ include "gitops-tenant.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gitops-tenant.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gitops-tenant.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gitops-tenant.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gitops-tenant.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
