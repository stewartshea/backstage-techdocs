---
title: "flux-system Kustomization Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: flux-system'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/flux-icon-color.svg" alt="Icon" />
    </td>
  </tr>
</table>
# flux-system Kustomization Health    
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-fluxcd-kustomization-health/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-fluxcd-kustomization-health" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### List all available Kustomization objects in Namespace `flux-system`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to view the details of a particular resource in a Kubernetes cluster. The ${RESOURCE_NAME} is the name of the resource you wish to view, and must be one of the supported resources as listed on the official Kubernetes documentation (https://kubernetes.io/docs/reference/kubectl/overview/). The ${NAMESPACE} is the namespace within the cluster where the resource is located, while the ${CONTEXT} is the name that you use to switch between clusters. This command will return the details of the specified resource, or an error if the resource does not exist.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get Kustomization.kustomize.toolkit.fluxcd.io -n flux-system --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command gets a specified resource from the desired Kubernetes context/namespace.

            #Get a reference to the desired resource
            RESOURCE_NAME="<enter_resource_name>"

            #Set the namespace identifier
            NAMESPACE="<enter_namespace>"

            #Identify desired Kubernetes context
            CONTEXT="<enter_context>"

            #Invoke kubectl command to obtain the resource from cluster
            kubectl get ${RESOURCE_NAME} -n ${NAMESPACE} --context ${CONTEXT}

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation: kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Docs Overview: The Basics of Kubernetes Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/){:target="_blank"}
        - [Kubernetes Documentation: namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes Docs: Context and Configuration](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){:target="_blank"}

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
    #### Get details for unready Kustomizations in Namespace `flux-system`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will get an individual Kubernetes resource by name for the specified namespace and context, convert it to JSON format, and then use a command-line data transformation tool called 'jq' to extract parts of the data into a readable output. In particular, it prints out the Kustomization name, readiness status (including the condition, message, reason and last transition time) and reconcile status (including the condition and message). It can be helpful in troubleshooting Kubernetes resources that aren't properly functioning or haven't settled into their desired states yet.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get Kustomization.kustomize.toolkit.fluxcd.io -n flux-system --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '.items[] | select (.status.conditions[] | select(.type == "Ready" and .status == "False")) | "---\nKustomization Name: \(.metadata.name)\n\nReady Status: \(.status.conditions[] | select(.type == "Ready") | "\n ready: \(.status)\n message: \(.message)\n reason: \(.reason)\n last_transition_time: \(.lastTransitionTime)")\n\nReconcile Status:\(.status.conditions[] | select(.type == "Reconciling") |"\n reconciling: \(.status)\n message: \(.message)")\n---\n"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            
            # This command retrieves resource information in JSON format from Kubernetes. It uses the Kustomization name, namespace, and context, provided as variables in the command, to get detailed information about ready and reconciliations statuses for resources. 

            # We convert the output into a multi-line command here with added verbose comments: 
            kubectl \
                # The kubectl command is used to communicate with the Kubernetes API to configure clusters, deploy apps, etc.
                get ${RESOURCE_NAME} \
                # This is the resource type you want to retrieve information on, provided as a variable in the command.
                -n ${NAMESPACE} \
                # This is the particular namespace within the cluster that contains the desired resources.
                --context ${CONTEXT} \
                # Every request to the Kubernetes API needs to specify a context. This usually includes the cluster name and other requested data such as user and authentication info.
                -o json \
                # This flag indicates that the output from this command should be outputted in JSON format.
                | jq -r '.items[] | select (.status.conditions[] | select(.type == "Ready" and .status == "False")) | "---\nKustomization Name: \(.metadata.name)\n\nReady Status: \(.status.conditions[] | select(.type == "Ready") | "\n ready: \(.status)\n message: \(.message)\n reason: \(.reason)\n last_transition_time: \(.lastTransitionTime)")\n\nReconcile Status:\(.status.conditions[] | select(.type == "Reconciling") |"\n reconciling: \(.status)\n message: \(.message)")\n---\n"'
                # This is a pipe operator used to take the output of the previous command (the kubectl get command) and pass it to the ‘jq’ utility. Jq is a command line tool used to search, manipulate, and analyze a JSON object using a specific syntax. This command will retrieve the Kustomization name, the ready status, and the reconciliation status, all formatted to be readily readable.

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation about kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Documentation about Resource Names](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/#resourcenames){:target="_blank"}
        - [Kubernetes Documentation about Kubernetes Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes Documentation about kubectl contexts](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config-set-context){:target="_blank"}
        - [YAML Tutorial](https://learnxinyminutes.com/docs/yaml/){:target="_blank"}
        - [JSON Tutorial](https://www.w3schools.com/js/js_json_syntax.asp){:target="_blank"}
        - [jq Command Examples](https://stedolan.github.io/jq/tutorial/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/fl-sy-grnwhnnprsndbu-flux-kstmz/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'flux-system Kustomization Health  ';
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