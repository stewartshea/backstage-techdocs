---
title: "runwhen-local Nginx Ingress HTTP Errors  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: runwhen-local'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/nginx-1.svg" alt="Icon" />
    </td>
  </tr>
</table>
# runwhen-local Nginx Ingress HTTP Errors    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    2 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 8 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/curl-gmp-nginx-ingress-inspection/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+curl-gmp-nginx-ingress-inspection" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch Nginx HTTP Errors From GMP for Ingress `runwhen-local`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to query the Nginx Ingress controller for request statuses. It will gather information such as the host, ingress, namespace and service and print it out in json format. This can be helpful when troubleshooting issues with the controller. It can also help in monitoring incoming requests and ensuring that the controller is working as expected.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```curl -d "query=rate(nginx_ingress_controller_requests{host='runwhen-local.sandbox.runwhen.com', service='runwhen-local', status=~'500|501|502'}[10m]) > 0" -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://monitoring.googleapis.com/v1/projects/runwhen-nonprod-sandbox/location/global/prometheus/api/v1/query' | jq -r 'if .data.result[0] then "Host:" + .data.result[0].metric.host + " Ingress:" + .data.result[0].metric.ingress + " Namespace:" + .data.result[0].metric.exported_namespace + " Service:" + .data.result[0].metric.service else "" end'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command does a number of things in one-line, which can be daunting for new users to Kubernetes and related CLIs. To make it easier to understand, we will break it down into its individual steps: 

            #Step 1: Authenticate to Google Cloud Platform with the provided credentials
            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

            #Step 2: Create a Bearer Token 
            AUTH_TOKEN="$(gcloud auth print-access-token)"

            #Step 3: Constructs a query and set headers
            QUERY="query=rate(nginx_ingress_controller_requests{host='${INGRESS_HOST}', service='${INGRESS_SERVICE}', status=~'${ERROR_CODES}'}[${TIME_SLICE}]) > 0"
            HEADERS="Authorization: Bearer $(gcloud auth print-access-token)"

            #Step 4: Make an API call 
            curl -d "${QUERY}" -H "Authorization: Bearer ${AUTH_TOKEN}" 'https://monitoring.googleapis.com/v1/projects/${GCP_PROJECT_ID}/location/global/prometheus/api/v1/query' | jq -r 'if .data.result[0] then "Host:" + .data.result[0].metric.host + " Ingress:" + .data.result[0].metric.ingress + " Namespace:" + .data.result[0].metric.exported_namespace + " Service:" + .data.result[0].metric.service else "" end'

    ???- abstract "Helpful Links"

            
        - [Overview of gcloud auth](https://cloud.google.com/sdk/gcloud/reference/auth/){:target="_blank"}
        - [activate-service-account information for gcloud](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account){:target="_blank"}
        - [Information on curl's data option](https://curl.haxx.se/docs/manpage.html#-d){:target="_blank"}
        - [Information on HTTP Header Authorization](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization){:target="_blank"}
        - [Information on gcloud auth command](https://cloud.google.com/sdk/gcloud/reference/auth/){:target="_blank"}
        - [Information on jq command](https://stedolan.github.io/jq/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock1').addEventListener('click', function() {
    copyCodeBlock1();
});

function copyCodeBlock1() {
  var codeBlock = document.getElementById('codeBlock1');
  var text = codeBlock.textContent;

  navigator.clipboard.writeText(text)
    .then(() => {
      console.log('Code block copied to clipboard:', text);
      showCopiedMessage();
    })
    .catch((error) => {
      console.error('Error copying code block to clipboard:', error);
    });
}

function showCopiedMessage() {
  var copiedMessage = document.getElementById('copiedMessage1');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Find Owner and Service Health for Ingress `runwhen-local`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command checks the health status of an Ingress in a Kubernetes cluster. It takes three parameters – NAMESPACE, CONTEXT and INGRESS_OBJECT_NAME. The command first retrieves all the backend services and ports associated with the Ingress object using the kubectl get ingress command. It then uses a for loop to iterate through each service to check if it exists in the cluster. If it does, it checks the Endpoints associated with the service to check if the pods exist and get information on its owner. Based on the information gathered from these steps, it assigns a Health Status of either “Unhealthy” or “Healthy” and prints the results.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```namespace="runwhen-local"; context="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; ingress="runwhen-local"; echo "Ingress: $ingress"; health_status="NA"; services=(); backend_services=$(kubectl get ingress "$ingress" -n "$namespace" --context "$context" -ojsonpath='{range .spec.rules[*].http.paths[*]}{.backend.service.name}{" "}{.backend.service.port.number}{"\n"}{end}'); IFS=$'\n'; for line in $backend_services; do service=$(echo "$line" | cut -d " " -f 1); port=$(echo "$line" | cut -d " " -f 2); if [ -n "$service" ] && [ -n "$port" ]; then echo "Backend Service: $service, Port: $port"; service_exists=$(kubectl get service "$service" -n "$namespace" --context "$context" -ojsonpath='{.metadata.name}'); if [ -z "$service_exists" ]; then health_status="Unhealthy"; echo "Validation: Service $service does not exist"; else endpoint_pods=$(kubectl get endpoints "$service" -n "$namespace" --context "$context" -ojsonpath='{range .subsets[*].addresses[*]}- Pod Name: {.targetRef.name}, Pod IP: {.ip}\n{end}'); if [ -z "$endpoint_pods" ]; then health_status="Unhealthy"; echo "Validation: Endpoint for service $service does not have any pods"; else echo "Endpoint Pod:"; echo -e "$endpoint_pods"; for pod in $endpoint_pods; do if [[ $pod == *"- Pod Name: "* ]]; then pod_name="${pod#*- Pod Name: }"; pod_name="${pod_name%%,*}"; if [ -n "$pod_name" ]; then owner_kind=$(kubectl get pod "$pod_name" -n "$namespace" --context "$context" -o=jsonpath='{.metadata.ownerReferences[0].kind}'); if [ -n "$owner_kind" ]; then if [ "$owner_kind" = "StatefulSet" ] || [ "$owner_kind" = "DaemonSet" ]; then owner_info="$(kubectl get pod "$pod_name" -n "$namespace" --context "$context" -o=jsonpath='{.metadata.ownerReferences[0].name}') $owner_kind"; else replicaset=$(kubectl get pod "$pod_name" -n "$namespace" --context "$context" -o=jsonpath='{.metadata.ownerReferences[0].name}'); if [ -n "$replicaset" ]; then owner_kind=$(kubectl get replicaset "$replicaset" -n "$namespace" --context "$context" -o=jsonpath='{.metadata.ownerReferences[0].kind}'); owner_name=$(kubectl get replicaset "$replicaset" -n "$namespace" --context "$context" -o=jsonpath='{.metadata.ownerReferences[0].name}'); owner_info="$owner_name $owner_kind"; fi; fi; fi; if [ -n "$owner_info" ]; then echo "Owner: $owner_info"; fi; fi; fi; done; health_status="Healthy"; fi; fi; services+=("$service"); fi; done; for service in "${services[@]}"; do service_exists=$(kubectl get service "$service" -n "$namespace" --context "$context" -ojsonpath='{.metadata.name}'); if [ -z "$service_exists" ]; then health_status="Unhealthy"; echo "Validation: Service $service does not exist"; else endpoint_exists=$(kubectl get endpoints "$service" -n "$namespace" --context "$context" -ojsonpath='{.metadata.name}'); if [ -z "$endpoint_exists" ]; then health_status="Unhealthy"; echo "Validation: Endpoint for service $service does not exist"; fi; fi; done; if [ "$health_status" = "Unhealthy" ]; then echo "Health Status: $health_status"; echo "====================="; elif [ "$health_status" = "Healthy" ]; then echo "Health Status: $health_status"; fi; echo "------------"```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Define variables
            NAMESPACE="${NAMESPACE}"
            CONTEXT="${CONTEXT}"
            INGRESS_OBJECT_NAME="${INGRESS_OBJECT_NAME}"
            echo "Ingress: $INGRESS_OBJECT_NAME"

            # Initial Health Status
            HEALTH_STATUS="NA"

            # Initialize Services array for later validation
            declare -a SERVICES=()

            # Get information about the ingress path and available back-end services
            BACKEND_SERVICES=$(kubectl get ingress "$INGRESS_OBJECT_NAME" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{range .spec.rules[*].http.paths[*]}{.backend.service.name}{" "}{.backend.service.port.number}{"\n"}{end}')

            # Set IFS (Internal Field Separator) temporarily to \n in order to split each line
            IFS="$'\n'" 

            # Iterate through each line of the Backend Services
            for LINE in $BACKEND_SERVICES; do 
                # From each line, extract only the Service name and Port number
                SERVICE=$(echo "$LINE" | cut -d " " -f 1)
                PORT=$(echo "$LINE" | cut -d " " -f 2)

                # Check that non-empty values were extracted
                if [ -n "$SERVICE" ] && [ -n "$PORT" ]; then
                    echo "Backend Service: $SERVICE, Port: $PORT"

                    # Validate that the Service actually exists
                    SERVICE_EXISTS=$(kubectl get service "$SERVICE" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{.metadata.name}')
                    if [ -z "$SERVICE_EXISTS" ]; then
                        HEALTH_STATUS="Unhealthy"
                        echo "Validation: Service $SERVICE does not exist"
                    else
                        # Extract information for the pods associated with the Service's endpoint
                        ENDPOINT_PODS=$(kubectl get endpoints "$SERVICE" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{range .subsets[*].addresses[*]}- Pod Name: {.targetRef.name}, Pod IP: {.ip}\n{end}')
                        
                        # If at least one pod exists
                        if [ -n "$ENDPOINT_PODS" ]; then
                            echo "Endpoint Pod:"
                            echo -e "$ENDPOINT_PODS"
                            
                            # Iterate through the list of pods
                            for POD in $ENDPOINT_PODS; do
                                # Extract out only the Pod Name from the list
                                POD_NAME="${POD#*- Pod Name: }"
                                POD_NAME="${POD_NAME%,*}"
                                
                                # Deepen the validation by making sure the Pod is associated to a specific owner
                                if [ -n "$POD_NAME" ]; then
                                    # Obtain the kind of owner associated to the pod
                                    OWNER_KIND=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" --context "$CONTEXT" -o=jsonpath='{.metadata.ownerReferences[0].kind}')
                                    
                                    # If the Pod is owned by either a StatefulSet or a DaemonSet
                                    if [ -n "$OWNER_KIND" ]; then
                                        if [ "$OWNER_KIND" = "StatefulSet" ] || [ "$OWNER_KIND" = "DaemonSet" ]; then
                                            # Extract only the name of the owner
                                            OWNER_INFO="$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" --context "$CONTEXT" -o=jsonpath='{.metadata.ownerReferences[0].name}') $OWNER_KIND"
                                        else
                                            # Possible ReplicaSet owner. Extract ReplicaSet name first before extracting its related kind
                                            REPLICASET=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" --context "$CONTEXT" -o=jsonpath='{.metadata.ownerReferences[0].name}')
                                            
                                            if [ -n "$REPLICASET" ]; then
                                                OWNER_KIND=$(kubectl get replicaset "$REPLICASET" -n "$NAMESPACE" --context "$CONTEXT" -o=jsonpath='{.metadata.ownerReferences[0].kind}')
                                                OWNER_NAME=$(kubectl get replicaset "$REPLICASET" -n "$NAMESPACE" --context "$CONTEXT" -o=jsonpath='{.metadata.ownerReferences[0].name}')
                                                OWNER_INFO="$OWNER_NAME $OWNER_KIND"
                                            fi
                                        fi
                                    fi
                                    
                                    # Check if valid owner info was obtained per Pod; if so, show it
                                    if [ -n "$OWNER_INFO" ]; then
                                        echo "Owner: $OWNER_INFO"
                                    fi
                                fi 
                            done 
                            
                            # Indicate that the status is currently Healthy
                            HEALTH_STATUS="Healthy" 
                        else # No Pods were found
                            HEALTH_STATUS="Unhealthy"
                            echo "Validation: Endpoint for service $SERVICE does not have any pods"
                        fi
                    fi
                    
                    # Add this Service to a list for later use
                    SERVICES+=("$SERVICE")
                fi
            done

            # For each previously added Service
            for SERVICE in "${SERVICES[@]}"; do
                # Validate that the Service still exists
                SERVICE_EXISTS=$(kubectl get service "$SERVICE" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{.metadata.name}')
                if [ -z "$SERVICE_EXISTS" ]; then
                    HEALTH_STATUS="Unhealthy"
                    echo "Validation: Service $SERVICE does not exist"
                else
                    ENDPOINT_EXISTS=$(kubectl get endpoints "$SERVICE" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{.metadata.name}')
                    # Validate that the Service

    ???- abstract "Helpful Links"

            
        - [Kubernetes Overview](https://kubernetes.io/docs/concepts/){:target="_blank"}
        - [Kubectl Overview](https://kubernetes.io/docs/tasks/tools/install-kubectl/){:target="_blank"}
        - [Ingress Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}
        - [Service Documentation](https://kubernetes.io/docs/concepts/services-networking/service/){:target="_blank"}
        - [StatefulSets Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){:target="_blank"}
        - [DaemonSets Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){:target="_blank"}
        - [ReplicaSets Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/){:target="_blank"}

<script>

document.getElementById('copyCodeBlock2').addEventListener('click', function() {
    copyCodeBlock2();
});

function copyCodeBlock2() {
  var codeBlock = document.getElementById('codeBlock2');
  var text = codeBlock.textContent;

  navigator.clipboard.writeText(text)
    .then(() => {
      console.log('Code block copied to clipboard:', text);
      showCopiedMessage();
    })
    .catch((error) => {
      console.error('Error copying code block to clipboard:', error);
    });
}

function showCopiedMessage() {
  var copiedMessage = document.getElementById('copiedMessage2');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/rl-rl-grnwhnnpr-ngx-ing-gmp/runbook.yaml');
});

function showConfig(runbook) {
    const popupContainer = document.createElement("div"); // Container for the popup
    const popup = document.createElement("div");
    popup.classList.add("popup");

    const loadingMessage = document.createElement("h1");
    loadingMessage.innerText = "Please wait...";

    popup.appendChild(loadingMessage);
    popupContainer.appendChild(popup); // Append the popup to the container
    document.body.appendChild(popupContainer); // Append the container to the document body

    fetch('/get-runbook-config', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            runbook: runbook,
        }) 
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            popup.removeChild(loadingMessage);

            const closeButton = document.createElement("span");
            closeButton.classList.add("close");
            closeButton.innerHTML = "&times;";
            closeButton.style.fontSize = "24px"; // Increase the font size for better visibility
            closeButton.style.position = "absolute";
            closeButton.style.top = "10px";
            closeButton.style.right = "10px";

            const title = document.createElement("p");
            title.innerText = "Private configuration for: " + 'runwhen-local Nginx Ingress HTTP Errors  ';
            const configPath = document.createElement("p");
            configPath.innerText = "Local filesystem path: /shared/output/" + runbook;

            const image = document.createElement("img");
            image.src = "https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg";
            image.alt = "Icon";

            const codeBlock = document.createElement("pre");
            codeBlock.classList.add("code-block");
            codeBlock.innerText = data;

            popup.appendChild(closeButton);
            popup.appendChild(image); // Append the image to the popup
            popup.appendChild(title);
            popup.appendChild(configPath);
            popup.appendChild(codeBlock);
        })
        .catch(error => {
            console.error('Error:', error);
            alert(error);
        });

    // Event delegation for close button click
    popupContainer.addEventListener("click", (event) => {
        const target = event.target;
        if (target.classList.contains("close")) {
            event.stopPropagation(); // Stop event propagation
            document.body.removeChild(popupContainer); // Remove the container instead of the popup
        }
    });
}

</script>
<style>
  .multiline {
    white-space: pre-wrap;
    word-wrap: break-word;
  }
.popup .code-block {
    background-color: #333;
    color: #f8f8f8;
    padding: 10px;
    font-family: Consolas, Monaco, 'Andale Mono', monospace;
    font-size: 14px;
    line-height: 1.4;
    overflow: auto;
}


</style>



---