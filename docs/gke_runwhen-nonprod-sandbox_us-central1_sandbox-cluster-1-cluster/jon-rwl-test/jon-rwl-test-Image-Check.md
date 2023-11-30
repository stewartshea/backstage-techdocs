---
title: "jon-rwl-test Image Check  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: None'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/container-registry.svg" alt="Icon" />
    </td>
  </tr>
</table>
# jon-rwl-test Image Check    
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
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-image-check/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-image-check" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Check Image Rollover Times for Namespace `jon-rwl-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command allows you to get information about the running pods within a Kubernetes cluster. Specifically, it will grab information regarding the images the pods are running and when they were last started in an JSON format. The --context flag lets you specify which cluster you would like to query while you can limit the query to a specific namespace with the -n flag. The field-selector flag allows you to filter down the results to only the pods with a status of 'Running'. Finally, we're using the jq command to post-process the output and display only the image and last started times.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jon-rwl-test --field-selector=status.phase==Running -o json | jq -r '[.items[] | "Images: " + (.spec.containers[].image|tostring) + ", Last Started Times:" + (.status.containerStatuses[].state.running.startedAt|tostring)]'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             

            # Get a list of all pods in the current ${CONTEXT} and from the ${NAMESPACE}. Filter out any with status that is not running.
            # Output the results as json
            kubectl get pods \
                --context=${CONTEXT} \ # Context for the list of pods to be gathered
                -n ${NAMESPACE} \ # Namespace scoping the list of pods
                --field-selector=status.phase==Running \ # Only show pods with status == Running
                -o json # Output formatting to json

            # Use the jq command to interpret and format the json for better readability 
            jq -r '[.items[] | "Images: " + (.spec.containers[].image|tostring) + ", Last Started Times:" + (.status.containerStatuses[].state.running.startedAt|tostring)]' \ 
            # Select information for each pod including the image being used and the last time it was started.

    ???- abstract "Helpful Links"

            
        - [Kubernetes Contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [AWS EKS Documentation for using field selectors](https://docs.aws.amazon.com/eks/latest/userguide/filter-expressions.html){:target="_blank"}
        - [jq Manual Explanation of Filtering Arrays](https://stedolan.github.io/jq/manual/#Arrayfilters){:target="_blank"}

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
    #### List Images and Tags for Every Container in Running Pods for Namespace `jon-rwl-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get information about the running pods in a kubernetes cluster. It will give you the pod name, its status and the container details including container name, image path, and image tag. This command uses the Kubectl (Kubernetes Command Line Tool) to connect to the Kubernetes cluster and select the running pods in the specified namespace and context. The output is shown as JSON which can then be parsed through JQ (a command line JSON processor)  to provide the relevant info for each pod.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jon-rwl-test --field-selector=status.phase==Running -o=json | jq -r '.items[] | "---", "pod_name: " + .metadata.name, "Status: " + .status.phase, "containers:", (.spec.containers[] | "- container_name: " + .name, "  image_path: " + (.image | split(":")[0]), "  image_tag: " + (.image | split(":")[1])), "---"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command lists all running pod names in the desired namespaces along with their respective container name, path and tag.

            #Split the one line command into multiple lines for clarity
            kubectl get pods \ 
                --context=${CONTEXT} \ #Context specifies the environment where the command should run on - like 'production' or 'dev'
                -n ${NAMESPACE} \ #Namespace is the Kubernetes resource containing groups of objects for further organization
                --field-selector=status.phase==Running \ #Filters for only running pods
                -o=json \ #Output json as result of the command
                | jq -r '.items[] | "---", "pod_name: " + .metadata.name,  #Retrieves all pods' names
                "Status: " + .status.phase,  #Retrieves pod's status
                "containers:",  #Displays all the containers present for that pod
                (.spec.containers[] | "- container_name: " + .name, #Retrieves container name
                " \ image_path: " + (.image | split(":")[0]), #Retrieves an image's path
                " \ image_tag: " + (.image | split(":")[1])), #Retrievs an image's tag
                "---"' #Represents end of a pod data

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl overview](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubernetes Documentation - Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors){:target="_blank"}
        - [Kubernetes Documentation - jq overview](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#advanced-jsonpath-expressions-with-jq){:target="_blank"}

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
    #### List Images and Tags for Every Container in Failed Pods for Namespace `jon-rwl-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used in Kubernetes to get information about the pods in a given namespace and context that are in a failed status. It uses kubectl (Kubernetes control) to call the list of pods in the specified namespace and context, using the field-selector parameter to specify which pods should be selected (in this case, only pods in a failed status). The output is then formatted as json and piped through jq for further processing. The final output lists the pod name, its status, and each container within the pod, along with its image path and tag.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get pods --context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -n jon-rwl-test --field-selector=status.phase==Failed -o=json | jq -r '.items[] | "---", "pod_name: " + .metadata.name, "Status: " + .status.phase, "containers:", (.spec.containers[] | "- container_name: " + .name, "  image_path: " + \(.image | split(":")[0]), "  image_tag: " + (.image | split(":")[1])), "---"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command lists all failed PODs from the given context and namespace.
            # It requires that kubectl, jq and the CONTEXT and NAMESPACE variables are set properly
            # It outputs pod name, its status and each container's details in a way that is
            # not natively supported by Kubernetes. 

            CONTEXT=${CONTEXT}
            NAMESPACE=${NAMESPACE}

            # List all failed PODs from the given context and namespace
            PODS=$(kubectl get pods --context=${CONTEXT} -n ${NAMESPACE} --field-selector=status.phase==Failed -o=json)

            # Use jq to parse the output and build a new one in a more human readable format
            OUTPUT=$(echo "${PODS}" | jq -r '.items[] | "---", "pod_name: " + .metadata.name, "Status: " + .status.phase, "containers:", (.spec.containers[] | "- container_name: " + .name, " \ image_path: " + \(.image | split(":")[0]), " \ image_tag: " + (.image | split(":")[1])), "---"')

            # Print the result
            echo $OUTPUT

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation: Pods](https://kubernetes.io/docs/concepts/workloads/pods/){:target="_blank"}
        - [Kubernetes Documentation: Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#use-different-contexts-to-switch-between-clusters){:target="_blank"}
        - [Kubernetes Documentation: Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes Documentation: FieldSelector](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#fieldselector-v1-meta){:target="_blank"}
        - [Kubernetes Documentation: JSONPath](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}

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
    #### List ImagePullBackOff Events and Test Path and Tags for Namespace `jon-rwl-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to pull images in a Kubernetes cluster or check if the pulled images exist. It first gets all the events of the past five minutes in the specified namespace and context, then it looks for events with a 'BackOff' reason which usually indicate an image pull failure. If any are found, we run a Skopeo Pod in the same namespace and context so that we can skopeo inspect the image path and tag to see if it exists. Finally, it prints out a list of available tags for the image path and deletes the Skopeo pod.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```NAMESPACE=jon-rwl-test; POD_NAME="skopeo-pod"; CONTEXT="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; events=$(kubectl get events -n $NAMESPACE --context=$CONTEXT -o json | jq --arg timestamp "$(date -u -v -5M +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u -d "-5 minutes" +"%Y-%m-%dT%H:%M:%SZ")" '.items[] | select(.lastTimestamp > $timestamp)'); if [[ ! -z "${events-unset}" ]]; then image_pull_backoff_events=$(echo "$events" | jq -s '[.[] | select(.reason == "BackOff") | .message] | .[]'); else echo "No events found in the last 5 minutes"; exit; fi; if [[ $image_pull_backoff_events =~ "Back-off pulling image" ]]; then echo "Running Skopeo Pod"; kubectl run $POD_NAME --restart=Never -n $NAMESPACE --context=$CONTEXT --image=quay.io/containers/skopeo:latest --command -- sleep infinity && echo "Waiting for the $POD_NAME to be running..." && kubectl wait --for=condition=Ready pod/$POD_NAME -n $NAMESPACE --context=$CONTEXT; else echo "No image pull backoff events found"; exit; fi; while IFS= read -r event; do echo "Found BackOff with message: $event"; echo "Checking if we can reach the image with skopeo and what tags exist"; container_image_path_tag=$(echo "$event" | cut -d' ' -f4 | tr -d '"' | tr -d '\'); container_image_path="${container_image_path_tag%:*}"; container_image_tag="${container_image_path_tag#*:}"; if [ -z "$container_image_path" ] || [ -z "$container_image_tag" ]; then continue; fi; skopeo_output=$(kubectl exec $POD_NAME -n $NAMESPACE --context=$CONTEXT -- skopeo inspect docker://$container_image_path:$container_image_tag); skopeo_exit_code=$?; if [ $skopeo_exit_code -eq 0 ]; then echo "Container image '$container_image_path:$container_image_tag' exists."; else echo "Container image '$container_image_path:$container_image_tag' does not exist."; echo "Available tags for '$container_image_path':"; available_tags=$(kubectl exec $POD_NAME -n $NAMESPACE --context=$CONTEXT -- skopeo list-tags docker://$container_image_path ); echo "$available_tags"; fi; done <<<"$image_pull_backoff_events" && echo "Deleting Skopeo pod" && kubectl delete pod $POD_NAME -n $NAMESPACE --context=$CONTEXT && echo "Done"```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get the name of the namespace to use.
            NAMESPACE=${NAMESPACE};

            # Set a default pod name for convenience and to allow for easy cleanup later.
            POD_NAME="skopeo-pod";

            # Gather the context info so that we can operate on the correct k8s cluster.
            CONTEXT="${CONTEXT}";

            # Use kubectl to get events from the specified namespace in JSON format
            # and use jq to filter by the last 5 minutes since script execution.
            # This will return the recent events related to the namespace as an array.
            events=$(kubectl get events -n $NAMESPACE --context=$CONTEXT -o json | 
                     jq --arg timestamp "$(date -u -v -5M +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || 
                     date -u -d "-5 minutes" +"%Y-%m-%dT%H:%M:%SZ")" '.items[] | 
                     select(.lastTimestamp > $timestamp)');

            # Check to see if any results were returned.
            if [[ ! -z "\${events-unset}" ]]; then
              # If so, extract any events regarding a BackOff into another variable.
              image_pull_backoff_events=$(echo "$events" | 
                                          jq -s '[.[] | 
                                                 select(.reason == "BackOff") | 
                                                 .message] | .[]');
            else
              # Otherwise exit the script as there's nothing to do.
              echo "No events found in the last 5 minutes";
              exit;
            fi;

            # By this point, we should have some list of events attached to the 
            # image_pull_backoff_events variable so we are going to check it against
            # a regex to see if we prefer 'Back-off pulling image'
            if [[ $image_pull_backoff_events =~ "Back-off pulling image" ]]; then
              echo "Running Skopeo Pod";

              # Now is when we'll create the pod that will allow us access to skopeo.
              # This can be done using kubectl along with the namespace and context set previous.
              kubectl run $POD_NAME --restart=Never -n $NAMESPACE --context=$CONTEXT \
                                   --image=quay.io/containers/skopeo:latest \
                                   --command -- sleep infinity
              # And then we tell the user we're waiting for it to start up.
              echo "Waiting for the $POD_NAME to be running..."
              # Then we wait till the pod is ready before proceeding.
              kubectl wait --for=condition=Ready pod/$POD_NAME -n $NAMESPACE --context=$CONTEXT;

            # If not, exit with message.
            else
              echo "No image pull backoff events found";
              exit;
            fi;

            # Here, events are looped over, and each event returns ‘BackOff’ message.
            while IFS= read -r event; do 
              echo "Found BackOff with message: $event";

              # Once we've identified a BackOff event, we need to parse out
              # the container image path and the tag.
              echo "Checking if we can reach the image with skopeo and what tags exist";
              
              container_image_path_tag=$(echo "$event" | cut -d' ' -f4 | tr -d '"' |tr -d '\');
              container_image_path="\${container_image_path_tag%:*}";
              container_image_tag="\${container_image_path_tag#*:}";

              # Check that the variables were populated correctly.
              if [ -z "$container_image_path" ] || [ -z "$container_image_tag" ]; then
                continue;
              fi;

              # Using the new pod, try and inspect the image provided with skopeo.
              skopeo_output=$(kubectl exec $POD_NAME -n $NAMESPACE --context=$CONTEXT \
                                                     -- skopeo inspect docker://$container_image_path:$container_image_tag);
              skopeo_exit_code=$?;

              # Depending on the result, print a message.
              if [ $skopeo_exit_code -eq 0 ]; then
                echo "Container image '$container_image_path:$container_image_tag' exists.";
              else
                echo "Container image '$container_image_path:$container_image_tag' does not exist.";
              
                # Just in case it doesn't exist, let's try and print out the available tags.
                echo "Available tags for '$container_image_path':";
                available_tags=$(kubectl exec $POD_NAME -n $NAMESPACE --context=$CONTEXT \
                                                    -- skopeo list-tags docker://$container_image_path );
                echo "$available_tags";
              fi;

            # Loop ends here.
            done <<<"$image_pull_backoff_events"
            # Cleanup the pod once the loop has finished.
            echo "Deleting Skopeo pod"
            kubectl delete pod $POD_NAME -n $NAMESPACE --context=$CONTEXT
            echo "Done"

    ???- abstract "Helpful Links"

            
        - [Kubernetes Events](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#event-v1-core){:target="_blank"}
        - [jq command line processor](https://stedolan.github.io/jq/){:target="_blank"}
        - [Date command](http://www.freebsd.org/cgi/man.cgi?query=date&sektion=1){:target="_blank"}
        - [Cut command](http://www.freebsd.org/cgi/man.cgi?query=cut&sektion=1){:target="_blank"}
        - [Tr command](http://www.freebsd.org/cgi/man.cgi?query=tr&sektion=1){:target="_blank"}
        - [IFS environment variable](http://wiki.bash-hackers.org/syntax/shellvars#ifs){:target="_blank"}
        - [kubectl run command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run){:target="_blank"}
        - [kubectl wait command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#wait){:target="_blank"}
        - [kubectl exec command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec){:target="_blank"}
        - [Skopeo image utility](https://github.com/containers/skopeo){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/jrt-jrt-grnwhnnpr-image-check/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'jon-rwl-test Image Check  ';
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