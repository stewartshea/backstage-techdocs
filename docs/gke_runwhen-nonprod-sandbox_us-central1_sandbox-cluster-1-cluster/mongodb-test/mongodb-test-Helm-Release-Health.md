---
title: "mongodb-test Helm Release Health  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: mongodb-test'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/helm-icon-color.svg" alt="Icon" />
    </td>
  </tr>
</table>
# mongodb-test Helm Release Health    
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
    Last updated 8 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-fluxcd-helm-health/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-fluxcd-helm-health" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### List all available FluxCD Helmreleases in Namespace `mongodb-test`  
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
      <pre class="code-block"><code id="codeBlock1">```kubectl get HelmRelease.helm.toolkit.fluxcd.io -n mongodb-test --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster```</code></pre>
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
    #### Fetch Installed FluxCD Helmrelease Versions in Namespace `mongodb-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get a list of the specified resource type in the provided namespace. It will return the name, the last applied revision, and the last attempted revision for each item in the list. The command uses the context option to specify which Kubernetes cluster to query. The results are then formatted using the jsonpath option to display them in a user-friendly way.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```kubectl get HelmRelease.helm.toolkit.fluxcd.io -n mongodb-test -o=jsonpath="{range .items[*]}{'\nName: '}{@.metadata.name}{'\nlastAppliedRevision:'}{@.status.lastAppliedRevision}{'\nlastAttemptedRevision:'}{@.status.lastAttemptedRevision}{'\n---'}{end}" --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster || true```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            
            # This command is used to query a resource of type ${RESOURCE_NAME} from a namespace called "${NAMESPACE}" on a cluster pointed to by the context "${CONTEXT}". 

            # Create multi line statement
            kubectl get ${RESOURCE_NAME} \
            -n ${NAMESPACE} \ 
            -o=jsonpath="{range .items[*]}{'\nName: '}{@.metadata.name}{'\nlastAppliedRevision:'}{@.status.lastAppliedRevision}{'\nlastAttemptedRevision:'}{@.status.lastAttemptedRevision}{'\n---'}{end}" \
            --context ${CONTEXT} \
            || true

    ???- abstract "Helpful Links"

            
        - [Kubernetes Overview](https://kubernetes.io/docs/concepts/){:target="_blank"}
        - [Core Concept in Kubernetes](https://kubernetes.io/docs/reference/kubectl/overview/){:target="_blank"}
        - [Understanding Namespaces](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/){:target="_blank"}
        - [JSONPath](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}

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
    #### Fetch Mismatched FluxCD HelmRelease Version in Namespace `mongodb-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will help retrieve information about a Kubernetes resource from within a specified namespace and context. It retrieves the last attempted revision and last applied revision for that resource, and prints it out in a readable format on the command line. This command is useful when debugging issues related to application updates or deployments, as it can be used to identify which versions of an application are running on a particular node or cluster.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```kubectl get HelmRelease.helm.toolkit.fluxcd.io -n mongodb-test -o json --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster | jq -r '.items[] | select(.status.lastAppliedRevision!=.status.lastAttemptedRevision) | "Name: " + .metadata.name + " Last Attempted Version: " + .status.lastAttemptedRevision + " Last Applied Revision: " + .status.lastAppliedRevision'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # This command allows users to collect and parse information from a given Kubernetes resource in order to compare the last applied vs. last attempted revision for an update.

            # kubectl is Kubernetes's command-line interface (CLI) for performing operations on resources. 
            # ${RESOURCE_NAME} is the name of the Kubernetes resource that the user wants to get information about. 
            # -n ${NAMESPACE} specifies what namespaced the resource should be retrieved from.
            # -o json option adds an additional formatting, printing the results in JSON format.
            # --context ${CONTEXT} selects the Kubernetes context which contains information about the cluster connection settings.
            # jq is a lightweight command-line JSON processor and is used to filter, traverse, and format JSON output
            # '.items[] | select(.status.lastAppliedRevision!=.status.lastAttemptedRevision) | "Name: " + .metadata.name + " Last Attempted Version: " + .status.lastAttemptedRevision + " Last Applied Revision: " + .status.lastAppliedRevision' is a filtering expression used with jq to enable comparing the last applied vs. last attempted revisions for an update.

            kubectl get ${RESOURCE_NAME} -n ${NAMESPACE} -o json --context ${CONTEXT} \
             | jq -r '.items[] \
              | select(.status.lastAppliedRevision!=.status.lastAttemptedRevision) \
              | "Name: " + .metadata.name + " Last Attempted Version: " + .status.lastAttemptedRevision + " Last Applied Revision: " + .status.lastAppliedRevision'

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [jq Documentation](https://stedolan.github.io/jq/manual/){:target="_blank"}
        - [Kubernetes Documentation - Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}

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
    #### Fetch FluxCD HelmRelease Error Messages in Namespace `mongodb-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check the status of an existing Kubernetes resource in a given context and namespace. It will show all resources with a status of "False", as well as the resource name and any associated messages that indicate why it might not be functioning properly. The command uses `kubectl`, which is a command line tool for communicating with the Kubernetes API, to get the desired information from your cluster. The `-n` flag specifies the namespace in which the resource exists, and the `-o=jsonpath` flag is used to format the output for easier readability. The `--context` flag allows you to specify a particular context within your cluster. This command can be especially useful when troubleshooting and debugging applications or resources in Kubernetes.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```kubectl get HelmRelease.helm.toolkit.fluxcd.io -n mongodb-test -o=jsonpath="{range .items[?(@.status.conditions[].status=='False')]}{'-----\nName: '}{@.metadata.name}{'\n'}{@.status.conditions[*].message}{'\n'}{end}" --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster || true```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get info about a particular Kubernetes resource in an available namespace
            # using the 'kubectl' command and output it in JSON format
            RESOURCE_NAME="<type of k8s resource to get info about>" # Example: "pods"
            NAMESPACE="<available namespace>"    # Example: "default"
            CONTEXT="<name of the context>"      # Obtained via 'kubectl config get-contexts'

            # Let's use the kubectl command to execute our task!
            kubectl \
              get ${RESOURCE_NAME} \
              -n ${NAMESPACE} \
              -o=jsonpath="{range .items[?(@.status.conditions[].status=='False')]}{'-----\nName: '}{@.metadata.name}{'\n'}{@.status.conditions[*].message}{'\n'}{end}" \
              --context ${CONTEXT} || true

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation of kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubernetes Documentation about Resource Names](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/){:target="_blank"}
        - [Kubernetes Documentation about Namespaces](https://kubernetes.io/docs/tasks/administer-cluster/namespaces/){:target="_blank"}
        - [Kubernetes Documentation of jsonpath](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Kubernetes Documentation about Contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}

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
    #### Check for Available Helm Chart Updates in Namespace `mongodb-test`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command retrieves Helm releases from a Kubernetes namespace and compares their installed versions to the available versions in their corresponding repository, in order to determine if an update is available. 

    It takes five parameters of information:

    1. NAMESPACE: This is the name of the Kubernetes namespace from which to fetch the Helm releases.
    2. CONTEXT: This is the name of the Kubernetes context that will be used for the API requests.
    3. RESOURCE_NAME: This is the resource type that contains the Helm releases, e.g. "helmreleases".
    4. CHART_NAME: This is the name of chart as it appears in the Helm repository.
    5. CHART_VERSION: This is the version of the Helm chart that has already been installed.

    Using these parameters, the command fetches the Helm Releases from the Kubernetes namespace and looks up the specified Chart in its repo. It then uses the installed Chart Version and the current available versions in the repo to determine whether an update is available. It then prints out this information with the following output format: 

    Release: <release name> | Chart: <chart namespace>/<chart name> | Installed Version: <version installed> | Available Update: <true or false> | Available Version: <available version>
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock5">```namespace="mongodb-test" context="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; helm_releases=$(kubectl get HelmRelease.helm.toolkit.fluxcd.io -n "$namespace" --context "$context" -o json | jq -r '.items[] | .metadata.name'); echo "$helm_releases" | while IFS= read -r release; do chart_details=$(kubectl get HelmRelease.helm.toolkit.fluxcd.io "$release" -n "$namespace" --context "$context" -o json | jq -r '.spec.chart.spec // empty'); if [[ -n "$chart_details" ]]; then chart_kind=$(echo "$chart_details" | jq -r '.sourceRef.kind // empty'); chart_name=$(echo "$chart_details" | jq -r '.chart // empty'); chart_source_name=$(echo "$chart_details" | jq -r '.sourceRef.name // empty'); chart_namespace=$(echo "$chart_details" | jq -r '.sourceRef.namespace // empty'); chart_version=$(echo "$chart_details" | jq -r '.version // "N/A"'); if [[ "$chart_kind" == "HelmRepository" && -n "$chart_name" && -n "$chart_namespace" ]]; then repo_url=$(kubectl get helmrepositories.source.toolkit.fluxcd.io "$chart_source_name" -n "$chart_namespace" --context "$context" -o json | jq -r '.spec.url // empty'); if [[ -n "$repo_url" ]]; then temp_repo_name="$chart_source_name-temp-$release"; add_repo=$(helm repo add "$temp_repo_name" "$repo_url"); available_chart_version=$(helm search repo "$temp_repo_name"/"$chart_name" --version ">$chart_version" --output json | jq -r '.[].version'); if [[ -n "$available_chart_version" ]]; then sorted_versions=($(echo "${available_chart_version[@]}" | tr ' ' '\n' | sort -V)); available_version=${sorted_versions[-1]}; version_update_available="True"; else available_version="N/A"; version_update_available="False"; fi; remove_repo=$(helm repo remove "$temp_repo_name"); else available_version="N/A"; version_update_available="False"; fi; else available_version="N/A"; version_update_available="False"; fi; else chart_name="N/A"; chart_namespace="N/A"; chart_version="N/A"; available_version="N/A"; version_update_available="False"; fi; echo "Release: $release | Chart: $chart_namespace/$chart_name | Installed Version: $chart_version | Available Update: $version_update_available | Available Version: $available_version"; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock5" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage5" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Get the namespace from the environmental variable
            namespace="${NAMESPACE}"

            # Get the context of the current kubernetes cluster
            context="${CONTEXT}"

            # Get all the helm releases in a namespace using kubectl and save them into the variable helm_releases
            helm_releases=$(kubectl get ${RESOURCE_NAME} -n "$namespace" --context "$context" -o json | jq -r '.items[] | .metadata.name')

            # Loop through each of our helm releases
            echo "$helm_releases" | while IFS= read -r release; do

                # Get the chart details of the release using kubectl
                chart_details=$(kubectl get ${RESOURCE_NAME} "$release" -n "$namespace" --context "$context" -o json | jq -r '.spec.chart.spec // empty')

                # Check if we have any chart details
                if [[ -n "$chart_details" ]]; then

                    # Get the kind of chart, the name and the namespace referred by
                    chart_kind=$(echo "$chart_details" | jq -r '.sourceRef.kind // empty')
                    chart_name=$(echo "$chart_details" | jq -r '.chart // empty')
                    chart_source_name=$(echo "$chart_details" | jq -r '.sourceRef.name // empty')
                    chart_namespace=$(echo "$chart_details" | jq -r '.sourceRef.namespace // empty')
                    chart_version=$(echo "$chart_details" | jq -r '.version // "N/A"')

                    # Only for helm charts check the update availability
                    if [[ "$chart_kind" == "HelmRepository" && -n "$chart_name" && -n "$chart_namespace" ]]; then
                        # Get the repository url from helm repository configmap
                        repo_url=$(kubectl get helmrepositories.source.toolkit.fluxcd.io "$chart_source_name" -n "$chart_namespace" --context "$context" -o json | jq -r '.spec.url // empty')
                        if [[ -n "$repo_url" ]]; then
                            # Create a temp repo with helm to search for available versions
                            temp_repo_name="$chart_source_name-temp-$release"
                            add_repo=$(helm repo add "$temp_repo_name" "$repo_url")

                            # Search the temp repo for latest version
                            available_chart_version=$(helm search repo "$temp_repo_name"/"$chart_name" --version ">$chart_version" --output json | jq -r '.[].version')
                            if [[ -n "$available_chart_version" ]]; then

                                # Sort the version array and assign the highest version to available_version
                                sorted_versions=($(echo "\${available_chart_version[@]}" | tr ' ' '\n' | sort -V))
                                available_version=\${sorted_versions[-1]}
                                version_update_available="True"
                            else
                                # If not version is available assign N/A to available_version 
                                available_version="N/A"
                                version_update_available="False"
                            fi

                            # Remove the temp repo since we have finished searching
                            remove_repo=$(helm repo remove "$temp_repo_name")
                        else
                            # If no repository is found assign N/A to available_version and False to version_update_available
                            available_version="N/A"
                            version_update_available="False"
                        fi
                    else
                        # If not a helm chart assign N/A to available_version and False to version_update_available
                        available_version="N/A"
                        version_update_available="False"
                    fi
                else
                    # If no chart details are found set available values to N/A and version_update_available to False
                    chart_name="N/A"
                    chart_namespace="N/A"
                    chart_version="N/A"
                    available_version="N/A"
                    version_update_available="False"
                fi

                # Output information about the current release
                echo "Release: $release | Chart: $chart_namespace/$chart_name | Installed Version: $chart_version | Available Update: $version_update_available | Available Version: $available_version";
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes Documentation - Contexts and Configuration](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Helm Documentation - Repository Charts](https://helm.sh/docs/developing_charts/#chart-repositories){:target="_blank"}
        - [Kubectl Documentation - Resource Types](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [jq Documentation](https://stedolan.github.io/jq/manual/){:target="_blank"}
        - [Helm Documentation - Search Command](https://helm.sh/docs/helm/helm_search/){:target="_blank"}

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
    showConfig('/workspaces/ws/slxs/me-mt-grnwhnnpr-flux-helm/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'mongodb-test Helm Release Health  ';
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