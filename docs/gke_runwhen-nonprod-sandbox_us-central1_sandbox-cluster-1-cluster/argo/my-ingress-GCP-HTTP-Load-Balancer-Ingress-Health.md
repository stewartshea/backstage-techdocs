---
title: "my-ingress GCP HTTP Load Balancer Ingress Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: argo'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/gcp/cloud_load_balancing/cloud_load_balancing.svg" alt="Icon" />
    </td>
  </tr>
</table>
# my-ingress GCP HTTP Load Balancer Ingress Health    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    5 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 9 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-ingress-gce-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-ingress-gce-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Search For GCE Ingress Warnings in GKE  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command checks events for an Ingress and any related Services. It takes Ingress name, Namespace, and Context as parameters in order to better control the scope of what Kubernetes resources are being observed. 

    The first portion of the command uses the kubectl get events command to look up any non-normal events related to the specified Ingress. Then, it enumerates through each related Service using a jsonpath query and executes the same kubectl get events command on each service in order to check for any additional associated events.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```INGRESS_NAME=my-ingress; NAMESPACE=argo; CONTEXT=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; kubectl get events -n $NAMESPACE --context $CONTEXT --field-selector involvedObject.kind=Ingress,involvedObject.name=$INGRESS_NAME,type!=Normal; for SERVICE_NAME in $(kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.spec.rules[*].http.paths[*].backend.service.name}'); do kubectl get events -n $NAMESPACE --context $CONTEXT --field-selector involvedObject.kind=Service,involvedObject.name=$SERVICE_NAME,type!=Normal; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #gather environment variables 
            INGRESS_NAME=${INGRESS}
            NAMESPACE=${NAMESPACE}
            CONTEXT=${CONTEXT}

            #get the events related to the ingress object
            kubectl get events -n $NAMESPACE --context $CONTEXT \
                --field-selector \
                    involvedObject.kind=Ingress,\
                    involvedObject.name=$INGRESS_NAME,\
                    type!=Normal

            #loop through the services associated with the ingress
            for SERVICE_NAME in $(kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT \
                -o=jsonpath='{.spec.rules[*].http.paths[*].backend.service.name}'); 
            do 

                #for each service, get the events related to that service object 
                kubectl get events -n $NAMESPACE --context $CONTEXT \
                    --field-selector \
                        involvedObject.kind=Service,\
                        involvedObject.name=$SERVICE_NAME,\
                        type!=Normal
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for 'kubectl get events' command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-events){:target="_blank"}
        - [Kubernetes Documentation for 'kubectl get ingress' command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-ingress){:target="_blank"}
        - [Kubernetes Concepts: Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}

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
    #### Identify Unhealthy GCE HTTP Ingress Backends  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to obtain the statuses of all backends associated with a specific Kubernetes ingress. It uses kubectl, which is a command line tool to work with Kubernetes objects, and passes in some variables such as $INGRESS, $NAMESPACE, and $CONTEXT. The output is then further processed by jq, a command line JSON processor, to obtain the backend key and status value. This can be useful to check if any backend related to an Ingress is unhealthy or not.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```INGRESS_NAME=my-ingress; NAMESPACE=argo; CONTEXT=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT -o=json | jq -r '.metadata.annotations["ingress.kubernetes.io/backends"] | fromjson | to_entries[] | select(.value != "HEALTHY") | "Backend: " + .key + " Status: " + .value'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # First set up environment variables for the ingress name, namespace, and context
            INGRESS_NAME=${INGRESS}
            NAMESPACE=${NAMESPACE}
            CONTEXT=${CONTEXT}

            # Get all of the annotations from the ingress 
            # This command uses kubectl to communicate with your kubernetes cluster. For more info see here:  https://kubernetes.io/docs/reference/kubectl/overview/
            ingressAnnotations=$(kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT -o=json) 

            # Massage the output using json tools to figure out which backend status is not healthy
            # jq is a tool for processing json input (more info here: https://stedolan.github.io/jq/tutorial/)
            backendStatus=$(echo $ingressAnnotations | jq -r '.metadata.annotations["ingress.kubernetes.io/backends"] | fromjson | to_entries[] | select(.value != "HEALTHY") | "Backend: " + .key + " Status: " + .value') 

            echo ${backendStatus}

    ???- abstract "Helpful Links"

            
        - [Kubernetes Ingress Documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#ingress-v1-networking-k8s-io){:target="_blank"}
        - [jq documentation for JSON manipulation](https://stedolan.github.io/jq/){:target="_blank"}
        - [The official jq manual](https://www.manpagez.com/man/1/jq/){:target="_blank"}

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




!!! note ""
    <div class="command-title">
    #### Fetch Network Error Logs from GCP Operations Manager for Ingress Backends  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to debug an Ingress in Kubernetes. It retrieves errors from GCP's log streaming and prints out the timestamp, IP address, and error message associated with it. The command first retrieves the backend values of the Ingress indicated by the INGRESS_NAME variable and its corresponding NAMESPACE and CONTEXT. It then uses GCP authentication tokens (GOOGLE_APPLICATION_CREDENTIALS) to access the GCP logging system. A query is run for each backend which fetches the resourceName that matches and limits to errors returned in the last 24 hours. Finally, the information is formatted into a readable output containing the details of the errors as required.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```INGRESS_NAME=my-ingress; NAMESPACE=argo; CONTEXT=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; GCP_PROJECT_ID=runwhen-nonprod-sandbox;for backend in $(kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT -o=json | jq -r '.metadata.annotations["ingress.kubernetes.io/backends"] | fromjson | to_entries[] | select(.value != "HEALTHY") | .key'); do echo "Backend: ${backend}" && gcloud logging read 'severity="ERROR" AND resource.type="gce_network" AND protoPayload.resourceName=~"'${backend}'"' --freshness=1d --limit=50 --project "$GCP_PROJECT_ID" --format=json | jq 'if length > 0 then [ .[] | select(.protoPayload.response.error.message? or .protoPayload.status.message?) | { timestamp: .timestamp, ip: (if .protoPayload.request.networkEndpoints? then .protoPayload.request.networkEndpoints[].ipAddress else null end), message: (.protoPayload.response.error.message? // .protoPayload.status.message?) } ] | group_by(.message) | map(max_by(.timestamp)) | .[] | (.timestamp + " | IP: " + (.ip // "N/A") + " | Error: " + .message) else "No results found" end'; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Variable declarations 
            INGRESS_NAME=${INGRESS};
            NAMESPACE=${NAMESPACE};
            CONTEXT=${CONTEXT};
            GCP_PROJECT_ID=${GCP_PROJECT_ID};

            # Get information from resource
            for backend in $(kubectl get ingress $INGRESS_NAME -n $NAMESPACE --context $CONTEXT -o=json | jq -r '.metadata.annotations["ingress.kubernetes.io/backends"] | fromjson | to_entries[] | select(.value != "HEALTHY") | .key'); do
              # Print resource name
              echo "Backend: \${backend}"

              # Authenticate with Google Application credentials
              gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS

              # Use the Google Cloud Logging command to read errors from resource
              gcloud logging read 'severity="ERROR" AND resource.type="gce_network" AND protoPayload.resourceName=~"'\${backend}'"' --freshness=1d --limit=50 --project "$GCP_PROJECT_ID" --format=json | jq 'if length > 0 then [ .[] | select(.protoPayload.response.error.message? or.protoPayload.status.message?) | { timestamp: .timestamp, ip: (if .protoPayload.request.networkEndpoints? then .protoPayload.request.networkEndpoints[].ipAddress else null end), message: (.protoPayload.response.error.message? // .protoPayload.status.message?) } ] | group_by(.message) | map(max_by(.timestamp)) | .[] | (.timestamp + " | IP: " + (.ip // "N/A") + " | Error: " + .message) else "No results found" end'; done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Ingress - Managing Traffic to Your Services](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}
        - [Google Cloud Monitor Reading Logs for GCE_NETWORK Errors](https://cloud.google.com/error-reporting/docs/setup/index#logging){:target="_blank"}

<script>

document.getElementById('copyCodeBlock3').addEventListener('click', function() {
    copyCodeBlock3();
});

function copyCodeBlock3() {
  var codeBlock = document.getElementById('codeBlock3');
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
  var copiedMessage = document.getElementById('copiedMessage3');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Review GCP Operations Logging Dashboard  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    The command above allows you to get the GCP logging URL for a specific Kubernetes Ingress resource. It retrieves the associated Forwarding Rule, URL Map and Target Proxy annotations to build the query string that will point to the GCP Logging URL. The command can be simplified as follows:

    1. Retrieve the Ingress name, namespace, and context from environment variables. 
    2. Use `kubectl` to extract the references to the associated Forwarding Rule, URL Map, and Target Proxy annotations.
    3. Prepare the log query by encoding it and replacing spaces (“ ”), double quotes (“"’), parentheses ("(" and ")"), and certain symbols such as equal sign ("=") and slash ("/") with the corresponding encoded characters (%20, %22, %28, %29, %3D, and %2F respectively).
    4. Construct the GCP Logging URL by combining the encoded query with the project ID.
    5. Output the GCP Logging URL.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```INGRESS=my-ingress; NAMESPACE=argo; CONTEXT=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; FORWARDING_RULE=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/forwarding-rule}') && URL_MAP=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/url-map}') && TARGET_PROXY=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/target-proxy}') && LOG_QUERY="resource.type=\"http_load_balancer\" AND resource.labels.forwarding_rule_name=\"$FORWARDING_RULE\" AND resource.labels.target_proxy_name=\"$TARGET_PROXY\" AND resource.labels.url_map_name=\"$URL_MAP\"" && ENCODED_LOG_QUERY=$(echo $LOG_QUERY | sed -e 's| |%20|g' -e 's|"|%22|g' -e 's|(|%28|g' -e 's|)|%29|g' -e 's|=|%3D|g' -e 's|/|%2F|g') && GCP_LOGS_URL="https://console.cloud.google.com/logs/query;query=$ENCODED_LOG_QUERY?project=$GCP_PROJECT_ID" && echo $GCP_LOGS_URL```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command is to retrieve and output the Google Cloud Logs URL of a Kubernetes Ingress. It has been split into several lines for enhanced readability.
            #We first store the variables for the namespace, context and ingress in seperate variables:
            INGRESS=${INGRESS}
            NAMESPACE=${NAMESPACE}
            CONTEXT=${CONTEXT}

            #We use the kubectl command to retrieve the forwarding-rule, url-map and target-proxy of the ingress defined by the variables from above
            FORWARDING_RULE=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/forwarding-rule}')
            URL_MAP=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/url-map}')
            TARGET_PROXY=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/target-proxy}')

            #We then assemble a string which contains the log query we want to execute against Google Cloud Logs.
            LOG_QUERY="resource.type=\"http_load_balancer\" AND resource.labels.forwarding_rule_name=\"$FORWARDING_RULE\" AND resource.labels.target_proxy_name=\"$TARGET_PROXY\" AND resource.labels.url_map_name=\"$URL_MAP\""

            #Google Cloud logs requires certain characters in its URL strings to be URL encoded, so that it can correctly decode and interpret them. As such, we encode our query string as an URL. 
            ENCODED_LOG_QUERY=$(echo $LOG_QUERY | sed -e 's| |%20|g' -e 's|"|%22|g' -e 's|(|%28|g' -e 's|)|%29|g' -e 's|=|%3D|g' -e 's|/|%2F|g')

            #We assemble the complete URL for the log query.
            GCP_LOGS_URL="https://console.cloud.google.com/logs/query;query=$ENCODED_LOG_QUERY?project=$GCP_PROJECT_ID"

            #Finally, we output the URL
            echo $GCP_LOGS_URL

    ???- abstract "Helpful Links"

            
        - [Documentation for Kubernetes ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}
        - [Documentation for jsonpath query language](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Documentation for Google Cloud Platform Logs Viewer](https://cloud.google.com/logging/docs/view/overview){:target="_blank"}

<script>

document.getElementById('copyCodeBlock4').addEventListener('click', function() {
    copyCodeBlock4();
});

function copyCodeBlock4() {
  var codeBlock = document.getElementById('codeBlock4');
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
  var copiedMessage = document.getElementById('copiedMessage4');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




!!! note ""
    <div class="command-title">
    #### Review GCP Operations Logging Dashboard  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    The command above allows you to get the GCP logging URL for a specific Kubernetes Ingress resource. It retrieves the associated Forwarding Rule, URL Map and Target Proxy annotations to build the query string that will point to the GCP Logging URL. The command can be simplified as follows:

    1. Retrieve the Ingress name, namespace, and context from environment variables. 
    2. Use `kubectl` to extract the references to the associated Forwarding Rule, URL Map, and Target Proxy annotations.
    3. Prepare the log query by encoding it and replacing spaces (“ ”), double quotes (“"’), parentheses ("(" and ")"), and certain symbols such as equal sign ("=") and slash ("/") with the corresponding encoded characters (%20, %22, %28, %29, %3D, and %2F respectively).
    4. Construct the GCP Logging URL by combining the encoded query with the project ID.
    5. Output the GCP Logging URL.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock5">```INGRESS=my-ingress; NAMESPACE=argo; CONTEXT=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; QUERY="resource.type=\"gce_network\"" && for backend in $(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=json | jq -r '.metadata.annotations["ingress.kubernetes.io/backends"] | fromjson | to_entries[] | select(.value != "HEALTHY") | .key'); do QUERY="$QUERY AND protoPayload.resourceName=~\"$backend\""; done && ENCODED_QUERY=$(echo $QUERY | jq -sRr @uri) && DASHBOARD_URL="https://console.cloud.google.com/logs/query;query=$ENCODED_QUERY?project=$GCP_PROJECT_ID" && echo $DASHBOARD_URL```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock5" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage5" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command is to retrieve and output the Google Cloud Logs URL of a Kubernetes Ingress. It has been split into several lines for enhanced readability.
            #We first store the variables for the namespace, context and ingress in seperate variables:
            INGRESS=${INGRESS}
            NAMESPACE=${NAMESPACE}
            CONTEXT=${CONTEXT}

            #We use the kubectl command to retrieve the forwarding-rule, url-map and target-proxy of the ingress defined by the variables from above
            FORWARDING_RULE=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/forwarding-rule}')
            URL_MAP=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/url-map}')
            TARGET_PROXY=$(kubectl get ingress $INGRESS -n $NAMESPACE --context $CONTEXT -o=jsonpath='{.metadata.annotations.ingress\.kubernetes\.io/target-proxy}')

            #We then assemble a string which contains the log query we want to execute against Google Cloud Logs.
            LOG_QUERY="resource.type=\"http_load_balancer\" AND resource.labels.forwarding_rule_name=\"$FORWARDING_RULE\" AND resource.labels.target_proxy_name=\"$TARGET_PROXY\" AND resource.labels.url_map_name=\"$URL_MAP\""

            #Google Cloud logs requires certain characters in its URL strings to be URL encoded, so that it can correctly decode and interpret them. As such, we encode our query string as an URL. 
            ENCODED_LOG_QUERY=$(echo $LOG_QUERY | sed -e 's| |%20|g' -e 's|"|%22|g' -e 's|(|%28|g' -e 's|)|%29|g' -e 's|=|%3D|g' -e 's|/|%2F|g')

            #We assemble the complete URL for the log query.
            GCP_LOGS_URL="https://console.cloud.google.com/logs/query;query=$ENCODED_LOG_QUERY?project=$GCP_PROJECT_ID"

            #Finally, we output the URL
            echo $GCP_LOGS_URL

    ???- abstract "Helpful Links"

            
        - [Documentation for Kubernetes ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/){:target="_blank"}
        - [Documentation for jsonpath query language](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Documentation for Google Cloud Platform Logs Viewer](https://cloud.google.com/logging/docs/view/overview){:target="_blank"}

<script>

document.getElementById('copyCodeBlock5').addEventListener('click', function() {
    copyCodeBlock5();
});

function copyCodeBlock5() {
  var codeBlock = document.getElementById('codeBlock5');
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
  var copiedMessage = document.getElementById('copiedMessage5');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/mi-ar-grnwh-ingrs-gc-hlth/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'my-ingress GCP HTTP Load Balancer Ingress Health  ';
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