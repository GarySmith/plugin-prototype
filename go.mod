module github.com/airship-ui

go 1.12

require (
	github.com/GeertJohan/go.rice v1.0.0
	github.com/davecgh/go-spew v1.1.1
	github.com/gobwas/glob v0.2.3
	github.com/golang/mock v1.3.1
	github.com/golang/protobuf v1.3.1
	github.com/google/uuid v1.1.0
	github.com/googleapis/gnostic v0.2.0
	github.com/gorilla/handlers v1.4.0
	github.com/gorilla/mux v1.6.2
	github.com/hashicorp/go-hclog v0.8.0
	github.com/hashicorp/go-plugin v0.0.0-20190220160451-3f118e8ee104
	github.com/pkg/errors v0.8.1
	github.com/skratchdot/open-golang v0.0.0-20190402232053-79abb63cd66e
	github.com/spf13/afero v1.2.1
	github.com/spf13/cobra v0.0.3
	github.com/stretchr/testify v1.3.0
	github.com/vmware/octant v0.6.0
	go.opencensus.io v0.19.1
	go.uber.org/zap v1.9.1
	golang.org/x/sync v0.0.0-20190423024810-112230192c58
	google.golang.org/grpc v1.19.0
	k8s.io/api v0.0.0-20190620084959-7cf5895f2711
	k8s.io/apiextensions-apiserver v0.0.0-20181213153335-0fe22c71c476
	k8s.io/apimachinery v0.0.0-20190612205821-1799e75a0719
	k8s.io/client-go v0.0.0-20190620085101-78d2af792bab
	k8s.io/klog v0.3.1
	k8s.io/kubernetes v1.13.2
	k8s.io/utils v0.0.0-20190221042446-c2654d5206da
)

replace (
	git.apache.org/thrift.git => github.com/apache/thrift v0.12.0
	k8s.io/client-go => k8s.io/client-go v0.0.0-20190620085101-78d2af792bab
)
