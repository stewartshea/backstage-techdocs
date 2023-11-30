---
title: "source-controller Deployment Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: flux-system'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/deploy.svg" alt="Icon" />
    </td>
  </tr>
</table>
# source-controller Deployment Health    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    4 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 7 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-deployment-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-deployment-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Troubleshoot Deployment Warning Events for `source-controller`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will list all the events within a Kubernetes cluster in json format. It filters for only warnings, deployments, replicasets, and pods with the specified deployment name that have occurred within the last hour. The output includes the kind of event, the name of the object that was affected by the event, the reason for the event, any messages associated with the event, and the first and last time stamp of the event.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get events --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n flux-system -o json | jq '(now - (60*60)) as $time_limit | [ .items[] | select(.type == "Warning" and (.involvedObject.kind == "Deployment" or .involvedObject.kind == "ReplicaSet" or .involvedObject.kind == "Pod") and (.involvedObject.name | tostring | contains("source-controller")) and (.lastTimestamp | fromdateiso8601) >= $time_limit) | {kind: .involvedObject.kind, name: .involvedObject.name, reason: .reason, message: .message, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp} ] | group_by([.kind, .name]) | map({kind: .[0].kind, name: .[0].name, count: length, reasons: map(.reason) | unique, messages: map(.message) | unique, firstTimestamp: map(.firstTimestamp | fromdateiso8601) | sort | .[0] | todateiso8601, lastTimestamp: map(.lastTimestamp | fromdateiso8601) | sort | reverse | .[0] | todateiso8601})'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command gets events from a Kubernetes cluster, filtered to get only Warnings from Deployment, ReplicaSet or Pod which contain the specified DEPLOYMENT_NAME. It is then grouped by kind and name and mapped in to shorten form with additional fields

            kubectl get events \  # Get events from the Kubernetes cluster 
                --context ${CONTEXT} \  # Specify the context of the kubernetes cluster
                -n ${NAMESPACE} \  # The namespace from which to get events from
                -o json | \  # Output the result in json format
                jq '(now - (60*60)) as $time_limit | \  # Define time limit for the events i.e. last one hour
                    [ .items[] | \  # Get all items from the response
                        select(.type == "Warning" and \  # Filter for Warning type of events
                        (.involvedObject.kind == "Deployment" \  # Filter for Events related to Deployment objects
                        or .involvedObject.kind == "ReplicaSet" \  # Filter for Events related to ReplicaSet objects
                        or .involvedObject.kind == "Pod") \  # Filter for Events related to Pod objects
                        and (.involvedObject.name | tostring | contains("${DEPLOYMENT_NAME}")) \  # Filter on name of the deployment
                        and (.lastTimestamp | fromdateiso8601) >= $time_limit) \  # Filter on timestamp of the events
                    | {kind: .involvedObject.kind, name: .involvedObject.name, reason: .reason, message: .message,  # Map events into simplified form with additional fields
                        firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp} ] \
                    | group_by([.kind, .name]) \  # Group the events based on kind and name
                    | map({kind: .[0].kind, name: .[0].name, count: length, \  # Further map the data to list counts, reasons and messages
                        reasons: map(.reason) | unique, messages: map(.message) | unique, 
                        firstTimestamp: map(.firstTimestamp | fromdateiso8601) | sort | .[0] | todateiso8601, \
                        lastTimestamp: map(.lastTimestamp | fromdateiso8601) | sort | reverse | .[0] | todateiso8601})'

    ???- abstract "Helpful Links"

            
        - [Kubectl get events command - official docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-events){:target="_blank"}
        - [Kubectl context command - official docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#context){:target="_blank"}
        - [Kubernetes namespaces - official docs](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Using jq command utility to parse JSON - official docs](https://stedolan.github.io/jq/tutorial/){:target="_blank"}

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
    #### Get Deployment Workload Details For `source-controller` and Add to Report  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command tells Kubernetes to get information about a particular deployment that has been specified by the name (${DEPLOYMENT_NAME}). The context (${CONTEXT}) and namespace (${NAMESPACE}) provide Kubernetes with more information as to where exactly this deployment lives. Finally, you are asking Kubernetes to output the results in the yaml format.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get deployment/source-controller --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n flux-system -o yaml```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This line of code will retrieve the deployment configuration info from Kubernetes corresponding to a given deployment name, context, and namespace in a yaml format

            kubectl \
                #This is the kubernetes command line interface command
                get \
                #Use the 'get' subcommand to retrieve information/objects
                deployment/${DEPLOYMENT_NAME} \
                #In this case, we're specifically looking for Deployments with the given deployment name
                --context ${CONTEXT} \
                #Optionally specify a 'context' - an isolated cluster role for the operation. We set this variable separately, as it's value may differ between users/environments.
                -n ${NAMESPACE} \
                #Specify a 'namespace' - the environment where all objects of type K8s live. This variable should be set separately, as it's value can change between users/environments.
                -o yaml\
                #The output format will be in yaml, as specified by the '-o yaml' option.

    ???- abstract "Helpful Links"

            
        - [Kubernetes documentation on kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Official Kubernetes kubectl get deployment documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-deployment){:target="_blank"}
        - [Kubernetes documentation on namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes documentation on output format](https://kubernetes.io/docs/reference/using-api/api-overview/#application-programming-interface-command-line-interface){:target="_blank"}

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
    #### Troubleshoot Deployment Replicas for `source-controller`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is retrieving the status of a Kubernetes deployment. A deployment defines how a particular pod or set of pods should be deployed and managed by Kubernetes. It will retrieve the desired number of replicas (defined replicas) for that deployment, the ready replicas (number of replicas already created and working), the missing replicas (replicas defined but not yet created) and the unavailable replicas (number of replicas that vice versa are working but not defined). In addition, it will provide two conditions, available and progressing, to check their related statuses. This command will allow you to see if the deployment is up and running with all the given data.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get deployment/source-controller --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n flux-system -o json | jq '.status | {desired_replicas: .replicas, ready_replicas: (.readyReplicas // 0), missing_replicas: ((.replicas // 0) - (.readyReplicas // 0)), unavailable_replicas: (.unavailableReplicas // 0), available_condition: (if any(.conditions[]; .type == "Available") then (.conditions[] | select(.type == "Available")) else "Condition not available" end), progressing_condition: (if any(.conditions[]; .type == "Progressing") then (.conditions[] | select(.type == "Progressing")) else "Condition not available" end)}'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get deployment specified by the ${DEPLOYMENT_NAME} variable and associated context, namespace. Output in json format
            kubectl get deployment/${DEPLOYMENT_NAME} \ 
                --context ${CONTEXT} \
                -n ${NAMESPACE} \
                -o json 

            # Run jq command to specify desired replicas, ready replicas, missing replicas, unavailable replicas, available condition, and progressing condition
            | jq '.status | {desired_replicas: .replicas, ready_replicas: (.readyReplicas // 0), missing_replicas: ((.replicas // 0) - (.readyReplicas // 0)), unavailable_replicas: (.unavailableReplicas // 0), available_condition: (if any(.conditions[]; .type == "Available") then (.conditions[] | select(.type == "Available")) else "Condition not available" end), progressing_condition: (if any(.conditions[]; .type == "Progressing") then (.conditions[] | select(.type == "Progressing")) else "Condition not available" end)}'

    ???- abstract "Helpful Links"

            
        - [Kubectl Commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubectl Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#set-the-current-context){:target="_blank"}
        - [Using JSON Path in JQ](https://stedolan.github.io/jq/manual/#Basicfilters%20and%20paths){:target="_blank"}
        - [JQ Functions](https://stedolan.github.io/jq/manual/#Basicoperatorsandcomparisons){:target="_blank"}

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
    #### Check Deployment Event Anomalies for `source-controller`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows the user to get events from Kubernetes based on a specified context, namespace, and deployment name. It takes the output from kubectl and adds additional contextual information like the count, messages, first and last timestamp of the event, and the average number of events per minute. This makes it easier to see what type of events happened related to the given context, namespace, and deployment name, and how long each of those events took to complete.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```kubectl get events --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n flux-system -o json | jq '(now - (60*60)) as $time_limit | [ .items[] | select(.type != "Warning" and (.involvedObject.kind == "Deployment" or .involvedObject.kind == "ReplicaSet" or .involvedObject.kind == "Pod") and (.involvedObject.name | tostring | contains("source-controller"))) | {kind: .involvedObject.kind, count: .count, name: .involvedObject.name, reason: .reason, message: .message, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, duration: (if (((.lastTimestamp | fromdateiso8601) - (.firstTimestamp | fromdateiso8601)) == 0) then 1 else (((.lastTimestamp | fromdateiso8601) - (.firstTimestamp | fromdateiso8601))/60) end) } ] | group_by([.kind, .name]) | map({kind: .[0].kind, name: .[0].name, count: (map(.count) | add), reasons: map(.reason) | unique, messages: map(.message) | unique, average_events_per_minute: (if .[0].duration == 1 then 1 else ((map(.count) | add)/.[0].duration ) end),firstTimestamp: map(.firstTimestamp | fromdateiso8601) | sort | .[0] | todateiso8601, lastTimestamp: map(.lastTimestamp | fromdateiso8601) | sort | reverse | .[0] | todateiso8601})'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This is a Kubernetes command to get events from the context of the given namespace filtered by specific deployment name and convert it into a JSON fromat.
            # This command can be broken down into multiple lines for better readability.

            # Set the CONTEXT, NAMESPACE, DEPLOYMENT_NAME environment variables in the current shell
            CONTEXT="<insert context>"
            NAMESPACE="<insert namespace>"
            DEPLOYMENT_NAME="<insert deployment>"

            # Get events using the kubectl command with json formatting
            kubectl get events \
                --context ${CONTEXT} \
                -n ${NAMESPACE} \ 
                -o json \

            # Pipe the output to jq for additional filtering.
            | jq '(now - (60*60)) as $time_limit | [ .items[] | select(.type != "Warning" and (.involvedObject.kind == "Deployment" or .involvedObject.kind == "ReplicaSet" or .involvedObject.kind == "Pod") and (.involvedObject.name | tostring | contains("${DEPLOYMENT_NAME}"))) | {kind: .involvedObject.kind, count: .count, name: .involvedObject.name, reason: .reason, message: .message, firstTimestamp: .firstTimestamp, lastTimestamp: .lastTimestamp, duration: (if (((.lastTimestamp | fromdateiso8601) - (.firstTimestamp | fromdateiso8601)) == 0) then 1 else (((.lastTimestamp | fromdateiso8601) - (.firstTimestamp | fromdateiso8601))/60) end) } ] | group_by([.kind, .name]) | map({kind: .[0].kind, name: .[0].name, count: (map(.count) | add), reasons: map(.reason) | unique, messages: map(.message) | unique, average_events_per_minute: (if .[0].duration == 1 then 1 else ((map(.count) | add)/.[0].duration ) end),firstTimestamp: map(.firstTimestamp | fromdateiso8601) | sort | .[0] | todateiso8601, lastTimestamp: map(.lastTimestamp | fromdateiso8601) | sort | reverse | .[0] | todateiso8601})'

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/){:target="_blank"}

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




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/sc-fs-grnwhnnpr-depl-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'source-controller Deployment Health  ';
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