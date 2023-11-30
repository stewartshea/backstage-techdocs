---
title: "loki-logs DaemonSet Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: loki'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/ds.svg" alt="Icon" />
    </td>
  </tr>
</table>
# loki-logs DaemonSet Health    
<div class="author-block">
  <img src="/github_profile_cache/jon-funk_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/jon-funk" target="_blank">
    <h3 class="author-name">jon-funk</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    3 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 4 weeks ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-daemonset-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-daemonset-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Get DaemonSet Log Details For Report  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will display the logs from a daemonset with a given name, for the specified context in the given namespace. A daemonset is a Kubernetes object which helps to configure and manage pods as a group. The `kubectl logs` command allows you to view the logs of static activities within the pod in order to monitor their output and identify any errors. The `--tail=100` option ensures that only the last 100 lines of the log are displayed, allowing for quicker analysis of recent activity. The `--context` and `-n` flags determine the proper context and namespace in which you wish to view the logs. 
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl logs --tail=100 daemonset/loki-logs --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command retrieves the logs of a given DaemonSet within the provided namespace.
            # The context parameter is used to determine which cluster should be used.

            # Step 1: Specify cluster context
            kubectl config use-context ${CONTEXT}

            # Step 2: Retrieve logs from the specified DaemonSet
            kubectl logs --tail=100 \
                daemonset/${DAEMONSET_NAME} \
                -n ${NAMESPACE}

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for Kubectl Logs command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs){:target="_blank"}
        - [Kubernetes Documentation for Daemonsets](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){:target="_blank"}
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
    #### Get Related Daemonset Events  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command (kubectl) will GET all the events related to a particular context, namespace, and DaemonSet name. It will show any Warning type events existing for that particular combination of context, namespace, and DaemonSet name and will return true even if there are no Warning type events for the combination specified.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get events --field-selector type=Warning --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki | grep -i "loki-logs" || true```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command is intended to display warnings generated in Kubernetes nodes related to a given DaemonSet. 
            #In order for this to work properly, you must first set the variables CONTEXT and NAMESPACE beforehand.

            CONTEXT="$CONTEXT"
            NAMESPACE="$NAMESPACE"
            DAEMONSET_NAME="$DAEMONSET_NAME"

            #Get all events from the given context and namespace, selecting only those with type=Warning
            kubectl get events \
                --field-selector type=Warning \
                --context ${CONTEXT} \
                -n ${NAMESPACE} 

            #Filter the returned results by searching for the name of the DaemonSet 
            #We use '|| -- just in case nothing is found, it will return true so that the command does not fail.
            | grep -i "${DAEMONSET_NAME}" || true

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation for kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubernetes Documentation for field selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/){:target="_blank"}

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
    #### Check Daemonset Replicas  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    The command kubectl describe daemonset/${DAEMONSET_NAME} --context ${CONTEXT} -n ${NAMESPACE} is used to view detailed information about the specified daemonset. A daemonset is a Kubernetes object that ensures that all nodes in the cluster are running a copy of a particular pod. The detailed information includes status, uptime, as well as the number of pods currently running and available for deployment on each node in the cluster. By specifying the context, namespace, and the daemonset’s name, the command will only show information about the given daemonset. This is useful for troubleshooting or managing deployments by getting detailed information about the specified daemonset.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl describe daemonset/loki-logs --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n loki```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command describes the supplied daemon set, retrieves information about its spec and status, as defined in the Kubernetes API.
            # It must be issued from a command line shell with the necessary permissions to access the Kubernetes API.
            kubectl \
                # Invoke the kubectl command
                describe \
                # Request descriptive info 
                daemonset/${DAEMONSET_NAME} \
                # Provided as an argument is the name of the daemon set
                --context ${CONTEXT} \
                # An optional flag providing additional context that allows integration with other tools
                -n ${NAMESPACE} \
                # The namespace in which to search for the requested object (e.g., daemonset)

    ???- abstract "Helpful Links"

            
        - [GitHub kubernetes/community - Kubernetes documentation and website repo](https://github.com/kubernetes/website){:target="_blank"}

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




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/ll-lk-grnwhnnpr-ds-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'loki-logs DaemonSet Health  ';
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