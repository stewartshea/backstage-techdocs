---
title: "otel-demo ArgoCD Application Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: otel-demo'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/argo-icon-color.svg" alt="Icon" />
    </td>
  </tr>
</table>
# otel-demo ArgoCD Application Health    
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
    Last updated 4 weeks ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-argocd-application-health/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-argocd-application-health" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch ArgoCD Application Sync Status & Health  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command, kubectl get applications.argoproj.io ${APPLICATION} -n ${APPLICATION_APP_NAMESPACE} --context ${CONTEXT} -o jsonpath='Application Name: {.metadata.name}, Sync Status: {
    .status.sync.status}, Health Status: {.status.health.status}, Message: {.status.conditions[].message}', allows you to retrieve information about a specific application from the Kubernetes cluster. The ${APPLICATION} argument specifies the application name, the ${APPLICATION_APP_NAMESPACE} argument specifies which namespace it should look in for that application, and the --context ${CONTEXT} argument sets the context to use when making the request. The -o jsonpath argument is used to output the response data in the form of a JSON-formatted string, with the data stored in fields labeled 'Application Name', 'Sync Status', 'Health Status', and 'Message'. All of this combined information will give you a comprehensive description of your application on the Kubernetes cluster.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get applications.argoproj.io otel-demo -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='Application Name: {.metadata.name}, Sync Status: {.status.sync.status}, Health Status: {.status.health.status}, Message: {.status.conditions[].message}'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command checks for information of the application with name $APPLICATION based on the given context and namespace. 
            # The output is returned in jsonpath format.

            # First step, retrieve the information from Kubernetes
            kubectl get applications.argoproj.io ${APPLICATION} \
            -n ${APPLICATION_APP_NAMESPACE} \
            --context ${CONTEXT}

            # Second step, provide desired output format using -o jsonpatch option
            kubectl get applications.argoproj.io ${APPLICATION} \
            -n ${APPLICATION_APP_NAMESPACE} \
            --context ${CONTEXT} \
            -o jsonpath='Application Name: {.metadata.name}, Sync Status: {.status.sync.status}, Health Status: {.status.health.status}, Message: {.status.conditions[].message}'

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation on the `kubectl get` Command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [JSONPath Overview and Reference Guide](https://goessner.net/articles/JsonPath/){:target="_blank"}

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
    #### Fetch ArgoCD Application Last Sync Operation Details  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to get the status of an application (in this case argoproj.io) that is deployed in a Kubernetes cluster. This command will pull up certain application details like name, namespace, start and finish time, status and message for the last sync task. The command utilizes parameters like the application name, application namespace and context to fetch the data. The output of this command is presented in json and can be indented using jq.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get applications.argoproj.io otel-demo -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '"Application Name: " + .metadata.name + "\nApplication Namespace: "+ .metadata.namespace + "\nLast Sync Start Time: " + .status.operationState.finishedAt + "\nLast Sync Finish Time: " + .status.operationState.startedAt + "\nLast Sync Status: " + .status.operationState.phase + "\nLast Sync Message: " + .status.operationState.message'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Obtain status of an application using its name, namespace, and kubernetes context 
            kubectl get applications.argoproj.io ${APPLICATION} \
              -n ${APPLICATION_APP_NAMESPACE} \ # Get the application in this particular namespace 
              --context ${CONTEXT} \ # Use this specific Kubernetes context 
              -o json | # Output in json format 
            jq -r '"Application Name: " + .metadata.name + "\nApplication Namespace: "+ .metadata.namespace + "\nLast Sync Start Time: " + .status.operationState.finishedAt + "\nLast Sync Finish Time: " + .status.operationState.startedAt + "\nLast Sync Status: " + .status.operationState.phase + "\nLast Sync Message: " + .status.operationState.message' # Process the output 
            # Using the jq command line processor, retrieve information on application such as the application name, namespace, start time of last sync, finish time of last sync, status of last sync, and message from the last sync.  
            # kubectl is a command line tool used to interact with Kubernetes clusters.

    ???- abstract "Helpful Links"

            
        - [Introduction to kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [The Argo Project](https://argoproj.github.io/){:target="_blank"}
        - [kubectl get applications.argoproj.io](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get-apiapplicationsargoprojio){:target="_blank"}
        - [Using jq to parse JSON data](https://stedolan.github.io/jq/){:target="_blank"}

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
    #### Fetch Unhealthy ArgoCD Application Resources  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to view the applications (running in Kubernetes) from a specified namespace on a given context. It produces a JSON output giving a list of any resources that are not healthy or have a null health status. The name, kind and namespace of each unhealthy resource is provided in the output. This can be useful for quickly identifying potential issues or ensuring that all resources within an application are running properly.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get applications.argoproj.io otel-demo -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '[.status.resources[] | select(.health.status != null) | select(.health.status != "Healthy") | {name,kind,namespace,health}]'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get application resource from argoproj.io
            kubectl get applications.argoproj.io ${APPLICATION} -n ${APPLICATION_APP_NAMESPACE} \
              # Specify the context to execute the command in
              --context ${CONTEXT} \
              # Output the application details in JSON format for us to parse
              -o json \
              # Pass the output into jq, a powerful tool for filtering and manipulating data
              | jq -r '[.status.resources[] \
                  # Filter only the resources with an associated heath status
                  | select(.health.status != null) \
                    # Further filter out those that are Healthy
                    | select(.health.status != "Healthy") \
                      # Select certain values to display as a result
                      | {name,kind,namespace,health}]'

    ???- abstract "Helpful Links"

            
        - [Kubernetes Command-Line Tool Reference](https://kubernetes.io/docs/reference/kubectl/cheatsheet/){:target="_blank"}
        - [Kubernetes Objects Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/){:target="_blank"}
        - [jq Manual](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### Scan For Errors in Pod Logs Related to ArgoCD Application Deployments  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to debug and troubleshoot Kubernetes deployments. The command will get all of the deployments with a specific label in a namespace, then retreive the last 50 lines of logs for each deployment and search them for error-related messages matching a given pattern. This can help determine what might be causing problems when deploying applications to Kubernetes clusters.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```for deployment_name in $(kubectl get deployments -l argocd.argoproj.io/instance=otel-demo_otel-demo -o=custom-columns=NAME:.metadata.name --no-headers -n otel-demo); do echo "\nDEPLOYMENT NAME: $deployment_name \n" && kubectl logs deployment/$deployment_name --tail=50 -n otel-demo | grep -E 'Error|Exception'; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command retrieves the list of deployments for a specified Kubernetes application, 
            # echo deploys names and then curtails the logs of each deployment in order to check log for predefined errors
            for deployment_name in $(kubectl get deployments -l argocd.argoproj.io/instance=${APPLICATION_TARGET_NAMESPACE}_${APPLICATION} -o=custom-columns=NAME:.metadata.name --no-headers -n ${APPLICATION_TARGET_NAMESPACE}); do
              # Print deployment's name 
              echo "\nDEPLOYMENT NAME: $deployment_name \n"
              # Curtail logs of the deployment and search them for predefined errors
              kubectl logs deployment/$deployment_name --tail=50 -n ${APPLICATION_TARGET_NAMESPACE} | grep -E '${ERROR_PATTERN}'; 
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl Logs command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs){:target="_blank"}
        - [WWW Regular Expression Tutorial](https://www.regular-expressions.info/){:target="_blank"}

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
    #### Fully Describe ArgoCD Application  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to view information about a specific Argo application in the Kubernetes cluster. In this command, "kubectl" is a tool used to control and manage applications in the Kubernetes cluster. "describe" is the action being taken on the Argo application defined by the ${APPLICATION} parameter. The application's namespace is also specified by the ${APPLICATION_APP_NAMESPACE} parameter. The command will be executed in the context defined by the ${CONTEXT} parameter.  With this command, you can view detailed information regarding the status and configuration of the specified Argo application.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock5">```kubectl describe applications.argoproj.io otel-demo -n otel-demo --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock5" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage5" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # In this multi-line command we are describing an Argo Application from Kubernetes. 
            # The context flag allows kubectl to use a context stored in the ${KUBECONFIG} file.
            # If not specified, it will default to the current context.
            KUBECONFIG=${KUBECONFIG} # Optional. Needed if the kubeconfig file is different from the default path. 
            CONTEXT=${CONTEXT} # Required. Specifies which context from the KUBECONFIG to be used. 
            APPLICATION=${APPLICATION} # Required. Specifues the application name of the Argo Application to be described. 
            APPLICATION_APP_NAMESPACE=${APPLICATION_APP_NAMESPACE} #Required. Specifies the namespace the Argo Application belongs to.

            kubectl \
               --context ${CONTEXT} \
               describe applications.argoproj.io ${APPLICATION} \
               -n ${APPLICATION_APP_NAMESPACE}

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation on 'kubectl descibe' command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe){:target="_blank"}
        - [Kubernetes Documentation on Kubernetes contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/od-od-grnwhnnpr-argocd-app/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'otel-demo ArgoCD Application Health  ';
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