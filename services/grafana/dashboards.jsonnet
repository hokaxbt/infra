local k8s = import 'github.com/jsonnet-libs/k8s-libsonnet/1.32/main.libsonnet';
local configMap = k8s.core.v1.configMap;
local kubernetes = import 'kubernetes-mixin/mixin.libsonnet';

local kubedashboard = kubernetes {
  _config+:: {
    clusterName: 'hoka',
    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    cadvisorSelector: 'job="kubernetes-cadvisor"',
    nodeExporterSelector: 'job="kubernetes-node-exporter"',
    kubeletSelector: 'job="integrations/kubernetes/kubelet"',
    grafanaK8s+:: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['kubernetes', 'infrastucture'],
    },
  },
};

local namespace = 'monitoring';
local data = [
  {
    id: 'kubelet',
    dashboard: kubedashboard.grafanaDashboards['kubelet.json'],
  },
];

local dashboards = {
  [row.id + '.yaml']: std.manifestYamlDoc(
    configMap.new(
      name='grafana-dashboard-' + row.id,
      data={ [row.id + '.json']: std.manifestJson(row.dashboard) }
    ) + configMap.metadata.withLabels({ grafana_dashboard: '1' }) + configMap.metadata.withNamespace(namespace),
    indent_array_in_object=true,
    quote_keys=false
  )

  for row in data
};

dashboards
