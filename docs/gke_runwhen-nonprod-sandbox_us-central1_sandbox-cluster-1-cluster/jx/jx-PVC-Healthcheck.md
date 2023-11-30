---
title: "jx PVC Healthcheck  "
tags: 

  - 'cluster: gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster'


  - 'namespace: jx'

---

<table class="invisible-table">
  <tr>
    <td class="icon-cell">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/kubernetes/resources/labeled/pvc.svg" alt="Icon" />
    </td>
  </tr>
</table>
# jx PVC Healthcheck    
<div class="author-block">
  <img src="/github_profile_cache/stewartshea_icon.png" alt="Profile Avatar" class="author-avatar">
  <div class="author-info">
    <a href="https://github.com/stewartshea" target="_blank">
    <h3 class="author-name">stewartshea</a></h3>
  <p class="author-bio">
      <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/terminal.svg" alt="Icon 1" class="bio-icon">
    6 Troubleshooting Commands</p>
      <p class="author-bio">
     <img src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/calendar_month.svg" alt="Icon 1" class="bio-icon">
    Last updated 6 days ago </p>
  </div>
</div>
  

<p></p>
<hr class="custom-hr">
<div class="command-header-grid">
  <div class="grid-item">
    <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/public.svg" alt="Icon">
    <a href="https://github.com/runwhen-contrib/rw-cli-codecollection/tree/main/codebundles/k8s-pvc-healthcheck/runbook.robot" target="_blank">Public Source Code</a>
  </div>

  <div class="grid-item">
    <a href="#" id="configLink" onclick="return false;">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/lock.svg" alt="Icon">
      Private Configuration
    </a>
  </div>

  <div class="grid-item">
    <a href="https://github.com/orgs/runwhen-contrib/discussions?discussions_q=is%3Aopen+k8s-pvc-healthcheck" target="_blank">
      <img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/forum.svg" alt="Icon">
      Join Discussion
    </a>
  </div>
</div>
<hr class="custom-hr">

### Troubleshooting Commands



!!! note ""
    <div class="command-title">
    #### Fetch Events for Unhealthy Kubernetes PersistentVolumeClaims in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get events associated with each unbound Persistent Volume Claim (PVC) in a specific Kubernetes namespace. PVCs are the way Kubernetes makes it possible to use persistent storage such as disk drives or databases within your cluster. The command first loops through all of the unbound PVCs in your Kubernetes namespace, and for each one it then queries for any related events using the 'kubectl get events' command. Finally, it prints out the various event details such as 'Last Timestamp', 'Name', and 'Message.' This helps engineers know the history of their PVCs as well as any errors that might have been encountered.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock1">```for pvc in $(kubectl get pvc -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '.items[] | select(.status.phase != "Bound") | .metadata.name'); do kubectl get events -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster --field-selector involvedObject.name=$pvc -o json | jq '.items[]| "Last Timestamp: " + .lastTimestamp + ", Name: " + .involvedObject.name + ", Message: " + .message'; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock1" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage1" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Iterate through each persistent volume claim in a namespace and context
            for pvc in $(kubectl get pvc -n ${NAMESPACE} --context ${CONTEXT} -o json | jq -r '.items[] | select(.status.phase != "Bound") | .metadata.name'); do 
                # Get events associated with the PVC
                kubectl get events -n ${NAMESPACE} --context ${CONTEXT} --field-selector involvedObject.name=$pvc -o json | 
                # Parse events to generate required output
                jq '.items[]| "Last Timestamp: " + .lastTimestamp + ", Name: " + .involvedObject.name + ", Message: " + .message'; 
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation - PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims){:target="_blank"}
        - [Kubernetes Documentation - Fields Selectors](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#field-selectors){:target="_blank"}
        - [Kubernetes Documentation - Events and Event Filtering](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#event-v1-core){:target="_blank"}

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
    #### List PersistentVolumeClaims in Terminating State in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get information about Persistent Volume Claims (PVC) in the specified Kubernetes namespace, through the specified context. This command will output a list of PVCs that are currently in a Terminating state (i.e. they have had their deletion process started). The output of the command includes information such as the PVC name, the time its deletion process began, and the list of finalizers associated with it.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock2">```namespace=jx; context=gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster; kubectl get pvc -n $namespace --context=$context -o json | jq -r '.items[] | select(.metadata.deletionTimestamp != null) | .metadata.name as $name | .metadata.deletionTimestamp as $deletion_time | .metadata.finalizers as $finalizers | "\($name) is in Terminating state (Deletion started at: \($deletion_time)). Finalizers: \($finalizers)"'```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock2" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage2" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Store the intended namespace and context variables in easy to use variables.
            NAMESPACE=my-namespace
            CONTEXT=my-context

            # kubectl get pvc
            # Get a list of all Persistent Volume Claims (pvc) from the namespace 'my-namespace', using the context 'my-context'
            kubectl get pvc -n $NAMESPACE --context=$CONTEXT -o json

            # jq command
            # Parse the returned JSON file using the 'jq' command and filter out any PVCs that don't have a deletion timestamp
            # Also select the name, deletion timestamp and finalizers properties for each item
            jq -r '.items[] | select(.metadata.deletionTimestamp != null) | .metadata.name as $name | .metadata.deletionTimestamp as $deletion_time | .metadata.finalizers as $finalizers | "\($name) is in Terminating state (Deletion started at: \($deletion_time)). Finalizers: \($finalizers)"'

    ???- abstract "Helpful Links"

            
        - [Kubernetes context and namespace reference guide](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#namespace-v1-core){:target="_blank"}
        - [Kubectl objects documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#persistentvolumeclaim-v1-core){:target="_blank"}
        - [JSONPath reference guide](https://goessner.net/articles/JsonPath/){:target="_blank"}
        - [jq manual for filtering JSON documents](https://stedolan.github.io/jq/manual/){:target="_blank"}

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
    #### List PersistentVolumes in Terminating State in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to fetch information about Persistent Volumes (PVs) that are being terminated in a Kubernetes cluster. It uses the kubectl get pv command, which can be used to list all of the available PVs and their statuses in the cluster. After that, it then uses jq, which is a command-line JSON processor, to filter out and identify only those PVs that have a status of 'Terminating'. Once those PVs have been identified, the command then uses the kubectl get events command to fetch and display the relevant events related to those PVs, such as the timestamp when they were last updated and the message associated with them. The result of this command is a display of the PVs that are being terminated in your Kubernetes cluster along with useful details about them.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock3">```for pv in $(kubectl get pv --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '.items[] | select(.status.phase == "Terminating") | .metadata.name'); do kubectl get events --all-namespaces --field-selector involvedObject.name=$pv --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq '.items[]| "Last Timestamp: " + .lastTimestamp + " Name: " + .involvedObject.name + " Message: " + .message'; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock3" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage3" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
             

            # Get a list of Persistent Volumes in the current context
            PV_LIST=$(kubectl get pv --context ${CONTEXT} -o json | jq -r '.items[]') 

            # Iterate over each PV and check for "Terminating" status
            for pv in $PV_LIST; do
                PV_STATUS=$(echo $pv | jq -r .status.phase)
                # If status is "Terminating", get events for respective PV
                if [ "$PV_STATUS" = "Terminating" ]; then
                    PV_NAME=$(echo $pv | jq -r .metadata.name)
                    # Get Events related to the PV
                    PV_EVENTS=$(kubectl get events --all-namespaces --field-selector involvedObject.name=$PV_NAME --context ${CONTEXT} -o json | jq)
                    # Loop over each event and output lastTimestamp, name and message
                    for event in $РV_EVENTS; do 
                        echo $(echo $event | jq '"Last Timestamp: " + .lastTimestamp + " Name: " + .involvedObject.name + " Message: " + .message')
                    done
                fi
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes Docs - PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/){:target="_blank"}
        - [Kubernetes Docs - kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get){:target="_blank"}
        - [Kubernetes Docs - events](https://kubernetes.io/docs/concepts/cluster-administration/logging/){:target="_blank"}
        - [jq Tutorial - Parsing JSON](https://stedolan.github.io/jq/tutorial/){:target="_blank"}

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
    #### List Pods with Attached Volumes and Related PersistentVolume Details in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command will loop through and provide details on any of the pods in the specified namespace that have a "Running" status. It provides information such as Pod name, Persistent Volume Claim name, Persistent Volume name, Status, Node Name, Zone, Storage Class Name, Access Modes, Reclaim Policy, and CSI Driver. This information is necessary to get an understanding of the current state of Kubernetes resources and can help with troubleshooting or configuration.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock4">```for pod in $(kubectl get pods -n jx --field-selector=status.phase=Running --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do for pvc in $(kubectl get pods $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{"\n"}{end}'); do pv=$(kubectl get pvc $pvc -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.spec.volumeName}') && status=$(kubectl get pv $pv --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.status.phase}') && node=$(kubectl get pod $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.spec.nodeName}') && zone=$(kubectl get nodes $node --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.metadata.labels.topology\.kubernetes\.io/zone}') && ingressclass=$(kubectl get pvc $pvc -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.spec.storageClassName}') && accessmode=$(kubectl get pvc $pvc -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.status.accessModes[0]}') && reclaimpolicy=$(kubectl get pv $pv --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.spec.persistentVolumeReclaimPolicy}') && csidriver=$(kubectl get pv $pv --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{.spec.csi.driver}')&& echo -e "\n------------\nPod: $pod\nPVC: $pvc\nPV: $pv\nStatus: $status\nNode: $node\nZone: $zone\nIngressClass: $ingressclass\nAccessModes: $accessmode\nReclaimPolicy: $reclaimpolicy\nCSIDriver: $csidriver\n"; done; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock4" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage4" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Convert this one-line command into a multi-line command, adding verbose comments to educate new users of Kubernetes and related cli commands

            # Iterate over all the pods in the specified namespace using 'kubectl get pods' 
            for pod in $(kubectl get pods -n ${NAMESPACE} --field-selector=status.phase=Running --context ${CONTEXT} -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do 
                # For each pod, get it's associated persistent volume claim (PVC) 
                for pvc in $(kubectl get pods $pod -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{"\n"}{end}'); do

                    # Get the underlying persistent volume (PV) from the PVC
                    pv=$(kubectl get pvc $pvc -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{.spec.volumeName}') 
                    
                    # Get the status of the PV from the underlying storage provider
                    status=$(kubectl get pv $pv --context ${CONTEXT} -o jsonpath='{.status.phase}') 
                    
                    # Get the node where the pod is running
                    node=$(kubectl get pod $pod -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{.spec.nodeName}') 
                    
                    # Get the availability zone for the node
                    zone=$(kubectl get nodes $node --context ${CONTEXT} -o jsonpath='{.metadata.labels.topology\.kubernetes\.io/zone}') 
                    
                    # Get the ingress class of the PVC
                    ingressclass=$(kubectl get pvc $pvc -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{.spec.storageClassName}')
                    
                    # Get the access mode of the PVC
                    accessmode=$(kubectl get pvc $pvc -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{.status.accessModes[0]}') 
                    
                    # Get the reclaim policy of the PV
                    reclaimpolicy=$(kubectl get pv $pv --context ${CONTEXT} -o jsonpath='{.spec.persistentVolumeReclaimPolicy}') 
                   
                   # Get the driver name of the CSI based PV
                    csidriver=$(kubectl get pv $pv --context ${CONTEXT} -o jsonpath='{.spec.csi.driver}')
                
                    # Output the details of the Pod, PVC, PV with the other details
                    echo -e "\n------------\nPod: $pod\nPVC: $pvc\nPV: $pv\nStatus: $status\nNode: $node\nZone: $zone\nIngressClass: $ingressclass\nAccessModes: $accessmode\nReclaimPolicy: $reclaimpolicy\nCSIDriver: $csidriver\n"; done; done

    ???- abstract "Helpful Links"

            
        - [Kubernetes - Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/){:target="_blank"}
        - [Kubernetes Contexts and Configurations](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/){:target="_blank"}
        - [Kubernetes Documentation - Managing Resources with JSONPath](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Kubernetes Documentation - Volumes](https://kubernetes.io/docs/concepts/storage/volumes/){:target="_blank"}
        - [Kubernetes Documentation - Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/){:target="_blank"}
        - [Kubernetes Documentation - Nodes](https://kubernetes.io/docs/concepts/architecture/nodes/){:target="_blank"}
        - [Kubernetes Documentation - Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/){:target="_blank"}
        - [Kubernetes Documentation - Persistent Volumes Reclaim Policy](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy){:target="_blank"}

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
    #### Fetch the Storage Utilization for PVC Mounts in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to get the disk usage for all of the mounted volumes that are running in a specific namespace on your Kubernetes cluster. It can be broken down into several steps: 
    1. Get the list of pods running in the specified namespace using the command "kubectl get pods -n ${NAMESPACE}"
    2. For each pod, get the list of persistent volume claims (PVCs) associated with it using the command "kubectl get pods $pod -n ${NAMESPACE}"
    3. For each PVC, get the corresponding volume name using the command "kubectl get pod $pod -n ${NAMESPACE}"
    4. With the corresponding volume name, get the mount path that was used and the container name where the volume was mounted. This can be done by using the command "kubectl get pod $pod -n ${NAMESPACE}".
    5. Finally, use the command "kubectl exec $pod -n ${NAMESPACE} --context ${CONTEXT} -c $containerName -- df -h $mountPath" to get the disk usage information for that particular PVC.

    This command is useful in understanding how much disk space each of your PVCs on your Kubernetes cluster is consuming.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock5">```for pod in $(kubectl get pods -n jx --field-selector=status.phase=Running --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do for pvc in $(kubectl get pods $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o jsonpath='{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{"\n"}{end}'); do for volumeName in $(kubectl get pod $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r '.spec.volumes[] | select(has("persistentVolumeClaim")) | .name'); do mountPath=$(kubectl get pod $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r --arg vol "$volumeName" '.spec.containers[].volumeMounts[] | select(.name == $vol) | .mountPath'); containerName=$(kubectl get pod $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -o json | jq -r --arg vol "$volumeName" '.spec.containers[] | select(.volumeMounts[].name == $vol) | .name'); echo -e "\n------------\nPod: $pod, PVC: $pvc, volumeName: $volumeName, containerName: $containerName, mountPath: $mountPath"; kubectl exec $pod -n jx --context gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster -c $containerName -- df -h $mountPath; done; done; done;```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock5" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage5" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            #This command selects, parses and executes commands for each pod in a Kubernetes cluster specified by the given context and namespace. It is intended to provide users with information about disk usage for each persistent incontainer volume. 
            #The one-line command performs multiple operations in order to accomplish its task

            #Break down command into individual steps 
            #Step 1: Get list of pods in cluster with 'kubectl get pods' and apply additional parameters such as fieldselector, namespace and context
            for pod in $(kubectl get pods -n ${NAMESPACE} --field-selector=status.phase=Running --context ${CONTEXT} -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do 

            #Step 2: Loop through each pod and retrieve list of Persistent Volume Claims
                for pvc in $(kubectl get pods $pod -n ${NAMESPACE} --context ${CONTEXT} -o jsonpath='{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{"\n"}{end}'); do 

            #Step 3: For each PVC, grab associated 'volumeName' and its mounting path 'mountPath'
                    for volumeName in $(kubectl get pod $pod -n ${NAMESPACE} --context ${CONTEXT} -o json | jq -r '.spec.volumes[] | select(has("persistentVolumeClaim")) | .name'); do
                        mountPath=$(kubectl get pod $pod -n ${NAMESPACE} --context ${CONTEXT} -o json | jq -r --arg vol "$volumeName" '.spec.containers[].volumeMounts[] | select(.name == $vol) | .mountPath');
                        containerName=$(kubectl get pod $pod -n ${NAMESPACE} --context ${CONTEXT} -o json | jq -r --arg vol "$volumeName" '.spec.containers[] | select(.volumeMounts[].name == $vol) | .name'); 

            #Step 4: Print out associated details of this combination
                        echo -e "\n------------\nPod: $pod, PVC: $pvc, volumeName: $volumeName, containerName: $containerName, mountPath: $mountPath";

            #Step 5: Execute 'df' command in context of each container and folder in PVC 
                        kubectl exec $pod -n ${NAMESPACE} --context ${CONTEXT} -c $containerName -- df -h $mountPath; 
                    done; 
                done; 
            done;

    ???- abstract "Helpful Links"

            
        - [Kubernetes Documentation Overview](https://kubernetes.io/docs/home/){:target="_blank"}
        - [Getting Started - Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/){:target="_blank"}
        - [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/){:target="_blank"}
        - [Using kubectl 'Get' with the JSONPath template](https://kubernetes.io/docs/reference/kubectl/jsonpath/){:target="_blank"}
        - [Container Volumes](https://kubernetes.io/docs/concepts/storage/volumes/){:target="_blank"}
        - [Executing Commands in Containers](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/){:target="_blank"}

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




!!! note ""
    <div class="command-title">
    #### Check for RWO Persistent Volume Node Attachment Issues in Namespace `jx`  
    </div>
    !!! warning ""
    <div class="command-details">
    What does it do?
    </div>
    

    This command is used to check if the pod node and storage node match. To do this, it uses kubectl which is the command line tool for controlling Kubernetes clusters. It sets NAMESPACE and CONTEXT variables that are used in the command. Then, it retrieves all pods in the specified namespace using the get pods command. After that, the information of each pods is looped through with jq. From the information, the name of the persistent volume claim (PVC) is retrieved. The PVC has an access mode, which is compared against the ReadWriteOnce type. If the permission matches, the name of the persistent volume (PV) associated with the PVC will be retrieved along with the nodes where the pod and storage are located. Finally, a comparison takes place between these two nodes. If they match, "OK: Pod and Storage Node Matched" is displayed. Otherwise, "Error: Pod and Storage Node Mismatched - If the issue persists, the node requires attention." will be displayed.
    <div class="command-details">
    Command
    </div>
    <div class="code-block-container">
      <pre class="code-block"><code id="codeBlock6">```NAMESPACE="jx"; CONTEXT="gke_runwhen-nonprod-sandbox_us-central1_sandbox-cluster-1-cluster"; PODS=$(kubectl get pods -n $NAMESPACE --context=$CONTEXT -o json); for pod in $(jq -r '.items[] | @base64' <<< "$PODS"); do _jq() { jq -r ${1} <<< "$(base64 --decode <<< ${pod})"; }; POD_NAME=$(_jq '.metadata.name'); POD_NODE_NAME=$(kubectl get pod $POD_NAME -n $NAMESPACE --context=$CONTEXT -o custom-columns=:.spec.nodeName --no-headers); PVC_NAMES=$(kubectl get pod $POD_NAME -n $NAMESPACE --context=$CONTEXT -o jsonpath='{.spec.volumes[*].persistentVolumeClaim.claimName}'); for pvc_name in $PVC_NAMES; do PVC=$(kubectl get pvc $pvc_name -n $NAMESPACE --context=$CONTEXT -o json); ACCESS_MODE=$(jq -r '.spec.accessModes[0]' <<< "$PVC"); if [[ "$ACCESS_MODE" == "ReadWriteOnce" ]]; then PV_NAME=$(jq -r '.spec.volumeName' <<< "$PVC"); STORAGE_NODE_NAME=$(jq -r --arg pv "$PV_NAME" '.items[] | select(.status.volumesAttached != null) | select(.status.volumesInUse[] | contains($pv)) | .metadata.name' <<< "$(kubectl get nodes --context=$CONTEXT -o json)"); echo "------------"; if [[ "$POD_NODE_NAME" == "$STORAGE_NODE_NAME" ]]; then echo "OK: Pod and Storage Node Matched"; else echo "Error: Pod and Storage Node Mismatched - If the issue persists, the node requires attention."; fi; echo "Pod: $POD_NAME"; echo "PVC: $pvc_name"; echo "PV: $PV_NAME"; echo "Node with Pod: $POD_NODE_NAME"; echo "Node with Storage: $STORAGE_NODE_NAME"; echo; fi; done; done```</code></pre>
    </div>
    <div class="grid-item">
    <a href="#" id="copyCodeBlock6" onclick="return false;"><img class="card-icon" src="https://storage.googleapis.com/runwhen-nonprod-shared-images/icons/content_copy.svg" alt="Icon">Copy to clipboard</a>
    <span id="copiedMessage6" class="copied-message">Copied to clipboard</span>
    </div>
    ???- info "Learn more"
          This multi-line command is auto-generated and used for educational purposes. Copying and pasting the multi-line text might not function as expected.
            
            

            # Define the namespace and context variables for use with kubectl commands
            NAMESPACE="${NAMESPACE}"
            CONTEXT="${CONTEXT}"

            # Retrieve a json list of all pods in the given namespace and store it in a variable
            PODS=$(kubectl get pods -n $NAMESPACE --context=$CONTEXT -o json) 

            # Iterate over each pod entry
            for pod in $(jq -r '.items[] | @base64' <<< "$PODS"); do 

                # Definde an inner function to retrieve info from the base64-encoded pod records
                _jq() { jq -r \${1} <<< "$(base64 --decode <<< \${pod})"; }

                # Store the name of the current pod in a variable
                POD_NAME=$(_jq '.metadata.name')

                # Get the name of the node which is running this pod and store in a variable 
                POD_NODE_NAME=$(kubectl get pod $POD_NAME -n $NAMESPACE --context=$CONTEXT -o custom-columns=:.spec.nodeName --no-headers)
               
                # Get the names of any Persistent Volume Claims associated with this pod
                PVC_NAMES=$(kubectl get pod $POD_NAME -n $NAMESPACE --context=$CONTEXT -o jsonpath='{.spec.volumes[*].persistentVolumeClaim.claimName}')

                # Iterate over each PVC associated with this pod
                for pvc_name in $PVC_NAMES; do 

                    # Get the details of this particular PVC and store them in the 'PVC' variable
                    PVC=$(kubectl get pvc $pvc_name -n $NAMESPACE --context=$CONTEXT -o json)

                    # Extract the access mode setting of this PVC
                    ACCESS_MODE=$(jq -r '.spec.accessModes[0]' <<< "$PVC")
                
                    # If this PVC has a single access setting of ReadWriteOnce
                    if [[ "$ACCESS_MODE" == "ReadWriteOnce" ]]; then 
                        
                        # Get the name of the PV associated with this PVC
                        PV_NAME=$(jq -r '.spec.volumeName' <<< "$PVC")

                        # Retrieve all available nodes and extract the name of the node associated with this storage
                        STORAGE_NODE_NAME=$(jq -r --arg pv "$PV_NAME" '.items[] | select(.status.volumesAttached != null) | select(.status.volumesInUse[] | contains($pv)) | .metadata.name' <<< "$(kubectl get nodes --context=$CONTEXT -o json)")

                        # Output diagnostic information            
                        echo "------------"
                        if [[ "$POD_NODE_NAME" == "$STORAGE_NODE_NAME" ]]; then
                            echo "OK: Pod and Storage Node Matched"
                        else
                            echo "Error: Pod and Storage Node Mismatched - If the issue persists, the node requires attention."
                        fi
                        echo "Pod: $POD_NAME"
                        echo "PVC: $pvc_name"
                        echo "PV: $PV_NAME"
                        echo "Node with Pod: $POD_NODE_NAME"
                        echo "Node with Storage: $STORAGE_NODE_NAME"
                        echo
                    fi
                done
            done

    ???- abstract "Helpful Links"

            
        - [Kubernetes - Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/){:target="_blank"}
        - [Kubernetes - Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/){:target="_blank"}
        - [Kubernetes - kubectl command](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands){:target="_blank"}
        - [Kubernetes - Pod resources](https://kubernetes.io/docs/concepts/workloads/pods/pod/){:target="_blank"}
        - [Kubernetes - PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims){:target="_blank"}
        - [Kubernetes - Access modes for Volume Resources](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes){:target="_blank"}

<script>

document.getElementById('copyCodeBlock6').addEventListener('click', function() {
    copyCodeBlock6();
});

function copyCodeBlock6() {
  var codeBlock = document.getElementById('codeBlock6');
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
  var copiedMessage = document.getElementById('copiedMessage6');
  copiedMessage.classList.add('show');

  setTimeout(function() {
    copiedMessage.classList.remove('show');
  }, 2000);
}
</script>




<script>
document.getElementById('configLink').addEventListener('click', function() {
    showConfig('/workspaces/ws/slxs/jx-grnwhnnprsndbu-pvc-health/runbook.yaml');
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
            title.innerText = "Private configuration for: " + 'jx PVC Healthcheck  ';
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