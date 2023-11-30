---
title: "acid-minimal-cluster StatefulSet Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: postgres-database'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/sts.svg" alt="Icon" />
    </td>
  </tr>
</table>
# acid-minimal-cluster StatefulSet Health    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    4 Troubleshooting Commands</p>
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-statefulset-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-statefulset-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch StatefulSet `acid-minimal-cluster` Logs  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to view the logs of a particular stateful set in a Kubernetes cluster. The 'statefulset' command identifies which stateful set whose logs we're viewing, and 'tail=100' means that we will only view the last 100 lines of logs. 'context' specifies which context we want to view within the cluster, and 'namespace' specifies which namespace we'll look at. By providing this information, we can view the most recent log entries for the specified stateful set.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl logs --tail=100 statefulset/acid-minimal-cluster --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n postgres-database```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Command to examine logs of a StatefulSet named ${STATEFULSET_NAME} in namespace ${NAMESPACE} with Kubernetes context set to ${CONTEXT}.   
            # This will display the last 100 lines of the log output.
            kubectl \
              logs \   # Invoking Kubernetes CLI command `logs`
              --tail=100 \   # Limiting line output from the logs to the last 100
              statefulset/${STATEFULSET_NAME} \  # Targeting the specified StatefulSet by name
              --context ${CONTEXT} \  # Setting the context value (e.g., acme-cluster)
              -n ${NAMESPACE}  # Setting the namespace value (e.g., AcmeCorpInc)

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs){:target="_blank"}
        - [Kubernetes Documentation for StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){:target="_blank"}
        - [Kubernetes Documentation for Contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Documentation for Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}

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
    #### Get Related StatefulSet `acid-minimal-cluster` Events  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to view Kubernetes events that have the type of 'Warning' in the specific context and namespace provided. It will then filter the results to include only those related to a named StatefulSet. The "|| true" at the end ensures that the command does not fail if there are no matching results returned.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get events --field-selector type=Warning --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n postgres-database | grep -i "acid-minimal-cluster" || true```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             
            # Retrieve any events in the Kubernetes cluster based on a specified context and namespace that have a type of warning 
            # Context, namespace and stateful set name are passed into the command as environment variables 
            kubectl \
                # Begin 'kubectl' command to interact with the Kubernetes API
                get \
                # Command to retrieve resources
                events \
                # Resource to retrieve
                --field-selector type=Warning \
                # Specify the type of events we want to retrieve should be warning
                --context ${CONTEXT} \
                # Specify the context of which the Kubernetes cluster this command is intended for. Passsed in as an environment variable 
                -n ${NAMESPACE} \
                # Specify the namespace within the Kubernetes cluster that the command will be running in. Passed in as an environment variable
                | \
                # Use a pipe to get the input of one command (kubectl) as the output for another (grep)
                grep \
                # Command to search through text
                -i "${STATEFULSET_NAME}" \
                # Search the returned event messages for occurrences of the specifed stateful set name. Passed in as an environment variable
                || true
                # Execute the command with a non-zero exit code regardless of the result. This is helpful when nested commands are being used (e.g., 0 exit code prevents further logic in the multi-line command from being excuted

    ???- abstract "Helpful Links"

            
        - [Kubectl Documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Get Events Documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-events){:target="_blank"}
        - [Field Selectors Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/){:target="_blank"}
        - [Context Concept Documentation](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Grep Utility Manual](https://www.gnu.org/software/grep/manual/grep.html){:target="_blank"}

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
    #### Fetch StatefulSet `acid-minimal-cluster` Manifest Details  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get information about a StatefulSet object in Kubernetes. A StatefulSet is used to manage the deployment and scaling of stateful applications. The command uses several options to specify which StatefulSet should be viewed: labels (for labeling resources for easy searching), context (to select the cluster to query info from), and namespace (to specify the Namespace/Project the StatefulSet lives in). It also includes an -o option to output in YAML format, which will return all the details associated with the selected StatefulSet.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get statefulset  --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n postgres-database -o yaml```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            
            # This command allows you to retrieve a YAML representation of a given statefulset, which is part of a Kubernetes resource for deploying and managing containers that can persist data.
            # The multi-line command looks like this:
            kubectl \
                # Run the kubectl command 
                get \
                # Retrieve a given resource
                statefulset \
                # Specify the type of resource to be retrieved 
                ${LABELS} \
                # Use provided labels to identify the resource
                --context=${CONTEXT} \
                # Command should use the specified context 
                -n ${NAMESPACE} \
                # Target the provided namespace
                -o yaml 
                # Represent information in a YAML format

    ???- abstract "Helpful Links"

            
        - [Kubernetes docs - how to use kubectl in the command line](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubernetes docs - StatefulSets concepts and usage](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#why-use-a-statefulset){:target="_blank"}

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
    #### List StatefulSets with Unhealthy Replica Counts In Namespace `postgres-database`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will retrieve the information about a StatefulSet in the Kubernetes cluster, which is a way of managing resources as a unit for persistent applications. 
    It looks at the context and namespace associated with it and returns the StatefulSet name, desired replicas, and available replicas. 
    This helps you see the overall health status of the persistent application and how close it is to achieving the desired state.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```kubectl get statefulset -n postgres-database -o json --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster | jq -r '.items[] | select(.status.availableReplicas < .status.replicas) | "---\nStatefulSet Name: " + (.metadata.name|tostring) + "\nDesired Replicas: " + (.status.replicas|tostring) + "\nAvailable Replicas: " + (.status.availableReplicas|tostring)'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command will pull a list of statefulsets within a specific namespace and context, format the data using jq to output name, desired replicas, 
            # and currently available replicas of statefulsets with less replicas than desired configed

            # Notice that variables such as NAMESPACE and CONTEXT must be properly set before this cmd is run
            NAMESPACE=<INSERT_PROPER_NAMESPACE_HERE>
            CONTEXT=<INSERT_PROPER_CONTEXT_HERE>

            # Now we can execute the command on multiple lines
            kubectl get statefulset -n ${NAMESPACE} \
            --context ${CONTEXT} \
            -o json \
            | jq -r '.items[] | select(.status.availableReplicas < .status.replicas) | "---\nStatefulSet Name: " + (.metadata.name|tostring) + "\nDesired Replicas: " + (.status.replicas|tostring) + "\nAvailable Replicas: " + (.status.availableReplicas|tostring)'

    ???- abstract "Helpful Links"

            
        - [What is a StatefulSet?](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/){:target="_blank"}
        - [Managing Resources Using the JSONPath Expression Syntax](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/amc-pd-grnwhnnpr-ss-health1/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'acid-minimal-cluster StatefulSet Health  ';
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