---
title: "vault Ingress Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: vault'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/ing.svg" alt="Icon" />
    </td>
  </tr>
</table>
# vault Ingress Health    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-ingress-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-ingress-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch Ingress Object Health in Namespace `vault`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the health status of your Kubernetes ingresses. It begins by using the NAMESPACE and CONTEXT variables you have set in order to obtain a list of Ingress resources. It then loops through each ingress, printing out the name for reference. Next, it checks the backend services used by the Ingress and compares them against the target ports of the services to ensure they match. After this, it checks if any deployments, stateful sets, or daemon sets exist with matching labels. If so, Kubernetes will display the associated owner(s). It also verifies that the given ports are found as container ports within the associated pods. Finally, Kubernetes runs one more check to ensure the proper endpoints are listed for each service. At the end of all its checks, Kubernetes indicates whether the resource is Healthy or Unhealthy.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```NAMESPACE="vault";CONTEXT="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster";ingresses=$(kubectl get ingress -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}');for ingress in $ingresses;do echo "Ingress: $ingress";health_status="NA";backend_services=$(kubectl get ingress "$ingress" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{range .spec.rules[*].http.paths[*]}{.backend.service.name}{"|"}{.backend.service.port.number}{"\n"}{end}');while IFS='|' read -r service port;do echo "Backend Service: $service, Port: $port";target_ports=$(kubectl get service "$service" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath="{.spec.ports[?(@.port==$port)].targetPort}");service_exists=$(kubectl get service "$service" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{.metadata.name}');if [ -z "$service_exists" ];then health_status="Unhealthy";echo "Error: Service $service does not exist";echo "Next Step: Check namespace $NAMESPACE for service name $service.";continue;else selectors=$(kubectl get svc "$service" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{.spec.selector}');label_selector="";for key in $(echo $selectors | jq -r 'keys[]');do value=$(echo $selectors | jq -r --arg key "$key" '.[$key]');label_selector="${label_selector}${key}=${value},";done;label_selector=${label_selector::-1};found_owner=0;for kind in deployment statefulset daemonset;do matching_owners=$(kubectl get $kind -n "$NAMESPACE" --context "$CONTEXT" -l "$label_selector" -o jsonpath='{.items[*].metadata.name}');if [ -n "$matching_owners" ];then for owner in $matching_owners;do echo "Owner Kind: $kind";echo "Owner Name: $owner";found_owner=1;done;fi;done;if [ "$found_owner" == 0 ];then echo "Error: No matching deployment, statefulset, or daemonset found to match label selector \`"$label_selector"\`";echo "Next Steps:\n- Check namespace \`"$NAMESPACE"\` for deployment, statefulset, or daemonset with labels that match \`"$label_selector"\`";fi;port_found="No";associated_pods=$(kubectl get pods -n "$NAMESPACE" --context "$CONTEXT" -l "$label_selector" -o jsonpath='{.items[*].metadata.name}');for pod in $associated_pods;do container_ports=$(kubectl get pod "$pod" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{.spec.containers[*].ports[*].containerPort}');for target_port in $target_ports;do if echo "$container_ports" | grep -wq "$target_port";then port_found="Yes";break;fi;done;done;if [ "$port_found" = "No" ];then health_status="Unhealthy";echo "Warning: targetPort $target_ports of service $service is not found as a containerPort in associated pods";else health_status="Healthy";fi;endpoint_pods=$(kubectl get endpoints "$service" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{range .subsets[*].addresses[*]}- Pod Name: {.targetRef.name}\n Pod IP: {.ip}\n{end}');if [ -z "$endpoint_pods" ];then health_status="Unhealthy";echo "Error: Endpoint for service \`"$service"\` does not have any running pods"; echo "Next Steps:\n- Troubleshoot Container Restarts in Namespace \`"$NAMESPACE"\` \n- Troubleshoot Pending Pods In Namespace \`"$NAMESPACE"\`\n- Troubleshoot Failed Pods In Namespace \`"$NAMESPACE"\`";else echo "Endpoint Pod:";echo "$endpoint_pods";health_status="Healthy";fi;fi;done<<<"$backend_services";echo "Health Status: $health_status";echo "------------";done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             

            # Get the namespace and context
            NAMESPACE="${NAMESPACE}";
            CONTEXT="${CONTEXT}";

            # Use kubectl to get all ingresses in NAMESPACE
            ingresses=$(kubectl get ingress -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}');

            # Iterate through each ingress
            for ingress in $ingresses; do
                echo "Ingress: $ingress";

                # Set a health_status variable
                health_status="NA";

                #Use kubectl to query for backend services of the respective ingress
                backend_services=$(kubectl get ingress "$ingress" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{range .spec.rules[*].http.paths[*]}{.backend.service.name}{"|"}{.backend.service.port.number}{"\n"}{end}');

                # For each backend service, parse for servie and port information
                while IFS='|' read -r service port; do
                    echo "Backend Service: $service, Port: $port";
                    
                    # Use kubectl to extract the targetPort values from service related to the ingress
                    target_ports=$(kubectl get service "$service" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath="{.spec.ports[?(@.port==$port)].targetPort}");

                    # Check if the service exists in the respective NAMESPACE
                    service_exists=$(kubectl get service "$service" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{.metadata.name}');
                    if [ -z "$service_exists" ]; then
                        health_status="Unhealthy";
                        echo "Error: Service $service does not exist";
                        echo "Next Step: Check namespace $NAMESPACE for service name $service.";
                        continue;
                    fi

                    # Extract label selector value from the found service
                    selectors=$(kubectl get svc "$service" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{.spec.selector}');
                    label_selector="";
                    
                    # Iterate through each key-value pair in label selector
                    for key in $(echo $selectors | jq -r 'keys[]'); do
                        value=$(echo $selectors | jq -r --arg key "$key" '.[$key]');
                        label_selector="${label_selector}${key}=${value},";
                    done;
                    label_selector=${label_selector::-1};

                    # Find owner kind i.e Deployment/Statefulset/Daemonset mentioning respective label_selector
                    found_owner=0;
                    for kind in deployment statefulset daemonset; do
                        matching_owners=$(kubectl get $kind -n "$NAMESPACE" --context "$CONTEXT" -l "$label_selector" -o jsonpath='{.items[*].metadata.name}');
                        if [ -n "$matching_owners" ]; then
                            for owner in $matching_owners; do
                                echo "Owner Kind: $kind";
                                echo "Owner Name: $owner";
                                found_owner=1;
                            done;
                        fi;
                    done;

                    # Check if any owner is found or not and if not react accordingly
                    if [ "$found_owner" == 0 ]; then
                        echo "Error: No matching deployment, statefulset, or daemonset found to match label selector \`"$label_selector"\`";
                        echo "Next Steps:\n- Check namespace \`"$NAMESPACE"\` for deployment, statefulset, or daemonset with labels that match \`"$label_selector"\`";
                    fi

                    # Check associated pods for container efficiency
                    port_found="No";
                    associated_pods=$(kubectl get pods -n "$NAMESPACE" --context "$CONTEXT" -l "$label_selector" -o jsonpath='{.items[*].metadata.name}');
                    for pod in $associated_pods; do
                        container_ports=$(kubectl get pod "$pod" -n "$NAMESPACE" --context "$CONTEXT" -o jsonpath='{.spec.containers[*].ports[*].containerPort}');
                        for target_port in $target_ports; do
                            if echo "$container_ports" | grep -wq "$target_port"; then
                                port_found="Yes";
                                break;
                            fi;
                        done;
                    done;
                    
                    # If no port found, mention unhealthy status 
                    if [ "$port_found" = "No" ];then
                        health_status="Unhealthy";
                        echo "Warning: targetPort $target_ports of service $service is not found as a containerPort in associated pods";
                    else
                        health_status="Healthy";
                    fi

                    # Extract endpoint pods from service to check service health
                    endpoint_pods=$(kubectl get endpoints "$service" -n "$NAMESPACE" --context "$CONTEXT" -ojsonpath='{range .subsets[*].addresses[*]}- Pod Name: {.targetRef.name}\nPod IP: {.ip}\n{end}');
                    if [ -z "$endpoint_pods" ];then
                        health_status="Unhealthy";
                        echo "Error: Endpoint for service \`"$service"\` does not have any running pods"; 
                        echo "Next Steps:\n- Troubleshoot Container Restarts in Namespace \`"$NAMESPACE"\` \n- Troubleshoot Pending Pods In Namespace \`"$NAMESPACE"\`\n- Troubleshoot Failed Pods In Namespace \`"$NAMESPACE"\`";
                    else
                        echo "Endpoint Pod:";
                        echo "$endpoint_pods";
                        health_status="Healthy";
                    fi

                done<<<"$backend_services";

                echo "Health Status: $health_status";
                echo "------------";
            done

    ???- abstract "Helpful Links"

            
        - [Documentation on Kubectl Get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Documentation on Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}
        - [Documentation on Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/){:target="_blank"}
        - [Documentation on JQ literacy](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Check for Ingress and Service Conflicts in Namespace `vault`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command runs a Kubernetes diagnostic check. It will compare the external IP address from your ingress points with the internal IPs of the services to which they are pointing. If the two differ, it will provide you with a warning message. This can be useful for detecting and troubleshooting possible misconfigurations in your cluster.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```CONTEXT="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; NAMESPACE="vault"; kubectl --context "gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster" --namespace "vault" get ingress -o json | jq -r '.items[] | select(.status.loadBalancer.ingress) | .metadata.name as $name | .status.loadBalancer.ingress[0].ip as $ingress_ip | .spec.rules[]?.http.paths[]? | "\($name) \($ingress_ip) \(.backend.service.name) \(.backend.service.port.number)"' | while read -r ingress_name ingress_ip service_name service_port; do kubectl --context "gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster" --namespace "vault" get svc "$service_name" -o json | jq --arg ingress_name "$ingress_name" --arg ingress_ip "$ingress_ip" --arg service_name "$service_name" --arg service_port "$service_port" -r 'if .spec.type == "LoadBalancer" then .status.loadBalancer.ingress[0].ip as $service_ip | if $ingress_ip and $service_ip and $service_ip != $ingress_ip then "WARNING: Ingress \($ingress_name) IP (\($ingress_ip)) differs from Service \($service_name) IP (\($service_ip))" else "OK: Ingress \($ingress_name) - Service \($service_name) is of type LoadBalancer with IP (\($service_ip))" end else "OK: Ingress \($ingress_name) - Service \($service_name) is of type \(.spec.type) on port \($service_port)" end'; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Kubernetes uses context's to keep track of which clusters and environments
            #  in the cluster you are interacting with. Namespaces are used for resource allocation & 
            #  division of tasks
            CONTEXT="${CONTEXT}"; NAMESPACE="${NAMESPACE}";

            #Using 'kubectl', which is the command-line interface for running commands against clusters 
            #in Kubernetes, we get ingress resources within the specified context and namespace,
            #specifying that the output format should be JSON.

            kubectl --context "${CONTEXT}" --namespace "${NAMESPACE}" get ingress -o json | 

             #jq is a lightweight and flexible command-line JSON processor. 
             # Here we are using it to select elements from an array and create variables with the established selectors
             jq -r '.items[] | select(.status.loadBalancer.ingress) | .metadata.name as \$name | .status.loadBalancer.ingress[0].ip as \$ingress_ip | .spec.rules[]?.http.paths[]? | "\($name) \($ingress_ip) \(.backend.service.name) \(.backend.service.port.number)"' | 

            #While read loops through every line of our desired output 
            #(which was defined by the jq command to be 3 variables each representing ingress name, ip & service port )
            while read -r ingress_name ingress_ip service_name service_port; do 

                #We again use the 'kubectl' command to get the service of the service name and its type
                kubectl --context "${CONTEXT}" --namespace "${NAMESPACE}" get svc "$service_name" -o json | 

                #jq again to parse through the returned service response and print the corresponding log messages
                jq --arg ingress_name "$ingress_name" --arg ingress_ip "$ingress_ip" --arg service_name "$service_name" --arg service_port "$service_port" -r 'if .spec.type == "LoadBalancer" then .status.loadBalancer.ingress[0].ip as $service_ip | if $ingress_ip and $service_ip and $service_ip != $ingress_ip then "WARNING: Ingress \($ingress_name) IP (\($ingress_ip)) differs from Service \($service_name) IP (\($service_ip))" else "OK: Ingress \($ingress_name) - Service \($service_name) is of type LoadBalancer with IP (\($service_ip))" end else "OK: Ingress \($ingress_name) - Service \($service_name) is of type \(.spec.type) on port \($service_port)" end'; done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation on kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}
        - [Kubernetes Official Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/vi-vl-grnwh-ingress-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'vault Ingress Health  ';
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